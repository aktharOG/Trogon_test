// To parse this JSON data, do
//
//     final videoModel = videoModelFromJson(jsonString);

import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

part 'video_model.g.dart';

List<VideoModel> videoModelFromJson(String str) => List<VideoModel>.from(json.decode(str).map((x) => VideoModel.fromJson(x)));

String videoModelToJson(List<VideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@JsonSerializable()
class VideoModel {
    @JsonKey(name: "id")
    int id;
    @JsonKey(name: "title")
    String title;
    @JsonKey(name: "description")
    String description;
    @JsonKey(name: "video_type")
    VideoType videoType;
    @JsonKey(name: "video_url")
    String videoUrl;

    VideoModel({
        required this.id,
        required this.title,
        required this.description,
        required this.videoType,
        required this.videoUrl,
    });

    String getVideoId() {
    if (videoType == VideoType.YOU_TUBE) {
      return videoUrl;
    } else if (videoType == VideoType.VIMEO) {
      Uri uri = Uri.parse(videoUrl);
      return uri.pathSegments.last; // Extracts the Vimeo video ID
    }
    return "";
  }

    factory VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

    Map<String, dynamic> toJson() => _$VideoModelToJson(this);
}

enum VideoType {
    @JsonValue("Vimeo")
    VIMEO,
    @JsonValue("YouTube")
    YOU_TUBE
}

final videoTypeValues = EnumValues({
    "Vimeo": VideoType.VIMEO,
    "YouTube": VideoType.YOU_TUBE
});

class EnumValues<T> {
    Map<String, T> map;
    late Map<T, String> reverseMap;

    EnumValues(this.map);

    Map<T, String> get reverse {
            reverseMap = map.map((k, v) => MapEntry(v, k));
            return reverseMap;
    }
}
