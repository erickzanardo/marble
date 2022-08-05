import 'dart:io';

import 'package:marble_cli/src/command_runner.dart';
import 'package:marble_cli/src/commands/commands.dart';
import 'package:marble_cli/src/version.dart';
import 'package:mason_logger/mason_logger.dart';
import 'package:mocktail/mocktail.dart';
import 'package:path/path.dart' as path;
import 'package:pub_updater/pub_updater.dart';
import 'package:test/test.dart';

class MockLogger extends Mock implements Logger {}

class MockPubUpdater extends Mock implements PubUpdater {}

void main() {
  group('build', () {
    late PubUpdater pubUpdater;
    late Logger logger;
    late MarbleCliCommandRunner commandRunner;
    late Directory dir;
    final cwd = Directory.current;

    setUp(() async {
      pubUpdater = MockPubUpdater();

      when(
        () => pubUpdater.getLatestVersion(any()),
      ).thenAnswer((_) async => packageVersion);

      logger = MockLogger();
      commandRunner = MarbleCliCommandRunner(
        logger: logger,
        pubUpdater: pubUpdater,
      );

      dir = Directory(
        path.join(
          Directory.systemTemp.path,
          'marble_cli_test',
        ),
      );

      if (dir.existsSync()) {
        await dir.delete(recursive: true);
      }

      await dir.create();
      Directory.current = dir;
    });

    Future<void> _createPubspec() async {
      await File(
        path.join(dir.path, 'pubspec.yaml'),
      ).writeAsString(
        '''
name: marble_cli_test

environment:
  sdk: '>=2.10.0 <3.0.0'

dependencies:
  marble:
    path: ${cwd.path.replaceFirst('marble_cli', 'marble')}
''',
      );
    }

    Future<void> _createPages(String page, [String? p1]) async {
      await Directory(
        path.join(dir.path, page, p1),
      ).create();
    }

    Future<void> _createPagesFolder() => _createPages('pages');

    Future<void> _createBuildFolder() async => _createPages('build');

    Future<void> _createFile(
      String path,
      String content,
      ) async {
      final file = File(path);
      await file.create();
      await file.writeAsString(content);
    }

    Future<void> _createBuildFile() async => _createFile('.marble.dart', '');

    Future<void> _createPage(String name, String value) async {
      await File(
        path.join(dir.path, 'pages', name),
      ).writeAsString(value);
    }

    Future<void> _pubget() async {
      await Process.run(
        'dart',
        ['pub', 'get'],
        workingDirectory: dir.path,
      );
    }

    test('can be instantiated without explicit logger', () {
      final command = BuildCommand();
      expect(command, isNotNull);
    });

    test('runs successfully', () async {
      await _createPubspec();
      await _createPagesFolder();

      final exitCode = await commandRunner.run(['build']);

      expect(exitCode, ExitCode.success.code);
    });

    test('runs successfully when a build file already exists', () async {
      await _createPubspec();
      await _createPagesFolder();
      await _createBuildFile();

      final exitCode = await commandRunner.run(['build']);

      expect(exitCode, ExitCode.success.code);
    });

    test('runs successfully when a build folder already exists', () async {
      await _createPubspec();
      await _createPagesFolder();
      await _createBuildFolder();

      final exitCode = await commandRunner.run(['build']);

      expect(exitCode, ExitCode.success.code);
    });

    test('creates the build file', () async {
      await _createPubspec();
      await _createPagesFolder();

      await commandRunner.run(['build']);

      final buildFile = File(path.join(dir.path, '.marble.dart'));
      expect(buildFile.existsSync(), isTrue);
    });

    test('generates the file', () async {
      await _createPubspec();
      await _createPagesFolder();
      await _createPage(
        'index.dart',
        '''
          import 'package:marble/marble.dart';

          final page = Text('Hello World');
          ''',
      );
      await _pubget();

      await commandRunner.run(['build']);

      final pageFile = File(path.join(dir.path, 'build', 'index.html'));
      expect(pageFile.existsSync(), isTrue);

      final content = await pageFile.readAsString();
      expect(content, equals('Hello World'));
    });

    test('generates nested files', () async {
      await _createPubspec();
      await _createPages('pages');
      await _createPages('pages', 'bla');
      await _createFile(
        path.join('pages', 'bla', 'index.dart'),
        '''
          import 'package:marble/marble.dart';

          final page = Text('Hello World');
          ''',
      );
      await _pubget();

      await commandRunner.run(['build']);

      final pageFile = File(path.join(dir.path, 'build', 'bla', 'index.html'));
      expect(pageFile.existsSync(), isTrue);

      final content = await pageFile.readAsString();
      expect(content, equals('Hello World'));
    });

    test(
      'returns ExitCode.usage.code when the folder has no pubspec',
      () async {
        await _createPagesFolder();

        final exitCode = await commandRunner.run(['build']);

        expect(exitCode, ExitCode.usage.code);
      },
    );

    test(
      'returns ExitCode.software.code when build fails for some reason',
      () async {
        await _createPubspec();
        await _createPagesFolder();
        await _createPage(
          'index.dart',
          '''
        This is not a valid code
          ''',
        );
        await _pubget();

        final code = await commandRunner.run(['build']);
        expect(code, equals(ExitCode.software.code));
      },
    );
  });
}
