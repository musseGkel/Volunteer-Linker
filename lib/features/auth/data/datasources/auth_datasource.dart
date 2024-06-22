import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
  }) async {
    UserCredential userCredential =
        await _firebaseAuth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: password.trim(),
    );

    User? user = userCredential.user;
    if (user != null) {
      await _firestore.collection('users').doc(user.uid).set({
        'id': user.uid,
        'name': name.trim(),
        'email': user.email,
        'profilePictureUrl': '',
        'interests': [],
        'skills': [],
        'availability': '',
        'volunteerActivities': [],
      });
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
