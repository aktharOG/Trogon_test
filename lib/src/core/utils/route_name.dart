import 'package:flutter/material.dart';

class RouteName {
  static const String home = '/';
  static const String moduleScreen = '/module';
  static const String videoListingScreen= '/video_listing';
  static const String videoScreen = '/video';
   
}



final _navKey = GlobalKey<NavigatorState>();

GlobalKey<NavigatorState> get navKey => _navKey;

NavigatorState? get navigator => _navKey.currentState;

final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

GlobalKey<ScaffoldMessengerState> get scaffoldKey => _scaffoldMessengerKey;

ScaffoldMessengerState? get snackkey => _scaffoldMessengerKey.currentState;
