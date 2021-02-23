import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:julo/firebase/users_service.dart';
import 'package:julo/models/users.dart';
import 'package:uuid/uuid.dart';

class UserProviders with ChangeNotifier {
  final UserServices userServices = UserServices();

  String userid = FirebaseAuth.instance.currentUser.uid;

  String _name;
  String _surname;
  String _username;
  String _email;
  String _password;
  String _profilePhotoUrl;
  String _description;
  int _posts;
  int _followers;
  int _following;
  String _phone_number;
  var _uuid = Uuid();
  var _timestamp;
  String _userId;

  // getters
  String get description => _description;

  String get postUsername => _username;
  String get userId => _userId;
  DateTime get timestamp => _timestamp;
  String get email => _email;
  String get password => _password;
  String get profilePhotoUrl => _profilePhotoUrl;
  String get phoneNumber => _phone_number;
  int get posts => _posts;
  int get following => _following;
  int get followers => _followers;
  String get name => _name;
  String get surname => _surname;
  Stream<List<Users>> get usersList => userServices.getUsers();
  Stream<List<Users>> get usersFollowingList => userServices.getUsersFollowing(userid);
  Stream<List<Users>> get usersFollowersList => userServices.getUsersFollowers(userid);

  void saveUser() {
    if (userId == null) {
      // add
      var newPost = new Users(
          name: _name,
          surname: _surname,
          phone_number: _phone_number,
          posts: _posts,
          timestamp: _timestamp,
          userId: _uuid.v1(),
          description: _description,
          followers: _followers,
          following: _following,
          email: _email);
      userServices.setPosts(newPost);
    } else {
      //update

      var newPost = new Users(
          name: _name,
          surname: _surname,
          phone_number: _phone_number,
          email: _email,
          timestamp: _timestamp,
          userId: _userId,
          posts: _posts,
          followers: _followers,
          following: _following,
          description: _description);
      userServices.setPosts(newPost);
    }
  }

  removeEntry(String postid) {
    userServices.deletePost(postid);
  }
}
