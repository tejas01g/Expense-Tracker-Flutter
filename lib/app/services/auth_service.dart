import 'package:get/get.dart';

class AuthService extends GetxService {
  final _isLoggedIn = false.obs;
  bool get isLoggedIn => _isLoggedIn.value;
  bool get isAuthenticated => _isLoggedIn.value;

  Future<AuthService> init() async {
    // Initialize any necessary services
    return this;
  }

  Future<void> signInWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any valid email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn.value = true;
    } else {
      throw 'Invalid email or password';
    }
  }

  Future<void> signUpWithEmailAndPassword(String email, String password) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any valid email/password
    if (email.isNotEmpty && password.isNotEmpty) {
      _isLoggedIn.value = true;
    } else {
      throw 'Invalid email or password';
    }
  }

  Future<void> signOut() async {
    // Simulate network delay
    await Future.delayed(const Duration(milliseconds: 500));
    _isLoggedIn.value = false;
  }

  Future<void> sendPasswordResetEmail(String email) async {
    // Simulate network delay
    await Future.delayed(const Duration(seconds: 1));
    
    // For demo purposes, accept any valid email
    if (!GetUtils.isEmail(email)) {
      throw 'Invalid email address';
    }
  }
} 