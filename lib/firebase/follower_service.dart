import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:julo/models/followers.dart';

class FollowerService {
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // get posts
  Stream<List<Follower>> getFollowers() {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;

    
    return db
        .collection('Users')
        .doc(userid)
        .collection("Followers")
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Follower.fromJson(doc.data())).toList());
  }

  // create posts

  Future<void> setFollowers(Follower follower) {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    var option = SetOptions(merge: true);
    return db
        .collection("Users")
        .doc(userid)
        .collection("Followers")
        .doc(follower.userid)
        .set(follower.toMap(), option);
  }
  // delete posts

  Future<void> deletePost(String follower) {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return db
        .collection("Users")
        .doc(userid)
        .collection("Followers")
        .doc(follower)
        .delete();
  }
}
