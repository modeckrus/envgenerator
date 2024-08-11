import 'dart:io';

import 'package:envgenerator/envgenerator.dart';
import 'package:test/test.dart';

void main() {
  test('Test replacement', () async {
    var keys = ["d59456a8-5fd4-4a29-a3e3-cdd249b8a49b", "lol-lol-lol"];
    var replacement = "d59456a8-5fd4-4a29-a3e3-cdd249b8a49b";
    var path = 'test/project.pbxproj';
    var text = File(path).readAsStringSync();
    await EnvGenerator.replaceKey(path: path, keys: keys, replacement: replacement);
    text = File(path).readAsStringSync();
    expect(text.contains(replacement), true);
    expect(text.contains(keys[0]), false);
  });

  test('folder replacement test', () async {
    var folderTo = 'test_folder';
    var folderFrom = 'test2/test';
    await EnvGenerator.replaceDirectoryContents(from: folderFrom, to: folderTo);
    expect(Directory(folderTo).existsSync(), true);
    expect(Directory(folderFrom).existsSync(), false);
  });

  group('replaceDirectoryContents', () {
    final testSourceDir = Directory('test2/test');
    final testDestinationDir = Directory('test_folder/test');

    setUp(() async {
      await testSourceDir.create();
      await File('${testSourceDir.path}/test_file.txt').writeAsString('Test content');
      await Directory('${testSourceDir.path}/sub_dir').create();
      await File('${testSourceDir.path}/sub_dir/test_file2.txt').writeAsString('Sub directory content');
    });

    tearDown(() async {
      if (await testSourceDir.exists()) await testSourceDir.delete(recursive: true);
      if (await testDestinationDir.exists()) await testDestinationDir.delete(recursive: true);
    });

    test('should replace directory contents correctly', () async {
      await EnvGenerator.replaceDirectoryContents(from: testSourceDir.path, to: testDestinationDir.path);

      expect(await testDestinationDir.exists(), isTrue);
      expect(await File('${testDestinationDir.path}/test_file.txt').exists(), isTrue);
      expect(await Directory('${testDestinationDir.path}/sub_dir').exists(), isTrue);
      expect(await File('${testDestinationDir.path}/sub_dir/test_file2.txt').exists(), isTrue);
    });

    test('should handle non-existent source directory', () async {
      final nonExistentDir = Directory('non_existent');

      await EnvGenerator.replaceDirectoryContents(from: nonExistentDir.path, to: testDestinationDir.path);

      expect(await testDestinationDir.exists(), isFalse);
    });
  });
}
