import 'package:appointment_schedule_app/core/common/error_Text.dart';
import 'package:appointment_schedule_app/core/common/loader.dart';
import 'package:appointment_schedule_app/core/common/post_card.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:appointment_schedule_app/features/profile/components/info.dart';
import 'package:appointment_schedule_app/features/profile/controller/user_profile_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileScreen extends ConsumerWidget {
  final String uid;
  const ProfileScreen({
    required this.uid,
    super.key,
  });
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(getUserDataProvider(uid)).when(
        data: (user) {
          return SafeArea(
            child: Scaffold(
              appBar: AppBar(),
              body: SingleChildScrollView(
                child: Column(
                  children: [
                    Info(
                        name: user.name,
                        profilePic: user.profilePic,
                        uid: user.uid),
                    ref.watch(getUserPostsProvider(uid)).when(
                          data: (data) {
                            return ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: data.length,
                              itemBuilder: (BuildContext context, int index) {
                                final post = data[index];
                                return PostCard(post: post);
                              },
                            );
                          },
                          error: (error, stackTrace) {
                            return ErrorText(error: error.toString());
                          },
                          loading: () => const Loader(),
                        ),
                  ],
                ),
              ),
            ),
          );
        },
        error: (error, stackTrace) => ErrorText(error: error.toString()),
        loading: () => const Loader());
  }
}
