import 'dart:io';

import 'package:envgenerator/envgenerator.dart';
import 'package:test/test.dart';

void main() {
  test('Test replacement', () async {
    var keys = ["d59456a8-5fd4-4a29-a3e3-cdd249b8a49b", "lol-lol-lol"];
    var replacement = "d59456a8-5fd4-4a29-a3e3-cdd249b8a49b";
    var path = 'test/project.pbxproj';
    var text = File(path).readAsStringSync();
    await EnvGenerator.replaceKey(
        path: path, keys: keys, replacement: replacement);
    text = File(path).readAsStringSync();
    expect(text.contains(replacement), true);
    expect(text.contains(keys[0]), false);
  });
}
