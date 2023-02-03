import 'dart:io';
import 'package:appointment_schedule_app/core/providers/firebase_providers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fpdart/fpdart.dart';
import 'package:appointment_schedule_app/core/common/common_firebase_storage_repo.dart';
import 'package:appointment_schedule_app/core/utils/utils.dart';
import 'package:appointment_schedule_app/features/auth/controller/auth_controller.dart';
import 'package:appointment_schedule_app/features/profile/repository/user_profile_repository.dart';
import 'package:appointment_schedule_app/models/appointment_post_model.dart';
import 'package:appointment_schedule_app/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final userProfileControllerProvider =
    StateNotifierProvider<UserProfileController, bool>((ref) {
  final userProfileRepository = ref.watch(userRepositoryProvider);

  return UserProfileController(
      firestore: ref.watch(firestoreProvider),
      userProfileRepository: userProfileRepository,
      ref: ref,
      storageRepository: ref.watch(commonFirebaseStorageRepositoryProvider));
});

final searchUserProvider = StreamProvider.family((ref, String query) {
  return ref.watch(userProfileControllerProvider.notifier).searchUser(query);
});
final getUserPostsProvider = StreamProvider.family((ref, String uid) {
  return ref.read(userProfileControllerProvider.notifier).getUserPosts(uid);
});

class UserProfileController extends StateNotifier<bool> {
  final FirebaseFirestore _firestore;
  final UserProfileRepository _userProfileRepository;
  final Ref _ref;
  final CommonFirebaseStorageRepository _storageRepository;

  UserProfileController({
    required UserProfileRepository userProfileRepository,
    required FirebaseFirestore firestore,
    required Ref ref,
    required CommonFirebaseStorageRepository storageRepository,
  })  : _userProfileRepository = userProfileRepository,
        _ref = ref,
        _firestore = firestore,
        _storageRepository = storageRepository,
        super(false);

  Stream<List<UserModel>> searchUser(String query) {
    return _userProfileRepository.searchUser(query);
  }

  Stream<List<Post>> getUserPosts(String uid) {
    return _userProfileRepository.getUserPosts(uid);
  }

  void editProfile({
    required File? profileFile,
    required BuildContext context,
  }) async {
    state = true;
    try {
      UserModel user = _ref.read(userProvider)!;

      if (profileFile != null) {
        final newProfilePic = await _storageRepository.storeFileToFirebase(
          'users/profile/${user.uid}',
          profileFile,
        );
        user = user.copyWith(profilePic: newProfilePic);
        final res = await _userProfileRepository.editProfile(user);

        _firestore
            .collection('posts')
            .where('uid', isEqualTo: user.uid)
            .snapshots()
            .forEach((element) {
          element.docs.forEach((doc) {
            _firestore.collection('posts').doc(doc.id).update({
              'profImg': user.profilePic,
            });
          });
        });

        print(user);

        state = false;
        res.fold(
          (l) => showSnackBar(l.message),
          (r) {
            _ref.read(userProvider.notifier).update((state) => user);
            showSnackBar('Profile Updated');
          },
        );
      }
      state = false;
    } catch (e) {
      showSnackBar(e.toString());
    }
  }
}
