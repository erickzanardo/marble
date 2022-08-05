import 'dart:io';

import 'package:args/command_runner.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:path/path.dart' as path;

/// {@template build_command}
///
/// `marble_cli build`
/// A [Command] to exemplify a sub command
/// {@endtemplate}
class BuildCommand extends Command<int> {
  /// {@macro build_command}
  BuildCommand({
    Logger? logger,
  }) : _logger = logger ?? Logger() {
    //argParser.addFlag(
    //  'cyan',
    //  abbr: 'c',
    //  help: 'Prints the same joke, but in cyan',
    //  negatable: false,
    //);
  }

  @override
  String get description => 'builds a marble site';

  @override
  String get name => 'build';

  final Logger _logger;

  @override
  Future<int> run() async {
    final currentDir = Directory.current;
    final pubspec = File(path.join(currentDir.path, 'pubspec.yaml'));

    if (!pubspec.existsSync()) {
      _logger.err('No pubspec.yaml found in current directory');
      return ExitCode.usage.code;
    }

    final files = await processFolder(
      Directory(path.join(currentDir.path, 'pages')),
    );

    final marbleFile = File(path.join(currentDir.path, '.marble.dart'));
    if (marbleFile.existsSync()) {
      marbleFile.deleteSync();
    }

    final buildFolder = Directory(path.join(currentDir.path, 'build'));
    if (buildFolder.existsSync()) {
      buildFolder.deleteSync(recursive: true);
    }

    final imports = StringBuffer();
    final content = StringBuffer();
    for (final file in files) {
      final fileName = path.basenameWithoutExtension(file);
      imports.write(
        "import '.${file.replaceFirst(currentDir.path, '')}' as $fileName;",
      );

      content.write(
        '''
        await File('${file.replaceFirst('pages', 'build').replaceFirst('dart', 'html')}')
          ..createSync(recursive: true)
          ..writeAsString(
            $fileName.page.render(),
        );
      ''',
      );
    }

    await marbleFile.writeAsString(
      '''
        import 'dart:io';
        ${imports.toString()}
        void main() async {
        ${content.toString()}
        }
    ''',
    );

    final result = Process.runSync('dart', ['.marble.dart']);
    if (result.exitCode != 0) {
      _logger.err('Error building site: ${result.stderr}');
      return ExitCode.software.code;
    }

    _logger.success('Marble site built!');

    return ExitCode.success.code;
  }
}

Future<List<String>> processFolder(Directory dir) async {
  final entries = dir.listSync();
  final files = <String>[];

  for (final entry in entries) {
    final stat = await entry.stat();
    if (stat.type == FileSystemEntityType.directory) {
      files.addAll(await processFolder(Directory(entry.path)));
    } else {
      files.add(entry.path);
    }
  }

  return files;
}
