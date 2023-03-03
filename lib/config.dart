import 'dart:convert';
import 'dart:io';

import 'package:json_annotation/json_annotation.dart';

part 'config.g.dart';

@JsonSerializable(createToJson: false)
class Config {
  Config({
    required this.fileReplacememnt,
    required this.stringReplacement,
  });
  @JsonKey(name: 'file_replacememnt')
  final FileReplacememnt fileReplacememnt;
  @JsonKey(name: 'string_replacement')
  final StringReplacement stringReplacement;

  factory Config.fromJson(Map<String, dynamic> json) => _$ConfigFromJson(json);
  factory Config.fromPath(String path) {
    final content = File(path).readAsStringSync();
    final map = jsonDecode(content) as Map<String, dynamic>;
    return Config.fromJson(map);
  }
}

@JsonSerializable(createToJson: false)
class FileReplacememnt {
  FileReplacememnt({
    required this.from,
    required this.to,
  });
  final String from;
  final String to;

  factory FileReplacememnt.fromJson(Map<String, dynamic> json) =>
      _$FileReplacememntFromJson(json);
}

@JsonSerializable(createToJson: false)
class StringReplacement {
  StringReplacement({
    required this.keys,
    required this.replacement,
    required this.path,
  });
  final List<String> keys;
  final String replacement;
  final String path;

  factory StringReplacement.fromJson(Map<String, dynamic> json) =>
      _$StringReplacementFromJson(json);
}
