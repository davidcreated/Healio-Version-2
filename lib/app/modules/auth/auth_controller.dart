import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:healio_version_2/core/services/auth_service.dart';
import 'package:healio_version_2/app/routes/approutes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService.instance;

  // Reactive user state
  late final Rx<User?> _user;

  @override
  void onReady() {
    super.onReady();
    // Initialize the user stream and set up a listener to handle navigation
    _user = Rx<User?>(_authService.currentUser);
    _user.bindStream(_authService.authStateChanges);

    // Add a listener to react to authentication changes
    ever(_user, _handleAuthStateChanged);
  }

  // --- Getters ---

  User? get currentUser => _user.value;
  bool get isAuthenticated => _user.value != null;

  // --- Auth State Change Handler ---

  void _handleAuthStateChanged(User? user) {
    if (user == null) {
      // If the user is logged out, navigate to the login screen
      ; //Get.offAllNamed(AppRoutes.loginScreen); // Make sure you have a login route
    } else {
      // If the user is logged in, navigate to the patient home page
      Get.offAllNamed(AppRoutes.patienthomepage); // Make sure you have a home route
    }
  }

  // --- Authentication Methods ---

  Future<void> signUp(String email, String password) async {
    await _authService.signUpWithEmailAndPassword(email, password);
  }

  Future<void> signIn(String email, String password) async {
    await _authService.signInWithEmailAndPassword(email, password);
  }

  Future<void> signInWithGoogle() async {
    await _authService.signInWithGoogle();
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }
}
