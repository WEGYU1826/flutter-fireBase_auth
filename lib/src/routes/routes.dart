import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/src/home.screen.dart';
import 'package:flutter_firebase_auth/src/routes/route_names.dart';
import 'package:flutter_firebase_auth/src/screens/auth.screen.dart';

final Map<String, WidgetBuilder> routes = {
  RouteNames.routeAuthPage: (context) => AuthScreen(),
  RouteNames.routeHomePage: (context) => const HomeScreen(),
};
