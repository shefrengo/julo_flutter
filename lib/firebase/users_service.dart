import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:julo/models/users.dart';

class UserServices {
  FirebaseFirestore db = FirebaseFirestore.instance;

  // get posts
  Stream<List<Users>> getUsers() {
    return db.collection('Users').snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }

  // get posts
  Stream<List<Users>> getQueryUsers(String id) {


    return db.collection('Users').where("userId",isEqualTo: id).snapshots().map((snapshot) =>
        snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }
  // get folllowers
  Stream<List<Users>> getUsersFollowers(String userid) {
    return db
        .collection('Users')
        .doc(userid)
        .collection("Followers")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }

  // get following
  Stream<List<Users>> getUsersFollowing(String userid) {
    return db
        .collection('Users')
        .doc(userid)
        .collection("Following")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Users.fromJson(doc.data())).toList());
  }

  Future<void> setPosts(Users users) {
    var option = SetOptions(merge: true);
    return db.collection("Users").doc(users.userId).set(users.toMap(), option);
  }
  // delete posts

  Future<void> deletePost(String users) {
    return db.collection("Users").doc(users).delete();
  }
}
