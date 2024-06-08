// parse command line options
var argv = require('minimist')(process.argv.slice(2));

// modules
var fs = require('fs');
var os = require('os');
var path = require('path');
var semver = require('semver');
var util = require('./make-util');
var admzip = require('adm-zip');

// util functions
var cd = util.cd;
var cp = util.cp;
var mkdir = util.mkdir;
var rm = util.rm;
var test = util.test;
var run = util.run;
var banner = util.banner;
var rp = util.rp;
var fail = util.fail;
var ensureExists = util.ensureExists;
var pathExists = util.pathExists;
var buildNodeTask = util.buildNodeTask;
var addPath = util.addPath;
var copyTaskResources = util.copyTaskResources;
var matchFind = util.matchFind;
var matchCopy = util.matchCopy;
var ensureTool = util.ensureTool;
var assert = util.assert;
var getExternalsAsync = util.getExternalsAsync;
var createResjson = util.createResjson;
var createTaskLocJson = util.createTaskLocJson;
var validateTask = util.validateTask;
var fileToJson = util.fileToJson;
var createYamlSnippetFile = util.createYamlSnippetFile;
var createMarkdownDocFile = util.createMarkdownDocFile;
var getTaskNodeVersion = util.getTaskNodeVersion;
var writeUpdatedsFromGenTasks = false;

// global paths
var buildPath = path.join(__dirname, '_build');
var buildTasksPath = path.join(__dirname, '_build', '');
var buildTestsPath = path.join(__dirname, '_build', 'Tests');
var buildTasksCommonPath = path.join(__dirname, '_build', '', 'Common');
var testsLegacyPath = path.join(__dirname, 'Tests-Legacy');
var tasksPath = path.join(__dirname, '');
var testsPath = path.join(__dirname, 'Tests');
var testPath = path.join(__dirname, '_test');
var legacyTestTasksPath = path.join(__dirname, '_test', '');
var testTestsLegacyPath = path.join(__dirname, '_test', 'Tests-Legacy');
var binPath = path.join(__dirname, 'node_modules', '.bin');
var makeOptionsPath = path.join(__dirname, 'make-options.json');
var gendocsPath = path.join(__dirname, '_gendocs');
var packagePath = path.join(__dirname, '_package');
var coverageTasksPath = path.join(buildPath, 'coverage');
var baseConfigToolPath = path.join(__dirname, 'BuildConfigGen');
var genTaskPath = path.join(__dirname, '_generated');
var genTaskCommonPath = path.join(__dirname, '_generated', 'Common');

var CLI = {};

// node min version
var minNodeVer = '10.24.1';
if (semver.lt(process.versions.node, minNodeVer)) {
    fail('requires node >= ' + minNodeVer + '.  installed: ' + process.versions.node);
}

// Node 14 is supported by the build system, but not currently by the agent. Block it for now
var supportedNodeTargets = ["Node", "Node10"/*, "Node14"*/];
var node10Version = '10.24.1';
var node20Version = '20.11.0';


// add node modules .bin to the path so we can dictate version of tsc etc...
if (!test('-d', binPath)) {
    fail('node modules bin not found.  ensure npm install has been run.');
}
addPath(binPath);

// resolve list of tasks
var taskList;
if (argv.task) {
    // find using --task parameter
    taskList = matchFind(argv.task, tasksPath, { noRecurse: true, matchBase: true })
        .map(function (item) {
            return path.basename(item);
        });

    // If base tasks was not found, try to find the task in the _generated tasks folder
    if (taskList.length == 0 && fs.existsSync(genTaskPath)) {
        taskList = matchFind(argv.task, genTaskPath, { noRecurse: true, matchBase: true })
            .map(function (item) {
                return path.basename(item);
            });
    }

    if (!taskList.length) {
        fail('Unable to find any tasks matching pattern ' + argv.task);
    }
} else {
    // load the default list
    taskList = fileToJson(makeOptionsPath).tasks;
}

function getTaskList(taskList) {
    let tasksToBuild = taskList;

    if (!fs.existsSync(genTaskPath)) return tasksToBuild;

    const generatedTaskFolders = fs.readdirSync(genTaskPath)
        .filter((taskName) => {
            return fs.statSync(path.join(genTaskPath, taskName)).isDirectory();
        });

    taskList.forEach((taskName) => {
        generatedTaskFolders.forEach((generatedTaskName) => {
            if (taskName !== generatedTaskName && generatedTaskName.startsWith(taskName)) {
                tasksToBuild.push(generatedTaskName);
            }
        });
    });

    return tasksToBuild.sort();
}

CLI.build = async function(/** @type {{ task: string }} */ argv) 
{
    if (process.env.TF_BUILD) {
        fail('Please use serverBuild for CI builds for proper validation');
    }

    writeUpdatedsFromGenTasks = true;
    await CLI.serverBuild(argv);
}

CLI.serverBuild = async function(/** @type {{ task: string }} */ argv) {

    const allTasks = getTaskList(taskList);

    // Wrap build function  to store files that changes after the build 
    const buildTaskWrapped = util.syncGeneratedFilesWrapper(buildTaskAsync, genTaskPath, writeUpdatedsFromGenTasks);
    const { allTasksNode20, allTasksDefault } = allTasks.
        reduce((res, taskName) => {
            if (getNodeVersion(taskName) == 20) {
                res.allTasksNode20.push(taskName)
            } else {
                res.allTasksDefault.push(taskName)
            }

            return res;
        }, {allTasksNode20: [], allTasksDefault: []})
    
    if (allTasksNode20.length > 0) {
        //await util.installNodeAsync('20');
        //ensureTool('node', '--version', `v${node20Version}`);
        for (const taskName of allTasksNode20) {
            await buildTaskWrapped(taskName, allTasksNode20.length, 20);
        }
    } 
    if (allTasksDefault.length > 0) {
        //await util.installNodeAsync('10');
        //ensureTool('node', '--version', `v${node10Version}`);
        for (const taskName of allTasksDefault) {
            await buildTaskWrapped(taskName, allTasksNode20.length, 10);
        }
    }

    banner('Build successful', true);
}

function getNodeVersion (taskName) {
    let taskPath = tasksPath;
    // if task exists inside gen folder prefere it
    if (fs.existsSync(path.join(genTaskPath, taskName))) {
        taskPath = genTaskPath;
    }

    // get node runner from task.json
    const handlers = getTaskNodeVersion(taskPath, taskName);
    if (handlers.includes(20)) return 20;

    return 10;

}

async function buildTaskAsync(taskName, taskListLength, nodeVersion) {
    let isGeneratedTask = false;
    banner(`Building task ${taskName} using Node.js ${nodeVersion}`);
    const removeNodeModules = taskListLength > 1;

    // If we have the task in generated folder, prefer to build from there and add all generated tasks which starts with task name
    var taskPath = path.join(genTaskPath, taskName);
    if (fs.existsSync(taskPath)) {
        // Need to add all tasks which starts with task name
        console.log('Found generated task: ' + taskName);
        isGeneratedTask = true;
    } else {
        taskPath = path.join(tasksPath, taskName);
    }

    ensureExists(taskPath);

    // load the task.json
    var outDir;
    var shouldBuildNode = test('-f', path.join(taskPath, 'tsconfig.json'));
    var taskJsonPath = path.join(taskPath, 'task.json');
    if (test('-f', taskJsonPath)) {
        var taskDef = fileToJson(taskJsonPath);
        validateTask(taskDef);

        // fixup the outDir (required for relative pathing in legacy L0 tests)
        outDir = path.join(buildTasksPath, taskName);

        if(fs.existsSync(outDir))
        {
            console.log('Remove existing outDir: ' + outDir);
            rm('-rf', outDir);
        }

        // create loc files
        createTaskLocJson(taskPath);
        createResjson(taskDef, taskPath);

        // determine the type of task
        shouldBuildNode = shouldBuildNode || supportedNodeTargets.some(node => taskDef.execution.hasOwnProperty(node));
    } else {
        outDir = path.join(buildTasksPath, path.basename(taskPath));
    }

    mkdir('-p', outDir);

    // get externals
    var taskMakePath = path.join(taskPath, 'make.json');
    var taskMake = test('-f', taskMakePath) ? fileToJson(taskMakePath) : {};
    if (taskMake.hasOwnProperty('externals')) {
        console.log('');
        console.log('> getting task externals');
        await getExternalsAsync(taskMake.externals, outDir);
    }


    //--------------------------------
    // Common: build, copy, install
    //--------------------------------
    var commonPacks = [];
    if (taskMake.hasOwnProperty('common')) {
        var common = taskMake['common'];

        for (const mod of common) {
            var modPath = path.join(taskPath, mod['module']);
            var modName = path.basename(modPath);
            var modOutDir = path.join(buildTasksCommonPath, modName);

            if (!test('-d', modOutDir)) {
                banner('Building module ' + modPath, true);

                // Ensure that Common folder exists for _generated tasks, otherwise copy it from Tasks folder
                if (!fs.existsSync(genTaskCommonPath) && isGeneratedTask) {
                    cp('-Rf', path.resolve(tasksPath, "Common"), genTaskCommonPath);
                }

                mkdir('-p', modOutDir);

                // create loc files
                var modJsonPath = path.join(modPath, 'module.json');
                if (test('-f', modJsonPath)) {
                    createResjson(fileToJson(modJsonPath), modPath);
                }

                // npm install and compile
                // if ((mod.type === 'node' && mod.compile == true) || test('-f', path.join(modPath, 'tsconfig.json'))) {
                //     buildNodeTask(modPath, modOutDir);
                // }

                // copy default resources and any additional resources defined in the module's make.json
                console.log();
                console.log('> copying module resources');
                var modMakePath = path.join(modPath, 'make.json');
                var modMake = test('-f', modMakePath) ? fileToJson(modMakePath) : {};
                copyTaskResources(modMake, modPath, modOutDir);

                // get externals
                if (modMake.hasOwnProperty('externals')) {
                    console.log('');
                    console.log('> getting module externals');
                    await getExternalsAsync(modMake.externals, modOutDir);
                }

                if (mod.type === 'node' && mod.compile == true || test('-f', path.join(modPath, 'package.json'))) {
                    var commonPack = util.getCommonPackInfo(modOutDir);

                    // assert the pack file does not already exist (name should be unique)
                    if (test('-f', commonPack.packFilePath)) {
                        fail(`Pack file already exists: ${commonPack.packFilePath}`);
                    }

                    // pack the Node module. a pack file is required for dedupe.
                    // installing from a folder creates a symlink, and does not dedupe.
                    cd(path.dirname(modOutDir));
                    run(`npm pack ./${path.basename(modOutDir)}`);
                }
            }

            // store the npm pack file info
            if (mod.type === 'node' && mod.compile == true) {
                commonPacks.push(util.getCommonPackInfo(modOutDir));
            // copy ps module resources to the task output dir
            } else if (mod.type === 'ps') {
                console.log();
                console.log('> copying ps module to task');
                var dest;
                if (mod.hasOwnProperty('dest')) {
                    dest = path.join(outDir, mod.dest, modName);
                } else {
                    dest = path.join(outDir, 'ps_modules', modName);
                }

                matchCopy('!Tests', modOutDir, dest, { noRecurse: true, matchBase: true });
            }
        }

        // npm install the common modules to the task dir
        if (commonPacks.length) {
            cd(taskPath);
            var installPaths = commonPacks.map(function (commonPack) {
                return `file:${path.relative(taskPath, commonPack.packFilePath)}`;
            });
            run(`npm install --save-exact ${installPaths.join(' ')}`);
        }
    }

}



CLI.build({ task: "deployDataFactoryTask" });