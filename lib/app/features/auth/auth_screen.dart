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
                  // Logo and Welcome Text
                  Hero(
                    tag: 'app_logo',
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      size: 80,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Welcome Back!',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Sign in to continue',
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 40),
                  // Auth Mode Toggle
                  Obx(() => Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            _buildToggleButton(
                              text: 'Login',
                              isSelected: controller.isLogin.value,
                              onTap: () => controller.toggleAuthMode(),
                            ),
                            _buildToggleButton(
                              text: 'Sign Up',
                              isSelected: !controller.isLogin.value,
                              onTap: () => controller.toggleAuthMode(),
                            ),
                          ],
                        ),
                      )),
                  const SizedBox(height: 32),
                  // Form Fields
                  Obx(() => Column(
                        children: [
                          _buildTextField(
                            context,
                            controller: TextEditingController(text: controller.email.value),
                            hintText: 'Email',
                            prefixIcon: Icons.email_outlined,
                            onChanged: (value) => controller.email.value = value,
                            errorText: controller.emailError.value,
                          ),
                          const SizedBox(height: 16),
                          _buildTextField(
                            context,
                            controller: TextEditingController(text: controller.password.value),
                            hintText: 'Password',
                            prefixIcon: Icons.lock_outline,
                            isPassword: true,
                            isPasswordVisible: controller.isPasswordVisible.value,
                            onTogglePassword: controller.togglePasswordVisibility,
                            onChanged: (value) => controller.password.value = value,
                            errorText: controller.passwordError.value,
                          ),
                          if (!controller.isLogin.value) ...[
                            const SizedBox(height: 16),
                            _buildTextField(
                              context,
                              controller: TextEditingController(text: controller.confirmPassword.value),
                              hintText: 'Confirm Password',
                              prefixIcon: Icons.lock_outline,
                              isPassword: true,
                              isPasswordVisible: controller.isConfirmPasswordVisible.value,
                              onTogglePassword: controller.toggleConfirmPasswordVisibility,
                              onChanged: (value) => controller.confirmPassword.value = value,
                              errorText: controller.confirmPasswordError.value,
                            ),
                          ],
                        ],
                      )),
                  const SizedBox(height: 24),
                  // Remember Me & Forgot Password
                  Obx(() => controller.isLogin.value
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Checkbox(
                                  value: false,
                                  onChanged: (value) {
                                    // TODO: Implement remember me
                                  },
                                  fillColor: MaterialStateProperty.all(Colors.white),
                                  checkColor: AppTheme.primaryLight,
                                ),
                                Text(
                                  'Remember Me',
                                  style: TextStyle(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                              ],
                            ),
                            TextButton(
                              onPressed: controller.handleForgotPassword,
                              child: const Text(
                                'Forgot Password?',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        )
                      : const SizedBox.shrink()),
                  const SizedBox(height: 32),
                  // Submit Button
                  Obx(() => ElevatedButton(
                        onPressed: controller.isLoading.value ? null : controller.handleSubmit,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: AppTheme.primaryLight,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: controller.isLoading.value
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primaryLight),
                                ),
                              )
                            : Text(
                                controller.isLogin.value ? 'Login' : 'Sign Up',
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      )),
                  const SizedBox(height: 32),
                  // Social Login
                  Column(
                    children: [
                      Text(
                        'Or continue with',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialButton(
                            context,
                            icon: Icons.g_mobiledata,
                            onPressed: () {
                              // TODO: Implement Google login
                            },
                          ),
                          const SizedBox(width: 16),
                          _buildSocialButton(
                            context,
                            icon: Icons.facebook,
                            onPressed: () {
                              // TODO: Implement Facebook login
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(30),
          ),
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? AppTheme.primaryLight : Colors.white,
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
    BuildContext context, {
    required TextEditingController controller,
    required String hintText,
    required IconData prefixIcon,
    bool isPassword = false,
    bool isPasswordVisible = false,
    VoidCallback? onTogglePassword,
    required Function(String) onChanged,
    String? errorText,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword && !isPasswordVisible,
      onChanged: onChanged,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
        prefixIcon: Icon(prefixIcon, color: Colors.white.withOpacity(0.5)),
        suffixIcon: isPassword
            ? IconButton(
                icon: Icon(
                  isPasswordVisible ? Icons.visibility_off : Icons.visibility,
                  color: Colors.white.withOpacity(0.5),
                ),
                onPressed: onTogglePassword,
              )
            : null,
        errorText: errorText,
        errorStyle: const TextStyle(color: Colors.red),
        filled: true,
        fillColor: Colors.white.withOpacity(0.1),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.white, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildSocialButton(
    BuildContext context, {
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return Material(
      color: Colors.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(30),
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(30),
        child: Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
          ),
          child: Icon(
            icon,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );
  }
} 