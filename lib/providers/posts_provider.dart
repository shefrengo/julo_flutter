import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:julo/firebase/Post_services.dart';
import 'package:uuid/uuid.dart';
import '../models/posts.dart';

class PostsProvder with ChangeNotifier {


  final FireStoreService fireStoreService = FireStoreService("");
  String _caption;
  List<String> _tags;
  String _story_title;
  String _postid;
  var _timestamp;
  String _userId;
  List<String> _storiesList;
  int _participants;
  bool _hasSound;
  String _sound;
  bool _hasBeenPopular;
  var _uuid = Uuid();

// getters
  String get caption => _caption;
  List<String> get tags => _tags;

  String get story_title => _story_title;
  String get postid => _postid;
  DateTime get timestamp => _timestamp;
  String get userId => _userId;
  List<String> get storiesList => _storiesList;
  int get participants => _participants;
  bool get hasSound => _hasSound;
  String get sound => _sound;
  bool get hasBeenPopular => _hasBeenPopular;
  Stream<List<Posts>> get postLists => fireStoreService.getPosts();



// setters
  set setStoryTitle(String storyTitle) {
    _story_title = storyTitle;
    notifyListeners();
  }

  set setCaption(String caption) {
    _caption = caption;
    notifyListeners();
  }

  set setUserid(String userid) {
    _userId = userid;
    notifyListeners();
  }

  set setTags(List<String> tags) {
    _tags = tags;
    notifyListeners();
  }

  set setStoryList(List<String> storiesList) {
    _storiesList = storiesList;
    notifyListeners();
  }

  set setParticipants(int participants) {
    _participants = participants;
    notifyListeners();
  }

  set setHasSound(bool hasSound) {
    _hasSound = hasSound;
    notifyListeners();
  }

  set setSound(String sound) {
    _sound = sound;
    notifyListeners();
  }

  set sethasBeenPopular(bool hasBeenPopular) {
    _hasBeenPopular = hasBeenPopular;
    notifyListeners();
  }

  set setPostid(String postid) {
    _postid = postid;
    notifyListeners();
  }

  //function

  void savePost() {
    if (postid == null) {
      // add
      var newPost = new Posts(
          caption: _caption,
          tags: _tags,
          story_title: _story_title,
          postid: _uuid.v1(),
          timestamp: _timestamp,
          userId: _userId,
          hasBeenPopular: _hasBeenPopular,
          hasSound: _hasSound,
          participants: _participants,
          sound: _sound);
      fireStoreService.setPosts(newPost);
    } else {
      //update

      var newPost = new Posts(
          caption: _caption,
          tags: _tags,
          story_title: _story_title,
          postid: _postid,
          timestamp: _timestamp,
          userId: _userId,
          hasBeenPopular: _hasBeenPopular,
          hasSound: _hasSound,
          participants: _participants,
          sound: _sound);
      fireStoreService.setPosts(newPost);
    }
  }

  removeEntry(String postid) {
    fireStoreService.deletePost(postid);
  }
}
