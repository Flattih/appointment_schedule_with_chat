import 'package:appointment_schedule_app/core/constants/firebase_constants.dart';
import 'package:appointment_schedule_app/core/utils/failure.dart';
import 'package:appointment_schedule_app/core/type_defs.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:appointment_schedule_app/models/appointment_post_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';

import '../../../core/providers/firebase_providers.dart';

final postRepositoryProvider = Provider((ref) {
  return PostRepository(
    firestore: ref.watch(firestoreProvider),
  );
});

class PostRepository {
  final FirebaseFirestore _firestore;
  PostRepository({required FirebaseFirestore firestore})
      : _firestore = firestore;

  CollectionReference get _posts =>
      _firestore.collection(FirebaseConstants.postsCollection);

  FutureVoid addPost(Post post) async {
    try {
      return right(_posts.doc(post.id).set(post.toMap()));
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<List<Post>> fetchAllPosts() {
    return _posts
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((event) => event.docs
            .map(
              (e) => Post.fromMap(e.data() as Map<String, dynamic>),
            )
            .toList());
  }

  getUserProfilePicFromPost(WidgetRef ref) {
    _posts.where("uid", isEqualTo: ref.watch(userProvider)!.uid).get();
  }

  FutureVoid deletePost(Post post) async {
    try {
      return right(_posts.doc(post.id).delete());
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  void upvote(Post post, String userId) {
    if (post.approvalsCount.contains(userId)) {
      _posts.doc(post.id).update({
        'approvalsCount': FieldValue.arrayRemove([userId]),
      });
    } else {
      _posts.doc(post.id).update({
        'approvalsCount': FieldValue.arrayUnion([userId]),
      });
    }
  }

  void upvote2(Post post, String userId) {
    if (post.approvalsCount2.contains(userId)) {
      _posts.doc(post.id).update({
        'approvalsCount2': FieldValue.arrayRemove([userId]),
      });
    } else {
      _posts.doc(post.id).update({
        'approvalsCount2': FieldValue.arrayUnion([userId]),
      });
    }
  }

  void upvote3(Post post, String userId) {
    if (post.approvalsCount3.contains(userId)) {
      _posts.doc(post.id).update({
        'approvalsCount3': FieldValue.arrayRemove([userId]),
      });
    } else {
      _posts.doc(post.id).update({
        'approvalsCount3': FieldValue.arrayUnion([userId]),
      });
    }
  }
}
