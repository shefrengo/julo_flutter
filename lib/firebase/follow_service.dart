import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:julo/models/follow.dart';

class FollowingService {
  
 
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // get posts
  Stream<List<Follow>> getFollowing() {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return db
        .collection('Users')
        .doc(userid)
        .collection("Following")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Follow.fromJson(doc.data())).toList());
  }

  // create posts

  Future<void> setFollowing(Follow follow) {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    var option = SetOptions(merge: true);
    return db
        .collection("Users")
        .doc(userid)
        .collection("Following")
        .doc(follow.userid)
        .set(follow.toMap(), option);
  }
  // delete posts

  Future<void> deletePost(String follow) {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return db
        .collection("Users")
        .doc(userid)
        .collection("Following")
        .doc(follow)
        .delete();
  }
}
