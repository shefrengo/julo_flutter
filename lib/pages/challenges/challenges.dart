import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:julo/pages/challenges/search_users.dart';
import 'package:julo/providers/posts_provider.dart';
import 'package:julo/providers/users_provider.dart';

import 'package:julo/themes/colors.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

class Challeges extends StatefulWidget {
  @override
  _ChallegesState createState() => _ChallegesState();
}

class _ChallegesState extends State<Challeges> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProviders()),
        ChangeNotifierProvider(create: (context) => PostsProvder())
      ],
      child: Scaffold(
        backgroundColor: grey.withOpacity(0.05),
        appBar: AppBar(
          title: const Text(
            "Search",
            style: TextStyle(color: black),
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          actions: [
            IconButton(
              icon: Icon(
                AntDesign.search1,
                color: black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.scale,
                        alignment: Alignment.bottomCenter,
                        child: Search()));
              },
            ),
          ],
        ),
        body: getBody(),
      ),
    );
  }

  Widget getBody() {}
}
