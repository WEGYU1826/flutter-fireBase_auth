import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_firebase_auth/src/enums.dart';

class AuthProvider with ChangeNotifier {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  bool _isAuthLoading = false;
  get isAuthLoading => _isAuthLoading;
  setIsAuthLoading(bool value) {
    _isAuthLoading = value;
    notifyListeners();
  }

  get user => _firebaseAuth.currentUser;

  getAuthState() => _firebaseAuth.authStateChanges();

  Future signIn({required String email, required String password}) async {
    setIsAuthLoading(true);
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      setIsAuthLoading(false);
    } catch (e) {
      setIsAuthLoading(false);
      rethrow;
    }
  }

  Future signUp({required String email, required String password}) async {
    setIsAuthLoading(true);
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      notifyListeners(); //every time you change something notify it to the provider
      setIsAuthLoading(false);
    } catch (e) {
      setIsAuthLoading(false);
      rethrow;
    }
  }

  Future resetPassword({required String email}) async {
    setIsAuthLoading(true);
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      notifyListeners();
      setIsAuthLoading(false);
    } catch (e) {
      setIsAuthLoading(false);
      rethrow;
    }
  }

  Future signOut() async {
    try {
      await _firebaseAuth.signOut();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}
