import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:julo/models/posts.dart';

class FireStoreService {
  String userId;
  FireStoreService(this.userId);
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  // get posts
  Stream<List<Posts>> getPosts() {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return db
        .collection('Posts')
        .where("userId", isEqualTo: userid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Posts.fromJson(doc.data())).toList());
  }

  Stream<List<Posts>> getUserPosts() {
    print("from profile "+userId);
    return db
        .collection('Posts')
        .where("userId", isEqualTo: userId)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Posts.fromJson(doc.data())).toList());
  }
  // create posts

  Future<void> setPosts(Posts posts) {
    var option = SetOptions(merge: true);
    return db.collection("Posts").doc(posts.postid).set(posts.toMap(), option);
  }
  // delete posts

  Future<void> deletePost(String posts) {
    return db.collection("Posts").doc(posts).delete();
  }
}
