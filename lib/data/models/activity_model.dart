class ActivityModel {
  final String? activity;
  final String? type;
  final int? participants;
  final double? price;
  final String? link;
  final String? key;
  final double? accessibility;
  int likes;
  bool isLiked;

  ActivityModel({
    this.activity,
    this.type,
    this.participants,
    this.price,
    this.link,
    this.key,
    this.accessibility,
    this.likes = 0,
    this.isLiked = false,
  });

  factory ActivityModel.fromJson(Map<String, dynamic> json) {
    return ActivityModel(
      activity: json['activity'] as String?,
      type: json['type'] as String?,
      participants: json['participants'] as int?,
      price: json['price']?.toDouble(),
      link: json['link'] as String?,
      key: json['key'] as String?,
      accessibility: json['accessibility']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'activity': activity,
      'type': type,
      'participants': participants,
      'price': price,
      'link': link,
      'key': key,
      'accessibility': accessibility,
    };
  }
}
