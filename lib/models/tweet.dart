// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';

class Tweets {
  final String uid;
  final String profilePic;
  final String name;
  final String content;
  final Timestamp postTime;

  Tweets({
    required this.uid,
    required this.profilePic,
    required this.name,
    required this.content,
    required this.postTime,
  });

  Tweets copyWith({
    String? uid,
    String? profilePic,
    String? name,
    String? content,
    Timestamp? postTime,
  }) {
    return Tweets(
      uid: uid ?? this.uid,
      profilePic: profilePic ?? this.profilePic,
      name: name ?? this.name,
      content: content ?? this.content,
      postTime: postTime ?? this.postTime,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'uid': uid,
      'profilePic': profilePic,
      'name': name,
      'content': content,
      'postTime': postTime,
    };
  }

  factory Tweets.fromMap(Map<String, dynamic> map) {
    return Tweets(
      uid: map['uid'] as String,
      profilePic: map['profilePic'] as String,
      name: map['name'] as String,
      content: map['content'] as String,
      postTime: map['postTime'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Tweets.fromJson(String source) =>
      Tweets.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Tweet(uid: $uid, profilePic: $profilePic, name: $name, content: $content, postTime: $postTime)';
  }

  @override
  bool operator ==(covariant Tweets other) {
    if (identical(this, other)) return true;

    return other.uid == uid &&
        other.profilePic == profilePic &&
        other.name == name &&
        other.content == content &&
        other.postTime == postTime;
  }

  @override
  int get hashCode {
    return uid.hashCode ^
        profilePic.hashCode ^
        name.hashCode ^
        content.hashCode ^
        postTime.hashCode;
  }
}
