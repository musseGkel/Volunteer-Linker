import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:volunteer_linker/core/models/profile_info.dart';

import '../../../../core/enums.dart';
import '../../../../core/models/organization.dart';
import '../../../../core/models/user_data.dart';

class AuthDatasource {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  User? get currentUser => _firebaseAuth.currentUser;

  Future<User?> login({
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return currentUser;
  }

  Future<User?> register({
    required String email,
    required String password,
    required String name,
    required UserType userType,
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    User? user = userCredential.user;
    if (user != null) {
      await _firestore.collection('profileInfo').doc(user.uid).set(
            ProfileInfo(
              userType: userType,
            ).toJson(),
          );
      if (userType == UserType.volunteer) {
        await _firestore.collection('users').doc(user.uid).set(
              UserData(
                id: user.uid,
                name: name.trim(),
                email: email,
                username: "",
                userType: userType,
                profilePictureUrl: '',
                interests: [],
                skills: [],
                availability: {},
                volunteerActivities: [],
                bio: "",
                phoneNumber: "",
              ).toJson(),
            );
      } else if (userType == UserType.organization) {
        await _firestore.collection("organizations").doc(user.uid).set(
              Organization(
                id: user.uid,
                name: name.trim(),
                email: email,
                userName: "",
                userType: userType,
                contactNumber: '',
                description: '',
                address: '',
                profilePictureUrl: '',
                postedOpportunities: [],
              ).toJson(),
            );
      }
    }
    return currentUser;
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Stream<User?> get authStateChanges {
    return _firebaseAuth.authStateChanges();
  }
}
