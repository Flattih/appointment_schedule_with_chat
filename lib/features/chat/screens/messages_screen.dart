import 'package:appointment_schedule_app/features/chat/widgets/bottom_chat_field.dart';
import 'package:appointment_schedule_app/features/chat/widgets/chat_list.dart';
import 'package:appointment_schedule_app/core/common/error_Text.dart';
import 'package:appointment_schedule_app/core/common/loader.dart';
import 'package:appointment_schedule_app/core/common/post_card.dart';
import 'package:appointment_schedule_app/features/add_appointment/controller/post_controller.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';

import 'package:appointment_schedule_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final onlineProvider = StreamProvider.family<UserModel, String>((ref, uid) {
  return ref.read(authControllerProvider.notifier).getUserData(uid);
});

class MessagesdScreen extends ConsumerWidget {
  final String? id;
  const MessagesdScreen({super.key, required this.id});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
          child: ref.watch(individualProvider(id!)).when(
              data: (post) {
                return PostCard(post: post);
              },
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => const Loader())),
    );
  }
}

class MessagesScreen extends ConsumerWidget {
  final String name;
  final String uid;
  const MessagesScreen({Key? key, required this.name, required this.uid})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: Colors.green.withOpacity(0.8),
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(31, 44, 52, 1),
        title: ref.watch(onlineProvider(uid)).when(
              data: (data) => Column(
                children: [
                  Text(
                    name.replaceAll("%20", " "),
                  ),
                  Text(data.isOnline ? "online" : "offline",
                      style: TextStyle(
                          fontSize: 13, fontWeight: FontWeight.normal))
                ],
              ),
              error: (error, stackTrace) => ErrorText(error: error.toString()),
              loading: () => Loader(),
            ),
        centerTitle: false,
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.video_call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.call),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatList(recieverUserId: uid),
          ),
          BottomChatField(recieverUserId: uid),
        ],
      ),
    );
  }
}
