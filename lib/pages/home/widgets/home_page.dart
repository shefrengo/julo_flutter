import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'package:julo/models/Video.dart';
import 'package:julo/pages/home/widgets/column_social_icon.dart';
import 'package:julo/pages/home/widgets/tik_tok_icons.dart';
import 'package:julo/themes/colors.dart';

import 'package:responsive_builder/responsive_builder.dart';

import 'package:video_player/video_player.dart';

class HomePage extends StatefulWidget {
  final AsyncSnapshot<List<VideoParticipate>> snapshot;

  HomePage({this.snapshot});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  bool _isPlaying = true;
  int _followingForYouController = 0;
  TextStyle _followingForYouStyle =
      TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500);

  AnimationController _animationController;

  @override
  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 8));
    _animationController.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ResponsiveBuilder(
      builder: (BuildContext context, SizingInformation sizingInformation) {
        return Scaffold(
            body: Stack(
          children: <Widget>[
            PageView.builder(
              scrollDirection: Axis.vertical,
              itemCount: widget.snapshot.data.length,
              itemBuilder: (BuildContext context, int index) {
                return StreamBuilder(
                    stream: db
                        .collection("Users")
                        .doc(widget.snapshot.data[index].myUserid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Text("Error ");
                      }

                      if (snapshot.hasData) {
                        return Stack(
                          children: <Widget>[
                            VideoPlayerItem(
                                widget.snapshot.data[index].postUri),
                            _isPlaying == false
                                ? Align(
                                    alignment: Alignment.center,
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.black.withOpacity(.4),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(10))),
                                      child: Icon(
                                        Icons.play_arrow,
                                        size: 95,
                                      ),
                                    ),
                                  )
                                : Container(),
                            _rightSideButtonsWidgets(index, snapshot),
                            _textDataWidgetBottom(
                                sizingInformation, index, snapshot),
                          ],
                        );
                      } 

                      return Center(
                          child: Text(
                        "Loading",
                        style: TextStyle(color: black),
                      ));
                    });
              },
            ),
            _topWidgetFollowingAndForYou(),
          ],
        ));
      },
    );
  }

  Widget _topWidgetFollowingAndForYou() {
    return Align(
      alignment: Alignment.topCenter,
      child: Container(
        margin: EdgeInsets.only(top: 35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
                onTap: () {
                  setState(() {
                    _followingForYouController = 0;
                  });
                },
                child: Text("Following",
                    style: _textStyleFollowingForYou(
                        _followingForYouController == 0
                            ? Colors.white
                            : Colors.white60))),
            SizedBox(
              width: 15,
            ),
            GestureDetector(
                onTap: () {
                  setState(() {
                    _followingForYouController = 1;
                  });
                },
                child: Text("For you",
                    style: _textStyleFollowingForYou(
                        _followingForYouController == 1
                            ? Colors.white
                            : Colors.white60)))
          ],
        ),
      ),
    );
  }

  TextStyle _textStyleFollowingForYou(Color color) {
    return TextStyle(fontSize: 18, color: color, fontWeight: FontWeight.w500);
  }

  Widget _rightSideButtonsWidgets(int index, AsyncSnapshot<dynamic> snapshot) {
    return Positioned(
      right: 10,
      bottom: 40,
      child: Column(
        children: <Widget>[
          getProfile(snapshot.data["profilePhotoUrl"]),
          SizedBox(
            height: 15,
          ),
          Container(
            child: Column(
              children: <Widget>[
                getIcons(TikTokIcons.heart, "487", 35.0),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: Column(
              children: <Widget>[
                getIcons(TikTokIcons.reply, "48", 35.0),
                SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          SizedBox(
            height: 25,
          ),
          Container(
            child: getIcons(TikTokIcons.chat_bubble, "487", 35.0),
          ),
          SizedBox(
            height: 25,
          ),
          AnimatedBuilder(
            builder: (BuildContext context, Widget child) {
              return Transform.rotate(
                  angle: _animationController.value * 6.3, child: child);
            },
            animation: _animationController,
            child: Container(
              height: 50,
              width: 50,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  color: Colors.black45,
                  borderRadius: BorderRadius.all(Radius.circular(50))),
              child: Container(
                height: 30,
                width: 30,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                ),
                child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(50)),
                    child: getAlbum(snapshot.data["profilePhotoUrl"])),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _textDataWidgetBottom(SizingInformation sizingInformation, int index,
      AsyncSnapshot<dynamic> snapshot) {
    return Positioned(
      bottom: 20,
      left: 10,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
            decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Container(
                    padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                    decoration: BoxDecoration(
                        color: Colors.orange,
                        borderRadius: BorderRadius.all(Radius.circular(30))),
                    child: Icon(
                      Icons.play_arrow,
                      size: 15,
                    )),
                SizedBox(
                  width: 10,
                ),
                Text(
                  widget.snapshot.data[index].postTitle,
                  style: TextStyle(color: white),
                )
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            snapshot.data["name"],
            style: TextStyle(
                fontWeight: FontWeight.w500, fontSize: 18, color: white),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: sizingInformation.localWidgetSize.width * 0.80,
            child: Text(
              widget.snapshot.data[index].description,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 14, color: white),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
              width: sizingInformation.localWidgetSize.width * 0.70,
              child: Text(
                "#brandon",
                style: TextStyle(color: white),
              )),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.music_note,
                  color: Colors.white,
                  size: 20,
                ),
                SizedBox(
                  width: 5,
                ),
                Container(
                  height: 25,
                  width: sizingInformation.localWidgetSize.width * 0.40,
                  child: Text(
                    "challenge by : Brandon Ren",
                    style: TextStyle(color: white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();

    super.dispose();
  }
}

class VideoPlayerItem extends StatefulWidget {
  final String videoUrl;
  VideoPlayerItem([this.videoUrl]);
  @override
  _VideoPlayerItemState createState() => _VideoPlayerItemState();
}

class _VideoPlayerItemState extends State<VideoPlayerItem> {
  VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    _videoPlayerController = VideoPlayerController.network(widget.videoUrl)
      ..initialize()
      ..setLooping(true)
      ..play().then((value) {
        setState(() {});
      });

    super.initState();
  }

  @override
  void dispose() {
    _videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: VideoPlayer(_videoPlayerController),
    );
  }
}
