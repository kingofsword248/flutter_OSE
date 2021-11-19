import 'dart:convert';

import 'package:flutter/material.dart';

class FeedBackDTO {
  String idFeedBack;
  DateTime date;
  double star;
  String content;
  String name;
  String image;
  FeedBackDTO({
    @required this.idFeedBack,
    this.date,
    @required this.star,
    @required this.content,
    @required this.name,
    @required this.image,
  });

  FeedBackDTO copyWith({
    String idFeedBack,
    DateTime date,
    double star,
    String content,
    String name,
  }) {
    return FeedBackDTO(
      idFeedBack: idFeedBack ?? this.idFeedBack,
      date: date ?? this.date,
      star: star ?? this.star,
      content: content ?? this.content,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'idFeedBack': idFeedBack,
      'date': date.millisecondsSinceEpoch,
      'star': star,
      'content': content,
      'name': name,
    };
  }

  factory FeedBackDTO.fromMap(Map<String, dynamic> map) {
    return FeedBackDTO(
      idFeedBack: map['idFeedBack'],
      date: DateTime.fromMillisecondsSinceEpoch(map['date']),
      star: map['star'],
      content: map['content'],
      name: map['name'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedBackDTO.fromJson(String source) =>
      FeedBackDTO.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedBack(idFeedBack: $idFeedBack, date: $date, star: $star, content: $content, name: $name)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedBackDTO &&
        other.idFeedBack == idFeedBack &&
        other.date == date &&
        other.star == star &&
        other.content == content &&
        other.name == name;
  }

  @override
  int get hashCode {
    return idFeedBack.hashCode ^
        date.hashCode ^
        star.hashCode ^
        content.hashCode ^
        name.hashCode;
  }
}
