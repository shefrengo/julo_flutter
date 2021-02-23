import 'package:flutter/widgets.dart';

class VideoParticipate {
  String description;
  String postUserid;
  String myUserid;
  var timestamp;
  String postUri;
  String videoPostUri;
  int votes;
  var tags;
  String postTitle;
  String postid;
  String thumbnail;
  String postDescription;

  VideoParticipate(
      {this.description,
      this.myUserid,
      this.postDescription,
      this.postTitle,
      this.postUri,
      this.postUserid,
      this.tags,
      this.thumbnail,
      this.timestamp,
      this.videoPostUri,
      @required this.postid,
      this.votes});

  factory VideoParticipate.fromJson(Map<String, dynamic> json) {
    return VideoParticipate(
        description: json['description'],
        tags: json['tags'],
        myUserid: json['myUserid'],
        timestamp: json['timestamp'],
        postDescription: json['postDescription'],
        postTitle: json['postTitle'],
        postUri: json['postUri'],
        thumbnail: json['thumbnail'],
        videoPostUri: json['videoPostUri'],
        votes: json['votes'],
        postUserid: json['postUserid'],
        postid: json['postid']);
  }

  Map<String, dynamic> toMap() {
    return {
      'description': description,
      'tags': tags,
      'myUserid': myUserid,
      'timestamp': timestamp,
      'postDescription': postDescription,
      'postTitle': postTitle,
      'postUri': postUri,
      'videoPostUri': videoPostUri,
      'thumbnail': thumbnail,
      'votes': votes,
      'postUserid': postUserid,
      'postid': postid
    };
  }
}
