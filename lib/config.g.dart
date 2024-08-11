// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'config.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Config _$ConfigFromJson(Map<String, dynamic> json) => Config(
      fileReplacement: (json['file_replacement'] as List<dynamic>)
          .map((e) => FileReplacememnt.fromJson(e as Map<String, dynamic>))
          .toList(),
      stringReplacement: (json['string_replacement'] as List<dynamic>)
          .map((e) => StringReplacement.fromJson(e as Map<String, dynamic>))
          .toList(),
      folderReplacement: (json['folder_replacement'] as List<dynamic>?)
          ?.map((e) => FolderReplacement.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

FolderReplacement _$FolderReplacementFromJson(Map<String, dynamic> json) =>
    FolderReplacement(
      from: json['from'] as String,
      to: json['to'] as String,
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
