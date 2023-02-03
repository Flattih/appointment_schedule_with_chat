import 'package:appointment_schedule_app/core/constants/firebase_constants.dart';
import 'package:appointment_schedule_app/core/providers/firebase_providers.dart';
import 'package:appointment_schedule_app/core/utils/utils.dart';
import 'package:appointment_schedule_app/features/add_appointment/repository/post_repository.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:uuid/uuid.dart';

import '../../../models/appointment_post_model.dart';

final individualProvider = StreamProvider.family<Post, String>((ref, id) {
  return ref.watch(postControllerProvider.notifier).getIndividualPost(id);
});

final allPostsProvider = StreamProvider((ref) {
  final postController = ref.watch(postControllerProvider.notifier);
  return postController.fetchAllPosts();
});

final postControllerProvider =
    StateNotifierProvider<PostController, bool>((ref) {
  final postRepository = ref.watch(postRepositoryProvider);

  return PostController(
    postRepository: postRepository,
    ref: ref,
  );
});

class PostController extends StateNotifier<bool> {
  final PostRepository _postRepository;
  final Ref _ref;
  PostController({required PostRepository postRepository, required Ref ref})
      : _postRepository = postRepository,
        _ref = ref,
        super(false);

  void sharePost(
      {required BuildContext context,
      required String title,
      required String profImg,
      required String appointmentDate,
      required String appointmentTime,
      String? appointmentTime2,
      String? appointmentTime3,
      required String location,
      required String description}) async {
    state = true;
    String postId = const Uuid().v1();
    final user = _ref.read(userProvider)!;

    final Post post = Post(
        appointmentTime3: appointmentTime3,
        appointmentTime: appointmentTime,
        appointmentTime2: appointmentTime2,
        approvalsCount2: [],
        approvalsCount3: [],
        profImg: profImg,
        id: postId,
        title: title,
        description: description,
        location: location,
        approvalsCount: [],
        createdAt: DateTime.now(),
        username: user.name,
        uid: user.uid,
        appointmentDate: appointmentDate);
    final res = await _postRepository.addPost(post);
    state = false;
    res.fold(
        (l) => showSnackBar(l.message),
        (r) =>
            {showSnackBar("poll-created".tr()), Routemaster.of(context).pop()});
  }

  Stream<List<Post>> fetchAllPosts() {
    return _postRepository.fetchAllPosts();
  }

  void deletePost(Post post, BuildContext context) async {
    final res = await _postRepository.deletePost(post);

    res.fold(
      (l) => null,
      (r) => showSnackBar(
        "poll-deleted".tr(),
      ),
    );
  }

  void upvote(Post post) {
    final uid = _ref.read(userProvider)!.uid;
    _postRepository.upvote(post, uid);
  }

  void upvote2(Post post) {
    final uid = _ref.read(userProvider)!.uid;
    _postRepository.upvote2(post, uid);
  }

  void upvote3(Post post) {
    final uid = _ref.read(userProvider)!.uid;
    _postRepository.upvote3(post, uid);
  }

  Stream<Post> getIndividualPost(String id) {
    return _ref
        .watch(firestoreProvider)
        .collection(FirebaseConstants.postsCollection)
        .doc(id)
        .snapshots()
        .map((event) => Post.fromMap(event.data() as Map<String, dynamic>));
  }
}
