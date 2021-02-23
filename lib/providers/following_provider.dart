import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:julo/firebase/follow_service.dart';
import 'package:julo/models/follow.dart';
import 'package:uuid/uuid.dart';

class FollowingProviders with ChangeNotifier {
  final FollowingService followingService = new FollowingService();

  String userid = FirebaseAuth.instance.currentUser.uid;

  String _userId;
  var _uuid = Uuid();

  String get userId => _userId;

  Stream<List<Follow>> get followingList => followingService.getFollowing();

  void saveUser() {
    if (userId == null) {
      // add
      var newPost = new Follow(
        userid: _uuid.v1(),
      );

      followingService.setFollowing(newPost);
    } else {
      //update

      var newPost = new Follow(
        userid: _userId,
      );
      followingService.setFollowing(newPost);
    }
  }

  removeEntry(String postid) {
    followingService.deletePost(postid);
  }
}
