import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:julo/pages/add_challenge/add_challenge.dart';
import 'package:julo/pages/challenges/challenges.dart';
import 'package:julo/pages/home/home.dart';
import 'package:julo/pages/notification/notifications.dart';
import 'package:julo/pages/profile/profile.dart';
import 'package:julo/providers/posts_provider.dart';
import 'package:julo/providers/users_provider.dart';

import 'package:julo/providers/video_provider.dart';
import 'package:julo/themes/colors.dart';
import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:provider/provider.dart';


class RootApp extends StatefulWidget {
  @override
  _RootAppState createState() => _RootAppState();
}

class _RootAppState extends State<RootApp> {
  int pageIndex = 0;
  List<Widget> pages = [
    Home(),
    Challeges(),
    Notifications(),
    Profile(),
    AddChallenge(),
  ];
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => VideoProvider()),
        ChangeNotifierProvider(create: (context) => UserProviders()),
        ChangeNotifierProvider(create: (context) => PostsProvder())
      ],
      child: Scaffold(
        body: getBody(),
        bottomNavigationBar: getFooter(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            selectedTab(4);
          },
          child: Icon(
            Icons.add,
            size: 25,
          ),
          backgroundColor: green,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      ),
    );
  }

  Widget getBody() {
    return IndexedStack(
      index: pageIndex,
      children: pages,
    );
  }

  Widget getFooter() {
    List<IconData> iconItems = [
      Ionicons.ios_home,
      Ionicons.ios_search,
      Ionicons.ios_notifications,
      Ionicons.ios_person,
    ];
    return AnimatedBottomNavigationBar(
      activeColor: primary,
      splashColor: secondary,
      inactiveColor: Colors.black.withOpacity(0.5),
      icons: iconItems,
      activeIndex: pageIndex,
      gapLocation: GapLocation.center,
      notchSmoothness: NotchSmoothness.softEdge,
      leftCornerRadius: 10,
      iconSize: 24,
      rightCornerRadius: 10,
      onTap: (index) {
        selectedTab(index);
      },
      //other params
    );
  }

  selectedTab(index) {
    setState(() {
      pageIndex = index;
    });
  }
}
