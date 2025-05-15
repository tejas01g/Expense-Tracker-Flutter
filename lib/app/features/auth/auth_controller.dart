import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/services/auth_service.dart';
import '../../../app/routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  
  final email = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
  final isLogin = true.obs;
  final isLoading = false.obs;
  final isPasswordVisible = false.obs;
  final isConfirmPasswordVisible = false.obs;

  // Error messages
  final emailError = ''.obs;
  final passwordError = ''.obs;
  final confirmPasswordError = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Check if user is already logged in
    if (_authService.isLoggedIn) {
      Get.offAllNamed(Routes.HOME);
    }
  }

  void toggleAuthMode() {
    isLogin.value = !isLogin.value;
    clearErrors();
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void clearErrors() {
    emailError.value = '';
    passwordError.value = '';
    confirmPasswordError.value = '';
  }

  bool validateEmail(String value) {
    if (value.isEmpty) {
      emailError.value = 'Please enter your email';
      return false;
    }
    if (!GetUtils.isEmail(value)) {
      emailError.value = 'Please enter a valid email';
      return false;
    }
    emailError.value = '';
    return true;
  }

  bool validatePassword(String value) {
    if (value.isEmpty) {
      passwordError.value = 'Please enter your password';
      return false;
    }
    if (value.length < 6) {
      passwordError.value = 'Password must be at least 6 characters';
      return false;
    }
    passwordError.value = '';
    return true;
  }

  bool validateConfirmPassword(String value) {
    if (value.isEmpty) {
      confirmPasswordError.value = 'Please confirm your password';
      return false;
    }
    if (value != password.value) {
      confirmPasswordError.value = 'Passwords do not match';
      return false;
    }
    confirmPasswordError.value = '';
    return true;
  }

  Future<void> handleSubmit() async {
    clearErrors();

    bool isEmailValid = validateEmail(email.value);
    bool isPasswordValid = validatePassword(password.value);
    bool isConfirmPasswordValid = isLogin.value ? true : validateConfirmPassword(confirmPassword.value);

    if (isEmailValid && isPasswordValid && isConfirmPasswordValid) {
      try {
        isLoading.value = true;
        if (isLogin.value) {
          await _authService.signInWithEmailAndPassword(
            email.value,
            password.value,
          );
        } else {
          await _authService.signUpWithEmailAndPassword(
            email.value,
            password.value,
          );
        }
        Get.offAllNamed(Routes.HOME);
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } finally {
        isLoading.value = false;
      }
    }
  }

  Future<void> handleForgotPassword() async {
    if (!validateEmail(email.value)) {
      return;
    }

    try {
      isLoading.value = true;
      await _authService.sendPasswordResetEmail(email.value);
      Get.snackbar(
        'Success',
        'Password reset email sent. Please check your inbox.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }
} 