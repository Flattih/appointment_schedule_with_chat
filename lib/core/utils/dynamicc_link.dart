import 'package:appointment_schedule_app/features/chat/screens/messages_screen.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DynamicLinkPro {
  Future<String> createLink(String id) async {
    final String url = "https://com.example.appointment_schedule_app?id=$id";

    final DynamicLinkParameters parameters = DynamicLinkParameters(
        androidParameters: const AndroidParameters(
            packageName: "com.example.appointment_schedule_app",
            minimumVersion: 0),
        link: Uri.parse(url),
        uriPrefix: "https://yenibir.page.link");

    final FirebaseDynamicLinks link = FirebaseDynamicLinks.instance;
    final idLink = await link.buildShortLink(parameters);
    return idLink.shortUrl.toString();
  }

  initDynamic(WidgetRef ref, BuildContext context) async {
    final instanceLink = await FirebaseDynamicLinks.instance.getInitialLink();

    if (instanceLink != null) {
      final Uri idLink = instanceLink.link;

      showDialog(
          context: context,
          builder: (context) =>
              MessagesdScreen(id: idLink.queryParameters["id"]!));
    }
  }
}
