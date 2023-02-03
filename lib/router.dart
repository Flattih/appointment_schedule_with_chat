import 'package:appointment_schedule_app/features/add_appointment/screens/add_post_screen.dart';
import 'package:appointment_schedule_app/features/home/screens/home_screen.dart';
import 'package:appointment_schedule_app/features/chat/screens/messages_screen.dart';
import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';

import 'features/auth/screens/login_screen.dart';
import 'features/profile/screens/profile_screen.dart';

final loggedOutRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: LoginScreen()),
});

final loggedInRoute = RouteMap(routes: {
  '/': (_) => const MaterialPage(child: HomeScreen()),
  '/a': (route) => const MaterialPage(child: AddAppointmentScreen()),
  '/u/:uid': (routeData) => MaterialPage(
        child: ProfileScreen(
          uid: routeData.pathParameters['uid']!,
        ),
      ),
  '/messages/:name/:id': (route) => MaterialPage(
          child: MessagesScreen(
        uid: route.pathParameters['id']!,
        name: route.pathParameters['name']!,
      )),
});
