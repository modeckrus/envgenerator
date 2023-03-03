// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      fileReplacememnt: FileReplacememnt.fromJson(
          json['file_replacememnt'] as Map<String, dynamic>),
      stringReplacement: StringReplacement.fromJson(
          json['string_replacement'] as Map<String, dynamic>),
    );

FileReplacememnt _$FileReplacememntFromJson(Map<String, dynamic> json) =>
    FileReplacememnt(
      from: json['from'] as String,
      to: json['to'] as String,
    );

StringReplacement _$StringReplacementFromJson(Map<String, dynamic> json) =>
    StringReplacement(
      keys: (json['keys'] as List<dynamic>).map((e) => e as String).toList(),
      replacement: json['replacement'] as String,
      path: json['path'] as String,
    );
