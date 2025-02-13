// To parse this JSON data, do
//
//     final subjectModel = subjectModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'subject_model.g.dart';

List<SubjectModel> subjectModelFromJson(String str) => List<SubjectModel>.from(json.decode(str).map((x) => SubjectModel.fromJson(x)));

String subjectModelToJson(List<SubjectModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class SubjectModel {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "image")
    String image;

    SubjectModel({
        required this.id,
        required this.title,
        required this.description,
        required this.image,
    });

    factory SubjectModel.fromJson(Map<String, dynamic> json) => _$SubjectModelFromJson(json);

    Map<String, dynamic> toJson() => _$SubjectModelToJson(this);
}
