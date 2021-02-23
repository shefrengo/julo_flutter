import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:julo/firebase/follower_service.dart';
import 'package:julo/models/followers.dart';

import 'package:uuid/uuid.dart';

class FollowersProviders with ChangeNotifier {
  final FollowerService followerService = new FollowerService();

  String userid = FirebaseAuth.instance.currentUser.uid;

  String _userId;
  var _uuid = Uuid();

  String get userId => _userId;

  Stream<List<Follower>> get followingList => followerService.getFollowers();

  void saveUser() {
    if (userId == null) {
      // add
      var newPost = new Follower(
        userid: _uuid.v1(),
      );

      followerService.setFollowers(newPost);
    } else {
      //update

      var newPost = new Follower(
        userid: _userId,
      );
      followerService.setFollowers
      (newPost);
    }
  }

  removeEntry(String postid) {
    followerService.deletePost(postid);
  }
}
