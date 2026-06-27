import 'dart:io';
import 'dart:isolate';

Future<void> runArcaneJasprDemo(List<String> args) async {
  final ArcaneJasprDemoRunner runner = ArcaneJasprDemoRunner(args: args);
  exitCode = await runner.run();
}

class ArcaneJasprDemoRunner {
  static const int port = 8080;
  static const int webPort = 5467;
  static const int proxyPort = 5567;
  static const int vmServicePort = 8181;

  final List<String> args;

  const ArcaneJasprDemoRunner({required this.args});

  Future<int> run() async {
    final Directory packageRootDirectory = await _packageRootDirectory();
    final Directory demoDirectory = Directory(
      '${packageRootDirectory.path}/arcane_jaspr_docs/arcane_jaspr_docs_web',
    );

    if (!demoDirectory.existsSync()) {
      stderr.writeln(
        'Arcane Jaspr demo directory was not found: ${demoDirectory.path}',
      );
      return 64;
    }

    if (_isKillall) {
      await _DemoProcessCleaner(
        workingDirectory: demoDirectory,
        ports: <int>[port, webPort, proxyPort, vmServicePort],
        commandMarkers: _commandMarkers(packageRootDirectory),
      ).clean();
      return 0;
    }

    final List<String> jasprArgs = _jasprArgs;
    if (_isServe(jasprArgs)) {
      await _DemoProcessCleaner(
        workingDirectory: demoDirectory,
        ports: _portsFor(jasprArgs),
        commandMarkers: _commandMarkers(packageRootDirectory),
      ).clean();
    }

    final List<String> command = <String>[
      'pub',
      'global',
      'run',
      'jaspr_cli:jaspr',
      ...jasprArgs,
    ];
    final Process process = await Process.start(
      Platform.resolvedExecutable,
      command,
      workingDirectory: demoDirectory.path,
      mode: ProcessStartMode.inheritStdio,
    );
    return process.exitCode;
  }

  List<String> get _jasprArgs {
    if (args.isEmpty) {
      return <String>[
        'serve',
        '--port',
        '$port',
        '--web-port',
        '$webPort',
        '--proxy-port',
        '$proxyPort',
      ];
    }

    if (!_isServe(args)) {
      return args;
    }

    return _withServePorts(args);
  }

  Future<Directory> _packageRootDirectory() async {
    final Uri? packageConfigUri = await Isolate.packageConfig;
    if (packageConfigUri == null) {
      return Directory.current.absolute;
    }
    final File packageConfigFile = File.fromUri(packageConfigUri);
    final Directory packageRootDirectory = packageConfigFile.parent.parent;
    if (_hasPackagePubspec(packageRootDirectory)) {
      return packageRootDirectory;
    }

    Directory currentDirectory = Directory.current.absolute;
    while (currentDirectory.parent.path != currentDirectory.path) {
      if (_hasPackagePubspec(currentDirectory)) {
        return currentDirectory;
      }
      currentDirectory = currentDirectory.parent;
    }
    return packageRootDirectory;
  }

  bool _hasPackagePubspec(Directory directory) {
    final File pubspecFile = File('${directory.path}/pubspec.yaml');
    if (!pubspecFile.existsSync()) {
      return false;
    }
    final String content = pubspecFile.readAsStringSync();
    return RegExp(
      r'^name:\s*arcane_jaspr\s*$',
      multiLine: true,
    ).hasMatch(content);
  }

  List<int> _portsFor(List<String> jasprArgs) {
    final List<int> ports = <int>[port, webPort, proxyPort];
    if (!jasprArgs.contains('--release')) {
      ports.add(vmServicePort);
    }
    return ports;
  }

  bool get _isKillall => args.isNotEmpty && args.first == 'killall';

  bool _isServe(List<String> jasprArgs) =>
      jasprArgs.isEmpty || jasprArgs.first == 'serve';

  List<String> _withServePorts(List<String> jasprArgs) {
    final List<String> nextArgs = <String>[...jasprArgs];
    if (!_hasOption(nextArgs, '--port')) {
      nextArgs.addAll(<String>['--port', '$port']);
    }
    if (!_hasOption(nextArgs, '--web-port')) {
      nextArgs.addAll(<String>['--web-port', '$webPort']);
    }
    if (!_hasOption(nextArgs, '--proxy-port')) {
      nextArgs.addAll(<String>['--proxy-port', '$proxyPort']);
    }
    return nextArgs;
  }

  bool _hasOption(List<String> values, String option) {
    for (String value in values) {
      if (value == option || value.startsWith('$option=')) {
        return true;
      }
    }
    return false;
  }

  List<String> _commandMarkers(Directory packageRootDirectory) => <String>[
    '${packageRootDirectory.path}/tool/arcane_jaspr_demo.dart',
    'tool/arcane_jaspr_demo.dart',
    '../../tool/arcane_jaspr_demo.dart',
    'arcane_jaspr_demo.dart',
    'arcane_jaspr:serve',
    'bin/serve.dart',
  ];
}

class _DemoProcessCleaner {
  final Directory workingDirectory;
  final List<int> ports;
  final List<String> commandMarkers;

  const _DemoProcessCleaner({
    required this.workingDirectory,
    required this.ports,
    required this.commandMarkers,
  });

  Future<void> clean() async {
    final Map<int, _ProcessInfo> processes = await _listProcesses();
    final Set<int> protectedPids = _protectedPids(processes);
    final Set<int> targetPids = await _targetPids(processes, protectedPids);
    final Set<int> expandedPids = _withDescendants(processes, targetPids);
    expandedPids.removeAll(protectedPids);
    await _killPids(processes, expandedPids);
    await Future<void>.delayed(const Duration(milliseconds: 250));
  }

  Future<Map<int, _ProcessInfo>> _listProcesses() async {
    final ProcessResult result = await Process.run('ps', <String>[
      '-axo',
      'pid=,ppid=,command=',
    ]);
    final Map<int, _ProcessInfo> processes = <int, _ProcessInfo>{};
    if (result.exitCode != 0) {
      return processes;
    }

    final List<String> lines = result.stdout.toString().split('\n');
    final RegExp rowPattern = RegExp(r'^\s*(\d+)\s+(\d+)\s+(.*)$');
    for (String line in lines) {
      final RegExpMatch? match = rowPattern.firstMatch(line);
      if (match == null) {
        continue;
      }
      final int? processId = int.tryParse(match.group(1) ?? '');
      final int? parentProcessId = int.tryParse(match.group(2) ?? '');
      final String command = match.group(3) ?? '';
      if (processId == null || parentProcessId == null) {
        continue;
      }
      processes[processId] = _ProcessInfo(
        pid: processId,
        parentPid: parentProcessId,
        command: command,
      );
    }
    return processes;
  }

  Set<int> _protectedPids(Map<int, _ProcessInfo> processes) {
    final Set<int> values = <int>{pid};
    int cursor = pid;
    while (processes.containsKey(cursor)) {
      final _ProcessInfo process = processes[cursor]!;
      if (process.parentPid <= 1 || values.contains(process.parentPid)) {
        break;
      }
      values.add(process.parentPid);
      cursor = process.parentPid;
    }
    return values;
  }

  Future<Set<int>> _targetPids(
    Map<int, _ProcessInfo> processes,
    Set<int> protectedPids,
  ) async {
    final Set<int> values = <int>{};
    for (int port in ports) {
      values.addAll(await _pidsListeningOn(port));
    }

    for (_ProcessInfo process in processes.values) {
      if (protectedPids.contains(process.pid)) {
        continue;
      }
      if (_isTargetCommand(process.command)) {
        values.add(process.pid);
      }
    }
    values.removeAll(protectedPids);
    return values;
  }

  Future<Set<int>> _pidsListeningOn(int port) async {
    final ProcessResult result = await Process.run('lsof', <String>[
      '-tiTCP:$port',
      '-sTCP:LISTEN',
    ]);
    final Set<int> values = <int>{};
    if (result.exitCode != 0) {
      return values;
    }

    final List<String> pidValues = _splitPids(result.stdout.toString());
    for (String pidValue in pidValues) {
      final int? processId = int.tryParse(pidValue);
      if (processId != null) {
        values.add(processId);
      }
    }
    return values;
  }

  bool _isTargetCommand(String command) {
    if (command.contains(
      '${workingDirectory.path}/.dart_tool/jaspr/server_target.dart',
    )) {
      return true;
    }
    if (command.contains(
      '${workingDirectory.path}/.dart_tool/build/entrypoint/build.dart.aot',
    )) {
      return true;
    }
    if (_isJasprServeCommand(command)) {
      return true;
    }
    for (String marker in commandMarkers) {
      if (command.contains(marker)) {
        return true;
      }
    }
    return false;
  }

  bool _isJasprServeCommand(String command) =>
      command.contains('jaspr_cli:jaspr') &&
      command.contains(' serve ') &&
      _commandMentionsWorkingDirectory(command);

  bool _commandMentionsWorkingDirectory(String command) =>
      command.contains(workingDirectory.path) ||
      command.contains('/arcane_jaspr_docs/arcane_jaspr_docs_web/');

  Set<int> _withDescendants(
    Map<int, _ProcessInfo> processes,
    Set<int> targetPids,
  ) {
    final Set<int> values = <int>{...targetPids};
    bool changed = true;
    while (changed) {
      changed = false;
      for (_ProcessInfo process in processes.values) {
        if (values.contains(process.parentPid) &&
            !values.contains(process.pid)) {
          values.add(process.pid);
          changed = true;
        }
      }
    }
    return values;
  }

  Future<void> _killPids(
    Map<int, _ProcessInfo> processes,
    Set<int> processIds,
  ) async {
    if (processIds.isEmpty) {
      return;
    }

    final List<int> orderedPids = processIds.toList()
      ..sort(
        (int a, int b) => _depth(processes, b).compareTo(_depth(processes, a)),
      );

    for (int processId in orderedPids) {
      Process.killPid(processId, ProcessSignal.sigterm);
    }
    await Future<void>.delayed(const Duration(milliseconds: 350));
    final Map<int, _ProcessInfo> refreshedProcesses = await _listProcesses();
    for (int processId in orderedPids) {
      if (refreshedProcesses.containsKey(processId)) {
        Process.killPid(processId, ProcessSignal.sigkill);
      }
    }
  }

  int _depth(Map<int, _ProcessInfo> processes, int processId) {
    int value = 0;
    int cursor = processId;
    final Set<int> visited = <int>{};
    while (processes.containsKey(cursor) && !visited.contains(cursor)) {
      visited.add(cursor);
      cursor = processes[cursor]!.parentPid;
      value++;
    }
    return value;
  }

  List<String> _splitPids(String output) => output
      .split(RegExp(r'\s+'))
      .map((String value) => value.trim())
      .where((String value) => value.isNotEmpty)
      .toList();
}

class _ProcessInfo {
  final int pid;
  final int parentPid;
  final String command;

  const _ProcessInfo({
    required this.pid,
    required this.parentPid,
    required this.command,
  });
}
