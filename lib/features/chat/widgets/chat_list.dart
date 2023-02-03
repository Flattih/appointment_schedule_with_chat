import 'package:appointment_schedule_app/core/common/error_Text.dart';
import 'package:appointment_schedule_app/core/common/loader.dart';
import 'package:appointment_schedule_app/features/chat/controller/chat_controller.dart';
import 'package:appointment_schedule_app/features/chat/widgets/my_message_card.dart';
import 'package:appointment_schedule_app/features/chat/widgets/sender_message_card.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../auth/controller/auth_controller.dart';

class ChatList extends ConsumerStatefulWidget {
  final String recieverUserId;
  const ChatList({Key? key, required this.recieverUserId}) : super(key: key);
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChatListState();
}

class _ChatListState extends ConsumerState<ChatList> {
  bool shouldScrollDown = true;
  final ScrollController messageController = ScrollController();

  @override
  void dispose() {
    super.dispose();
    messageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(chatMessagesProvider(widget.recieverUserId)).when(
          data: (data) {
            return ListView.builder(
              controller: messageController,
              itemCount: data.length,
              itemBuilder: (context, index) {
                if (shouldScrollDown) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    messageController
                        .jumpTo(messageController.position.maxScrollExtent);
                  });
                  shouldScrollDown = false;
                }
                final messageData = data[index];
                if (!messageData.isSeen &&
                    messageData.recieverid == ref.watch(userProvider)!.uid) {
                  ref.read(chatControllerProvider).setChatMessageSeen(
                      context, widget.recieverUserId, messageData.messageId);
                }
                if (ref.watch(userProvider)!.uid == messageData.senderId) {
                  return MyMessageCard(
                    isSeen: messageData.isSeen,
                    type: messageData.type,
                    message: messageData.text,
                    date: DateFormat.Hm().format(messageData.timeSent),
                  );
                }
                return SenderMessageCard(
                  type: messageData.type,
                  message: messageData.text,
                  date: DateFormat.Hm().format(messageData.timeSent),
                );
              },
            );
          },
          error: (error, stackTrace) {
            return ErrorText(error: error.toString());
          },
          loading: () => Loader(),
        );
  }
}
