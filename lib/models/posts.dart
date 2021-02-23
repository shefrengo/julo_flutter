import 'package:flutter/material.dart';

class Posts {
  String caption;
  var tags;
  String story_title;
  String postid;
  var timestamp;
  String userId;
  String storiesList;
  int participants;
  bool hasSound;
  String sound;
  bool hasBeenPopular;

  Posts(
      {this.caption,
      this.tags,
      this.storiesList,
      this.timestamp,
      this.userId,
      this.participants,
      this.hasSound,
      this.hasBeenPopular,
      this.story_title,
      @required this.postid,
      this.sound});

  factory Posts.fromJson(Map<String, dynamic> json) {
    return Posts(
        caption: json['caption'],
         tags: json['tags'],
      storiesList: json['storiesList'],
        timestamp: json['timestamp'],
        userId: json['userId'],
        participants: json['participants'],
        hasSound: json['hasSound'],
        hasBeenPopular: json['hasBeenPopular'],
        story_title: json['story_title'],
        sound: json['sound'],
        postid: json['postid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'caption': caption,
      'tags': tags,
      'storiesList': storiesList,
      'timestamp': timestamp,
      'userId': userId,
      'participants': participants,
      'hasSound': hasSound,
      'hasBeenPopular': hasBeenPopular,
      'story_title': story_title,
      'sound': sound,
      'postid': postid
    };
  }
}
