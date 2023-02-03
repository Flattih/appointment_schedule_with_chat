import 'package:appointment_schedule_app/core/constants/constants.dart';
import 'package:appointment_schedule_app/core/constants/firebase_constants.dart';
import 'package:appointment_schedule_app/core/utils/failure.dart';
import 'package:appointment_schedule_app/core/type_defs.dart';
import 'package:appointment_schedule_app/models/user_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../core/providers/firebase_providers.dart';

final authRepositoryProvider = Provider((ref) => AuthRepository(
    ref: ref,
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;

  AuthRepository({
    required FirebaseFirestore firestore,
    required FirebaseAuth auth,
    required GoogleSignIn googleSignIn,
    required Ref ref,
  })  : _auth = auth,
        _firestore = firestore,
        _googleSignIn = googleSignIn;
  Stream<User?> get authStateChange => _auth.authStateChanges();
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  void signOutGoogle() {
    _googleSignIn.signOut();
    _auth.signOut();
  }

  FutureEither<UserModel> signInAnonymously() async {
    try {
      UserCredential userCredential = await _auth.signInAnonymously();
      UserModel userModel = UserModel(
          isOnline: true,
          name: "Anonim Kullanıcı",
          profilePic:
              "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcShzNx_Ei3jUy8_DnvmAWtjL3Cjeq3Rmu_1VVWLUUU3qW0rJUCeriXC7VbXtBAVN9GrQU0&usqp=CAU",
          uid: userCredential.user!.uid);
      await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      return right(userModel);
    } on FirebaseAuthException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  FutureEither<UserModel> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      UserModel userModel;
      if (userCredential.additionalUserInfo!.isNewUser) {
        userModel = UserModel(
            isOnline: true,
            email: userCredential.user!.email ?? "",
            fcmtoken: "",
            name: userCredential.user!.displayName ?? "No Name",
            profilePic:
                userCredential.user!.photoURL ?? Constants.profilePicDefault,
            uid: userCredential.user!.uid);
        await _users.doc(userCredential.user!.uid).set(userModel.toMap());
      } else {
        userModel = await getUserData(userCredential.user!.uid).first;
      }
      return right(userModel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      return left(Failure(e.toString()));
    }
  }

  Stream<UserModel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => UserModel.fromMap(event.data() as Map<String, dynamic>));
  }

  setUserState(bool isOnline) async {
    await _firestore.collection('users').doc(_auth.currentUser!.uid).update({
      'isOnline': isOnline,
    });
  }
}
