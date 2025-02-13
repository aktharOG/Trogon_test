// To parse this JSON data, do
//
//     final moduleModel = moduleModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'module_model.g.dart';

List<ModuleModel> moduleModelFromJson(String str) => List<ModuleModel>.from(json.decode(str).map((x) => ModuleModel.fromJson(x)));

String moduleModelToJson(List<ModuleModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class ModuleModel {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "description")
    String description;

    ModuleModel({
        required this.id,
        required this.title,
        required this.description,
    });

    factory ModuleModel.fromJson(Map<String, dynamic> json) => _$ModuleModelFromJson(json);

    Map<String, dynamic> toJson() => _$ModuleModelToJson(this);
}
