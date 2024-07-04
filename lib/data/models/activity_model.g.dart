// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'activity_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ActivityModelImpl _$$ActivityModelImplFromJson(Map<String, dynamic> json) =>
    _$ActivityModelImpl(
      activity: json['activity'] as String?,
      type: json['type'] as String?,
      participants: (json['participants'] as num?)?.toInt(),
      price: (json['price'] as num?)?.toDouble(),
      link: json['link'] as String?,
      key: json['key'] as String?,
      accessibility: (json['accessibility'] as num?)?.toDouble(),
      likes: (json['likes'] as num?)?.toInt() ?? 0,
      isLiked: json['isLiked'] as bool? ?? false,
    );

Map<String, dynamic> _$$ActivityModelImplToJson(_$ActivityModelImpl instance) =>
    <String, dynamic>{
      'activity': instance.activity,
      'type': instance.type,
      'participants': instance.participants,
      'price': instance.price,
      'link': instance.link,
      'key': instance.key,
      'accessibility': instance.accessibility,
      'likes': instance.likes,
      'isLiked': instance.isLiked,
    };
