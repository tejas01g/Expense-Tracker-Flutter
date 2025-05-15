import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_theme.dart';
import 'auth_controller.dart';

class AuthScreen extends GetView<AuthController> {
  const AuthScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppTheme.primaryLight,
              AppTheme.secondaryLight,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 40),
                  Text(
                    controller.isLogin.value ? 'Welcome Back!' : 'Create Account',
                    style: const TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    controller.isLogin.value
                        ? 'Sign in to continue'
                        : 'Sign up to get started',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white70,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  _buildAuthForm(),
                  const SizedBox(height: 24),
                  _buildToggleButton(),
                  const SizedBox(height: 24),
                  _buildSocialLoginButtons(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAuthForm() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildEmailField(),
            const SizedBox(height: 16),
            _buildPasswordField(),
            if (!controller.isLogin.value) ...[
              const SizedBox(height: 16),
              _buildConfirmPasswordField(),
            ],
            const SizedBox(height: 16),
            _buildForgotPasswordButton(),
            const SizedBox(height: 24),
            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Obx(() => TextField(
          onChanged: (value) {
            controller.email.value = value;
            controller.validateEmail(value);
          },
          decoration: InputDecoration(
            labelText: 'Email',
            prefixIcon: const Icon(Icons.email_outlined),
            errorText: controller.emailError.value.isEmpty
                ? null
                : controller.emailError.value,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          keyboardType: TextInputType.emailAddress,
        ));
  }

  Widget _buildPasswordField() {
    return Obx(() => TextField(
          onChanged: (value) {
            controller.password.value = value;
            controller.validatePassword(value);
          },
          obscureText: !controller.isPasswordVisible.value,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: controller.togglePasswordVisibility,
            ),
            errorText: controller.passwordError.value.isEmpty
                ? null
                : controller.passwordError.value,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ));
  }

  Widget _buildConfirmPasswordField() {
    return Obx(() => TextField(
          onChanged: (value) {
            controller.confirmPassword.value = value;
            controller.validateConfirmPassword(value);
          },
          obscureText: !controller.isConfirmPasswordVisible.value,
          decoration: InputDecoration(
            labelText: 'Confirm Password',
            prefixIcon: const Icon(Icons.lock_outline),
            suffixIcon: IconButton(
              icon: Icon(
                controller.isConfirmPasswordVisible.value
                    ? Icons.visibility_off
                    : Icons.visibility,
              ),
              onPressed: controller.toggleConfirmPasswordVisibility,
            ),
            errorText: controller.confirmPasswordError.value.isEmpty
                ? null
                : controller.confirmPasswordError.value,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ));
  }

  Widget _buildForgotPasswordButton() {
    return Obx(() => controller.isLogin.value
        ? TextButton(
            onPressed: controller.handleForgotPassword,
            child: const Text('Forgot Password?'),
          )
        : const SizedBox.shrink());
  }

  Widget _buildSubmitButton() {
    return Obx(() => ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : controller.handleSubmit,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.primaryLight,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: controller.isLoading.value
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Text(
                  controller.isLogin.value ? 'Sign In' : 'Sign Up',
                  style: const TextStyle(fontSize: 16),
                ),
        ));
  }

  Widget _buildToggleButton() {
    return Obx(() => TextButton(
          onPressed: controller.toggleAuthMode,
          child: Text(
            controller.isLogin.value
                ? 'Don\'t have an account? Sign Up'
                : 'Already have an account? Sign In',
            style: const TextStyle(color: Colors.white),
          ),
        ));
  }

  Widget _buildSocialLoginButtons() {
    return Column(
      children: [
        const Text(
          'Or continue with',
          style: TextStyle(color: Colors.white70),
        ),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildSocialButton(
              icon: Icons.g_mobiledata,
              onPressed: () {
                // TODO: Implement Google sign in
              },
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.facebook,
              onPressed: () {
                // TODO: Implement Facebook sign in
              },
            ),
            const SizedBox(width: 16),
            _buildSocialButton(
              icon: Icons.apple,
              onPressed: () {
                // TODO: Implement Apple sign in
              },
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSocialButton({
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        icon: Icon(icon),
        onPressed: onPressed,
        color: AppTheme.primaryLight,
      ),
    );
  }
} 