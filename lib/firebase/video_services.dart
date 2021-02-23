import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:julo/models/Video.dart';

class VideoServices{
  FirebaseFirestore db = FirebaseFirestore.instance;
  // get posts
    Stream<List<VideoParticipate>> getVideos(){
      return db
        .collection('PhotoParticipate')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => VideoParticipate.fromJson(doc.data()))
        .toList());
    }


     Future<void> setPosts(VideoParticipate posts) {
    var option = SetOptions(merge: true);
    return db.collection("PhotoParticipate").doc(posts.postid).set(posts.toMap(), option);
  }
  // delete posts

  Future<void> deletePost(String posts) {
    return db.collection("PhotoParticipate").doc(posts).delete();
  }
}