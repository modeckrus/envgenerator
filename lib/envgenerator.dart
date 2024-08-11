import 'dart:io';

import 'package:envgenerator/config.dart';

class EnvGenerator {
  final Config config;

  EnvGenerator(this.config);
  Future<void> makeTasks() async {
    /// Заменяет содержимое директории.
    if (config.folderReplacement != null && config.folderReplacement!.isNotEmpty) {
      for (var folderReplaceMent in config.folderReplacement ?? []) {
        await replaceDirectoryContents(from: folderReplaceMent.from, to: folderReplaceMent.to);
      }
    }

    /// Заменяет содержимое файла
    if (config.fileReplacement != null && config.fileReplacement!.isNotEmpty) {
      for (var fileReplaceMent in config.fileReplacement ?? []) {
        await replaceFile(from: fileReplaceMent.from, to: fileReplaceMent.to);
      }
    }

    /// Заменяет содержимое строки
    if (config.stringReplacement != null && config.stringReplacement!.isNotEmpty) {
      for (var stringReplaceMent in config.stringReplacement ?? []) {
        await replaceKey(path: stringReplaceMent.path, keys: stringReplaceMent.keys, replacement: stringReplaceMent.replacement);
      }
    }
  }

  /// Заменяет содержимое указанного файла, заменяя все вхождения указанных ключей на указанное значение.
  ///
  /// Аргументы:
  ///
  /// * [path] - путь к файлу, в котором нужно произвести замену.
  /// * [keys] - список ключей, которые нужно заменить.
  /// * [replacement] - новое значение, на которое нужно заменить ключи.
  static Future<void> replaceKey({required String path, required List<String> keys, required String replacement}) async {
    final file = File(path);
    final content = await file.readAsString();

    for (var key in keys) {
      if (content.contains(key)) {
        await file.writeAsString(content.replaceAll(key, replacement));
      }
    }
  }

  /// Заменяет содержимое указанного файла [from] на содержимое файла [to].
  ///
  /// Если файл [to] не существует, то он будет создан.
  ///
  /// Аргументы:
  ///
  /// * [from] - путь к исходному файлу.
  /// * [to] - путь к файлу, на содержимое которого нужно заменить содержимое [from].
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
      print('Исходная директория не существует: $from');
      return;
    }

    // Проверяем, существует ли целевая директория, если да, то очищаем её
    if (await destinationDir.exists()) {
      await destinationDir.delete(recursive: true);
      print('Целевая директория удалена: $to');
    }

    // Создаем новую целевую директорию
    await destinationDir.create(recursive: true);
    print('Создана целевая директория: $to');

    // Копируем файлы и директории из исходной директории в целевую
    await _copyDirectoryContents(sourceDir, destinationDir);
  }

  static Future<void> _copyDirectoryContents(Directory sourceDir, Directory destinationDir) async {
    await for (var entity in sourceDir.list(recursive: true, followLinks: false)) {
      final relativePath = entity.path.substring(sourceDir.path.length + 1);
      final newPath = '${destinationDir.path}/$relativePath';

      if (entity is File) {
        await File(entity.path).copy(newPath);
        print('Скопирован файл: ${entity.path} в $newPath');
      } else if (entity is Directory) {
        await Directory(newPath).create(recursive: true);
        print('Создана директория: $newPath');
      }
    }
  }
}
