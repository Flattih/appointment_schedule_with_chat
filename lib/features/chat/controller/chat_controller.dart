import 'dart:io';

import 'package:appointment_schedule_app/core/enums/message_enum.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:appointment_schedule_app/features/chat/repository/chat_repository.dart';
import 'package:appointment_schedule_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../models/chat_contact_model.dart';
import '../../../models/message_model.dart';

final chatControllerProvider = Provider.autoDispose<ChatController>((ref) {
  return ChatController(
    chatRepository: ref.watch(chatRepositoryProvider),
    ref: ref,
  );
});

final chatContactsProvider = StreamProvider.autoDispose((ref) {
  return ref.watch(chatControllerProvider).chatContacts();
});
final chatMessagesProvider = StreamProvider.family
    .autoDispose<List<Message>, String>((ref, recieverUserId) {
  return ref.watch(chatControllerProvider).chatStream(recieverUserId);
});

class ChatController {
  final ChatRepository _chatRepository;
  final ProviderRef _ref;
  ChatController(
      {required ChatRepository chatRepository, required ProviderRef ref})
      : _chatRepository = chatRepository,
        _ref = ref;

  void sendTextMessage(
      BuildContext context, String text, String recieverUserId) {
    UserModel user = _ref.read(userProvider)!;
    _chatRepository.sendTextMessage(
      context: context,
      text: text,
      recieverUserId: recieverUserId,
      senderUser: user,
    );
  }

  Stream<List<ChatContact>> chatContacts() {
    return _chatRepository.getChatContacts();
  }

  Stream<List<Message>> chatStream(String recieverUserId) {
    return _chatRepository.getChatStream(recieverUserId);
  }

  void sendFileMessage(
    BuildContext context,
    File file,
    String recieverUserId,
    MessageEnum messageEnum,
  ) {
    // final messageReply = ref.read(messageReplyProvider);

    _chatRepository.sendFileMessage(
      context: context,
      file: file,
      recieverUserId: recieverUserId,
      senderUserData: _ref.read(userProvider)!,
      messageEnum: messageEnum,
      ref: _ref,
    );
    //ref.read(messageReplyProvider.state).update((state) => null);
  }

  void setChatMessageSeen(
    BuildContext context,
    String recieverUserId,
    String messageId,
  ) {
    _chatRepository.setChatMessageSeen(
      context,
      recieverUserId,
      messageId,
    );
  }
}
