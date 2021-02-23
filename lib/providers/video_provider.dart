import 'package:flutter/cupertino.dart';
import 'package:julo/firebase/video_services.dart';
import 'package:julo/models/Video.dart';
import 'package:uuid/uuid.dart';

class VideoProvider with ChangeNotifier {
  final VideoServices fireStoreService = VideoServices();
  String _description;
  String _postUserid;
  String _myUserid;
  var _timestamp;
  String _postUri;
  String _videoPostUri;
  int _votes;
  var _tags;
  String _postTitle;
  String _postid;
  String _thumbnail;
  String _postDescription;
  var _uuid = Uuid();

  // getters
  String get description => _description;
  List<String> get tags => _tags;

  String get postTitle => _postTitle;
  String get postid => _postid;
  DateTime get timestamp => _timestamp;
  String get myUserId => _myUserid;
  String get thumbnail => _thumbnail;
  int get vots => _votes;
  String get postDescription => _postDescription;
  String get postUserid => _postUserid;
  String get postUri => _postUri;
  String get videoPostUri => _videoPostUri;
  Stream<List<VideoParticipate>> get postLists => fireStoreService.getVideos();

  // setters
  set setPostTitle(String postitle) {
    _postTitle = postitle;
    notifyListeners();
  }

  set setPostid(String postid) {
    _postid = postid;
    notifyListeners();
  }

  set setPostUserid(String postUserid) {
    _postUserid = postUserid;
    notifyListeners();
  }

  set setTags(List<String> tags) {
    _tags = tags;
    notifyListeners();
  }

  set setDescription(String description) {
    _description = description;
    notifyListeners();
  }

  set setVideoPostUris(String videoPostUri) {
    _videoPostUri = videoPostUri;
    notifyListeners();
  }

  set setVotes(int votes) {
    _votes = votes;
    notifyListeners();
  }

  set setThumbnail(String thumbnail) {
    _thumbnail = thumbnail;
    notifyListeners();
  }

  set setPostDescription(String postDescription) {
    _postDescription = postDescription;
    notifyListeners();
  }

  set setMyUserid(String myUserid) {
    _myUserid = myUserid;
    notifyListeners();
  }

  set setPostUri(String postUri) {
    _postUri = postUri;
    notifyListeners();
  }

  set setUyUserid(String myUserid) {
    _myUserid = myUserid;
    notifyListeners();
  }

  //function

  void savePost() {
    if (postid == null) {
      // add
      var newPost = new VideoParticipate(
          postDescription: _postDescription,
          tags: _tags,
          postTitle: _postTitle,
          postid: _uuid.v1(),
          timestamp: _timestamp,
          myUserid: _myUserid,
          description: _description,
          videoPostUri: _videoPostUri,
          postUri: _postUri,
          votes: _votes,
          thumbnail: _thumbnail);
      fireStoreService.setPosts(newPost);
    } else {
      //update

      var newPost = new VideoParticipate(
          postDescription: _postDescription,
          tags: _tags,
          postTitle: _postTitle,
          timestamp: _timestamp,
          myUserid: _myUserid,
          postid: _postid,
          description: _description,
          videoPostUri: _videoPostUri,
          postUri: _postUri,
          votes: _votes,
          thumbnail: _thumbnail);
      fireStoreService.setPosts(newPost);
    }
  }

  removeEntry(String postid) {
    fireStoreService.deletePost(postid);
  }
}
