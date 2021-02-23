import 'package:flutter/foundation.dart';

class Follower {
  String userid;
  Follower({this.userid});

  factory Follower.fromJson(Map<String, String> json) {
    return Follower(userid: json["userid"]);
  }

   Map<String, dynamic> toMap() {
    return {
    "userid":userid
    };
  }
}
