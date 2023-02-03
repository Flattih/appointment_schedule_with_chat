import 'package:animate_do/animate_do.dart';
import 'package:appointment_schedule_app/core/extensions/context_extension.dart';
import 'package:appointment_schedule_app/core/utils/dynamicc_link.dart';
import 'package:appointment_schedule_app/features/add_appointment/controller/post_controller.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:appointment_schedule_app/models/appointment_post_model.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:share_plus/share_plus.dart';

class PostCard extends ConsumerWidget {
  final Post post;
  const PostCard({super.key, required this.post});
  void upvotePost(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).upvote(post);
  }

  void upvotePost2(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).upvote2(post);
  }

  void upvotePost3(WidgetRef ref) {
    ref.read(postControllerProvider.notifier).upvote3(post);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider)!;
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: context.theme.cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                AbsorbPointer(
                  absorbing: post.uid == user.uid,
                  child: GestureDetector(
                    onTap: () => Routemaster.of(context)
                        .push('/messages/${post.username.trim()}/${post.uid}'),
                    child: CircleAvatar(
                      backgroundImage: NetworkImage(post.profImg),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Text(post.username),
                const Spacer(),
                if (post.uid == ref.watch(userProvider)!.uid)
                  IconButton(
                    onPressed: () => ref
                        .read(postControllerProvider.notifier)
                        .deletePost(post, context),
                    icon: const Icon(Icons.delete),
                  ),
                IconButton(
                    onPressed: () {
                      DynamicLinkPro()
                          .createLink(post.id)
                          .then((value) => Share.share(value));
                    },
                    icon: const Icon(Icons.share))
              ],
            ),
            Roulette(
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Text(
                  "${"meeting-date".tr()}${post.appointmentDate}",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.red,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Text("${"meeting-place".tr()} ${post.location}"),
            ),
            const SizedBox(height: 15),
            Center(
              child: Chip(
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                ),
                side: BorderSide(color: context.primaryColor),
                label: Text(post.title),
                labelStyle: TextStyle(
                    color: context.primaryColor.withOpacity(0.4),
                    fontWeight: FontWeight.bold,
                    fontSize: 18),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Text(post.description),
            ),
            const SizedBox(
              height: 12,
            ),
            Wrap(
              runSpacing: 20,
              spacing: 20,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 7),
                  decoration: BoxDecoration(
                    color: context.primaryColor.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(post.appointmentTime),
                      const SizedBox(width: 12),
                      SizedBox(
                        height: 25,
                        child: VerticalDivider(
                          thickness: 2,
                          width: 2,
                          endIndent: 1,
                          color: context.primaryColor,
                        ),
                      ),
                      post.approvalsCount.contains(user.uid)
                          ? IconButton(
                              onPressed: () {
                                upvotePost(ref);
                              },
                              icon: const Icon(Icons.close))
                          : IconButton(
                              onPressed: () {
                                upvotePost(ref);
                              },
                              icon: const Icon(Icons.done),
                            ),
                      SizedBox(
                        height: 25,
                        child: VerticalDivider(
                          thickness: 2,
                          width: 2,
                          endIndent: 1,
                          color: context.primaryColor,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 14.0),
                        child: Text(post.approvalsCount.length.toString()),
                      )
                    ],
                  ),
                ),
                post.appointmentTime2 != null
                    ? Container(
                        // margin: const EdgeInsets.only(left: 7),
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(post.appointmentTime2!),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 25,
                              child: VerticalDivider(
                                thickness: 2,
                                width: 2,
                                endIndent: 1,
                                color: context.primaryColor,
                              ),
                            ),
                            post.approvalsCount2.contains(user.uid)
                                ? IconButton(
                                    onPressed: () {
                                      upvotePost2(ref);
                                    },
                                    icon: const Icon(Icons.close))
                                : IconButton(
                                    onPressed: () {
                                      upvotePost2(ref);
                                    },
                                    icon: const Icon(Icons.done),
                                  ),
                            SizedBox(
                              height: 25,
                              child: VerticalDivider(
                                thickness: 2,
                                width: 2,
                                endIndent: 1,
                                color: context.primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child:
                                  Text(post.approvalsCount2.length.toString()),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
                post.appointmentTime3 != null
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 7),
                        decoration: BoxDecoration(
                          color: context.primaryColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(post.appointmentTime3!),
                            const SizedBox(width: 12),
                            SizedBox(
                              height: 25,
                              child: VerticalDivider(
                                thickness: 2,
                                width: 2,
                                endIndent: 1,
                                color: context.primaryColor,
                              ),
                            ),
                            post.approvalsCount3.contains(user.uid)
                                ? IconButton(
                                    onPressed: () {
                                      upvotePost3(ref);
                                    },
                                    icon: const Icon(Icons.close))
                                : IconButton(
                                    onPressed: () {
                                      upvotePost3(ref);
                                    },
                                    icon: const Icon(Icons.done),
                                  ),
                            SizedBox(
                              height: 25,
                              child: VerticalDivider(
                                thickness: 2,
                                width: 2,
                                endIndent: 1,
                                color: context.primaryColor,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 14.0),
                              child:
                                  Text(post.approvalsCount3.length.toString()),
                            )
                          ],
                        ),
                      )
                    : const SizedBox(),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
