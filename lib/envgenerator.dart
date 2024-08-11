import 'dart:developer';
import 'dart:io';

import 'package:envgenerator/config.dart';

class EnvGenerator {
  final Config config;

  EnvGenerator(this.config);
  Future<void> makeTasks() async {
    for (var stringReplaceMent in config.stringReplacement) {
      await replaceKey(path: stringReplaceMent.path, keys: stringReplaceMent.keys, replacement: stringReplaceMent.replacement);
    }

    for (var fileReplaceMent in config.fileReplacement) {
      await replaceFile(from: fileReplaceMent.from, to: fileReplaceMent.to);
    }
    if (config.folderReplacement != null && config.folderReplacement!.isNotEmpty) {
      for (var folderReplaceMent in config.folderReplacement ?? []) {
        await replaceDirectoryContents(from: folderReplaceMent.from, to: folderReplaceMent.to);
      }
    }
  }

  static Future<void> replaceKey({required String path, required List<String> keys, required String replacement}) async {
    final file = File(path);
    final content = await file.readAsString();

    for (var key in keys) {
      if (content.contains(key)) {
        await file.writeAsString(content.replaceAll(key, replacement));
      }
    }
  }

  static Future<void> replaceFile({required String from, required String to}) async {
    final file = File(from);
    final content = await file.readAsString();
    final toFile = File(to);
    if (!await toFile.exists()) {
      await toFile.create(recursive: true);
    }
    await File(to).writeAsString(content);
  }

  /// Заменяет содержимое директории.
  ///
  /// Аргументы:
  ///
  /// * [from] - путь к исходной директории.
  /// * [to] - путь к целевой директории.
  static Future<void> replaceDirectoryContents({required String from, required String to}) async {
    final sourceDir = Directory(from);
    final destinationDir = Directory(to);

    // Проверяем, существует ли исходная директория
    if (!await sourceDir.exists()) {
      log('Исходная директория не существует: $from');
      return;
    }

    // Проверяем, существует ли целевая директория, если да, то очищаем её
    if (await destinationDir.exists()) {
      await destinationDir.delete(recursive: true);
      log('Целевая директория удалена: $to');
    }

    // Создаем новую целевую директорию
    await destinationDir.create(recursive: true);
    log('Создана целевая директория: $to');

    // Копируем файлы из исходной директории в целевую
    List<FileSystemEntity> files = sourceDir.listSync();
    for (var file in files) {
      if (file is File) {
        String basename = file.uri.pathSegments.last;
        File destinationFile = File('${destinationDir.path}/$basename');

        // Копируем файл
        await file.copy(destinationFile.path);
        log('Скопирован файл: ${file.path} в ${destinationFile.path}');
      }
    }
  }
}
