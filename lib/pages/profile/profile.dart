import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julo/models/posts.dart';
import 'package:julo/pages/profile/followers.dart';
import 'package:julo/pages/profile/follows.dart';
import 'package:julo/pages/profile/setting.dart';
import 'package:julo/providers/posts_provider.dart';
import 'package:julo/themes/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;

  bool _isOpen = false;
  PanelController _panelController = PanelController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      body: getBody(),
    );
  }

  Widget getBody() {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return new Stack(
      fit: StackFit.expand,
      children: <Widget>[
        FractionallySizedBox(
          alignment: Alignment.topCenter,
          heightFactor: 0.7,
          child: StreamBuilder(
              stream: db.collection("Users").doc(userid).snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedNetworkImageProvider(
                            snapshot.data["profilePhotoUrl"],
                            cache: true),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                } else {
                  return Text("No Data");
                }
              }),
        ),

        FractionallySizedBox(
          alignment: Alignment.bottomCenter,
          heightFactor: 0.3,
          child: Container(
            color: Colors.white,
          ),
        ),

        /// Sliding Panel
        SlidingUpPanel(
          controller: _panelController,
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(32),
            topLeft: Radius.circular(32),
          ),
          minHeight: MediaQuery.of(context).size.height * 0.35,
          maxHeight: MediaQuery.of(context).size.height * 0.85,
          body: GestureDetector(
            onTap: () => _panelController.close(),
            child: Container(
              color: Colors.transparent,
            ),
          ),
          panelBuilder: (ScrollController controller) => _panelBody(controller),
          onPanelSlide: (value) {
            if (value >= 0.2) {
              if (!_isOpen) {
                setState(() {
                  _isOpen = true;
                });
              }
            }
          },
          onPanelClosed: () {
            setState(() {
              _isOpen = false;
            });
          },
        ),
      ],
    );
  }

  /// **********************************************
  /// WIDGETS
  /// **********************************************

  /// Panel Body
  SingleChildScrollView _panelBody(ScrollController controller) {
    double hPadding = 40;
    final entryProvider = Provider.of<PostsProvder>(context);
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return SingleChildScrollView(
      controller: controller,
      physics: ClampingScrollPhysics(),
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.symmetric(horizontal: hPadding),
            height: MediaQuery.of(context).size.height * 0.35,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                StreamBuilder(
                    stream: db.collection("Users").doc(userid).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String name = snapshot.data["name"];
                        String surname = snapshot.data["surname"];
                        String fullname = name + " " + surname;
                        String bio = snapshot.data['description'];
                        return _titleSection(fullname, bio);
                      } else {
                        return Text("");
                      }
                    }),
                StreamBuilder(
                    stream: db.collection("Users").doc(userid).snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        String following =
                            snapshot.data["following"].toString();
                        String followers =
                            snapshot.data["followers"].toString();

                        String posts = snapshot.data['posts'].toString();
                        return _infoSection(followers, following, posts);
                      } else {
                        return Text("");
                      }
                    }),
                _actionSection(hPadding: hPadding),
              ],
            ),
          ),
          StreamBuilder<List<Posts>>(
            stream: entryProvider.postLists,
            builder: (contex, snapshot) {
              if (snapshot.hasData) {
                return GridView.builder(
                  primary: false,
                  shrinkWrap: true,
                  padding: EdgeInsets.zero,
                  itemCount: snapshot.data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (BuildContext context, int index) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: ExtendedNetworkImageProvider(
                            snapshot.data[index].storiesList,
                            cache: true),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              } else {
                return Center();
              }
            },
          )
        ],
      ),
    );
  }

  /// Action Section
  Row _actionSection({double hPadding}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Visibility(
          visible: !_isOpen,
          child: Expanded(
            child: OutlineButton(
              onPressed: () => _panelController.open(),
              borderSide: BorderSide(color: Colors.blue),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: Text(
                'VIEW PROFILE',
                style: TextStyle(
                  fontFamily: 'NimbusSanL',
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: !_isOpen,
          child: SizedBox(
            width: 16,
          ),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.center,
            child: SizedBox(
              width: _isOpen
                  ? (MediaQuery.of(context).size.width - (2 * hPadding)) / 1.6
                  : double.infinity,
              child: FlatButton(
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (BuildContext context) => EditProfilePage()));
                },
                color: red,
                textColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: Text(
                  'EDIT PROFILE',
                  style: TextStyle(
                    //fontFamily: 'NimbusSanL',
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  /// Info Section
  Row _infoSection(String followers, String following, String challenges) {
    User user = firebaseAuth.currentUser;
    String userid = user.uid;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        new GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.bottomCenter,
                    child: Followers(userid: userid)));
          },
          child: Container(
            child: _infoCell(title: 'Followers', value: followers),
          ),
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        new GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.scale,
                    alignment: Alignment.bottomCenter,
                    child: Follows(userid: userid)));
          },
          child: Container(
            child: _infoCell(title: 'Following', value: following),
          ),
        ),
        Container(
          width: 1,
          height: 40,
          color: Colors.grey,
        ),
        _infoCell(title: 'Challenges', value: challenges),
      ],
    );
  }

  /// Info Cell
  Column _infoCell({String title, String value}) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w300,
            fontSize: 16,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          value,
          style: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.w700,
            fontSize: 16,
          ),
        ),
      ],
    );
  }

  /// Title Section
  Column _titleSection(String name, String bio) {
    return Column(
      children: <Widget>[
        Text(
          name,
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontWeight: FontWeight.w700,
            fontSize: 30,
          ),
        ),
        SizedBox(
          height: 8,
        ),
        Text(
          bio,
          style: TextStyle(
            fontFamily: 'NimbusSanL',
            fontStyle: FontStyle.italic,
            fontSize: 16,
          ),
        ),
      ],
    );
  }
}
