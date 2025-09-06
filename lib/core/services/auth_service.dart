
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService extends GetxService {
  // Private constructor for singleton pattern
  AuthService._();

  // Static instance getter
  static final AuthService instance = AuthService._();

  // Firebase and Google Sign-In instances
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Reactive user state
  final Rx<User?> _user = Rx<User?>(null);

  @override
  void onReady() {
    super.onReady();
    // Bind the user stream from Firebase to our reactive variable
    _user.bindStream(_auth.authStateChanges());
  }

  // --- Getters ---

  // Get the current user
  User? get currentUser => _user.value;

  // Get the current user's UID
  String? get currentUserId => _user.value?.uid;

  // Stream of authentication state changes
  Stream<User?> get authStateChanges => _auth.authStateChanges();

  // --- Authentication Methods ---

  /// Sign up with email and password.
  Future<UserCredential?> signUpWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions (e.g., email-already-in-use)
      Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      return null;
    } catch (e) {
      // Handle other exceptions
      Get.snackbar('Error', 'An unexpected error occurred.');
      return null;
    }
  }

  /// Sign in with email and password.
  Future<UserCredential?> signInWithEmailAndPassword(String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      // Handle specific Firebase exceptions (e.g., user-not-found)
      Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      return null;
    } catch (e) {
      // Handle other exceptions
      Get.snackbar('Error', 'An unexpected error occurred.');
      return null;
    }
  }

  /// Sign in with Google.
  Future<UserCredential?> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        // The user canceled the sign-in
        return null;
      }

      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      return await _auth.signInWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'An unknown error occurred.');
      return null;
    } catch (e) {
      Get.snackbar('Error', 'An unexpected error occurred.');
      return null;
    }
  }

  /// Sign out from all providers.
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut();
    } catch (e) {
      Get.snackbar('Error', 'Failed to sign out.');
    }
  }
}
