import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:extended_image/extended_image.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:julo/firebase/users_service.dart';
import 'package:julo/models/users.dart';
import 'package:julo/pages/challenges/user_profile.dart';

import 'package:julo/themes/colors.dart';
import 'package:page_transition/page_transition.dart';

class Follows extends StatefulWidget {
  final String userid;

  const Follows({Key key, this.userid}) : super(key: key);
  @override
  _FollowsState createState() => _FollowsState();
}

class _FollowsState extends State<Follows> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(),
      body: getBody(),
    );
  }

  Widget getAppBar() {
    return AppBar(
      title: const Text(
        "Search",
        style: TextStyle(color: black),
      ),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 1,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: black,
        ),
        onPressed: () {},
      ),
    );
  }

  Widget getBody() {
    var size = MediaQuery.of(context).size;

    ///final entryProvider = Provider.of<UserProviders>(context);
    UserServices userServices = UserServices();
    String name = "";
    String surname = "";
    FirebaseAuth auth = FirebaseAuth.instance;
    User user = auth.currentUser;
    String userid = user.uid;

    CollectionReference reference =
        db.collection("Users").doc(widget.userid).collection("Following");

    return FutureBuilder<QuerySnapshot>(
        future: reference.get(),
        builder:
            (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshots) {
          if (snapshots.hasError) {
            return Center(
                child: Text(
              "Something Went Wrong",
              style: TextStyle(color: green, fontSize: 19),
            ));
          }

          if (snapshots.connectionState == ConnectionState.done) {
            String id;
            snapshots.data.docs.forEach((element) {
              id = element.id;
            });

            return Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(10),
                      bottomRight: Radius.circular(10)),
                  color: Colors.white),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2)),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Flexible(
                          child: Container(
                            height: 1,
                            decoration: BoxDecoration(
                                color: Colors.grey.withOpacity(0.2)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    Container(
                      child: StreamBuilder<List<Users>>(
                        stream: userServices.getQueryUsers(id),
                        builder: (context, snaphot) {
                          if (snaphot.hasData) {
                            return Column(
                              children:
                                  List.generate(snaphot.data.length, (index) {
                                name = snaphot.data[index].name;
                                surname = snaphot.data[index].surname;

                                String fullname = name + " " + surname;

                                return GestureDetector(
                                  onTap: () {
                                    if (snaphot.data[index].userId == userid) {
                                      return;
                                    }
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.scale,
                                            alignment: Alignment.bottomCenter,
                                            child: UserProfile(
                                                userid: snaphot
                                                    .data[index].userId)));
                                  },
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            right: 20, left: 20),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Container(
                                              width: (size.width - 40) * 0.68,
                                              child: Row(
                                                children: [
                                                  Container(
                                                    width: 50,
                                                    height: 50,
                                                    decoration: BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        image: DecorationImage(
                                                            image: ExtendedNetworkImageProvider(
                                                                snaphot
                                                                    .data[index]
                                                                    .profilePhotoUrl,
                                                                cache: true),
                                                            fit: BoxFit.cover)),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Container(
                                                    width:
                                                        (size.width - 95) * 0.3,
                                                    child: Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          fullname,
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.black,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 3,
                                                        ),
                                                        Text(
                                                          '@' +
                                                              snaphot
                                                                  .data[index]
                                                                  .username,
                                                          style: TextStyle(
                                                              fontSize: 14,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.6),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                          overflow: TextOverflow
                                                              .ellipsis,
                                                        ),
                                                        SizedBox(
                                                          height: 5,
                                                        ),
                                                        Text(
                                                          "JULO USER",
                                                          style: TextStyle(
                                                              fontSize: 12,
                                                              color: Colors
                                                                  .black
                                                                  .withOpacity(
                                                                      0.5),
                                                              fontWeight:
                                                                  FontWeight
                                                                      .w400),
                                                        )
                                                      ],
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                            Container(
                                              width: (size.width - 40) * 0.32,
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  OutlineButton(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 20),
                                                    shape:
                                                        RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                    onPressed: () {
                                                      // do something here
                                                    },
                                                    child: Text("Following",
                                                        style: TextStyle(
                                                            fontSize: 13,
                                                            letterSpacing: 2.2,
                                                            color: blue)),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 5,
                                      ),
                                      Divider()
                                    ],
                                  ),
                                );
                              }),
                            );
                          } else {
                            return Container();
                          }
                        },
                      ),
                    )
                  ],
                ),
              ),
            );
          }

          return Center(
              child: Text(
            "Loading.....",
            style: TextStyle(color: green, fontSize: 19),
          ));
        });
  }
}
