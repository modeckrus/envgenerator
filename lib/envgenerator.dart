// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:envgenerator/config.dart';

class EnvGenerator {
  final Config config;

  EnvGenerator(this.config);
  Future<void> makeTasks() async {
    for (var stringReplaceMent in config.stringReplacement) {
      await replaceKey(
          path: stringReplaceMent.path,
          keys: stringReplaceMent.keys,
          replacement: stringReplaceMent.replacement);
    }

    for (var fileReplaceMent in config.fileReplacememnt) {
      await replaceFile(from: fileReplaceMent.from, to: fileReplaceMent.to);
    }
  }

  static Future<void> replaceKey(
      {required String path,
      required List<String> keys,
      required String replacement}) async {
    final file = File(path);
    final content = await file.readAsString();

    for (var key in keys) {
      if (content.contains(key)) {
        await file.writeAsString(content.replaceAll(key, replacement));
      }
    }
  }

  static Future<void> replaceFile(
      {required String from, required String to}) async {
    final file = File(from);
    final content = await file.readAsString();
    final toFile = File(to);
    if (!await toFile.exists()) {
      await toFile.create(recursive: true);
    }
    await File(to).writeAsString(content);
  }
}
