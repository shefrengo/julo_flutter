import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:julo/models/Video.dart';
import 'package:julo/pages/home/story_details.dart';
import 'package:julo/pages/home/widgets/home_page.dart';
import 'package:julo/providers/video_provider.dart';
import 'package:julo/themes/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore db = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final entryProvider = Provider.of<VideoProvider>(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: grey.withOpacity(0.05),
      appBar: getAppBar(),
      body: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(10),
                bottomRight: Radius.circular(10)),
            color: grey.withOpacity(0.05)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 10, top: 20, right: 10),
                child: Text(
                  "For You",
                  style: TextStyle(
                      fontSize: 16, color: black, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 10, bottom: 10),
                  child: StreamBuilder<List<VideoParticipate>>(
                    stream: entryProvider.postLists,
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        int num = snapshot.data.length;

                        return Wrap(
                          spacing: 10,
                          runSpacing: 10,
                          children:
                              List.generate(snapshot.data.length, (index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.scale,
                                        alignment: Alignment.bottomCenter,
                                        child: StreamBuilder(
                                          stream: db
                                              .collection("Users")
                                              .doc(
                                                  snapshot.data[index].myUserid)
                                              .snapshots(),
                                          builder: (context, userSnap) {
                                            return getClickInfo(
                                                snapshot, userSnap, index);
                                          },
                                        )));
                              },
                              child: Container(
                                width: (size.width - 30) / 2,
                                height: 250,
                                child: Stack(
                                  children: [
                                    Container(
                                      width: (size.width - 30) / 2,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          image: DecorationImage(
                                              image:
                                                  ExtendedNetworkImageProvider(
                                                      snapshot.data[index]
                                                          .thumbnail,
                                                      cache: true),
                                              fit: BoxFit.cover)),
                                    ),
                                    Container(
                                      width: (size.width - 15) / 2,
                                      height: 250,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          gradient: LinearGradient(
                                              colors: [
                                                black.withOpacity(0.25),
                                                black.withOpacity(0),
                                              ],
                                              end: Alignment.topCenter,
                                              begin: Alignment.bottomCenter)),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 10),
                                            child: Text(
                                              snapshot.data[index].postTitle,
                                              style: TextStyle(
                                                  color: white,
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 5, left: 10, bottom: 10),
                                            child: Text(
                                              snapshot.data[index].description,
                                              style: TextStyle(
                                                  color: white.withOpacity(0.7),
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            );
                          }),
                        );
                        ;
                      } else {
                        return Container();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }

  // creat
  Widget getAppBar() {
    return AppBar(
      title: Text(
        "Julo",
        style: TextStyle(color: black),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
    );
  }

  Widget getClickInfo(AsyncSnapshot<List<VideoParticipate>> snapshot,
      AsyncSnapshot<dynamic> userSnap, int index) {
    

    return HomePage(snapshot: snapshot,);
  }
}
