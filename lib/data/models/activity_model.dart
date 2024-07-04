import 'package:freezed_annotation/freezed_annotation.dart';

part 'activity_model.freezed.dart';
part 'activity_model.g.dart';

@freezed
class ActivityModel with _$ActivityModel {
  const factory ActivityModel({
    String? activity,
    String? type,
    int? participants,
    double? price,
    String? link,
    String? key,
    double? accessibility,
    @Default(0) int likes,
    @Default(false) bool isLiked,
  }) = _ActivityModel;

  factory ActivityModel.fromJson(Map<String, dynamic> json) =>
      _$ActivityModelFromJson(json);
}
