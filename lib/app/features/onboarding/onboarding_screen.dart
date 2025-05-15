import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../app/theme/app_theme.dart';

class OnboardingScreen extends StatelessWidget {
  OnboardingScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  final RxInt _currentPage = 0.obs;

  final List<OnboardingPage> _pages = [
    OnboardingPage(
      title: 'Track Your Expenses',
      description: 'Keep track of your daily expenses and income with our easy-to-use interface',
      image: 'assets/images/onboarding1.png',
      icon: Icons.account_balance_wallet_outlined,
    ),
    OnboardingPage(
      title: 'Smart Analytics',
      description: 'Get detailed insights about your spending habits with beautiful charts',
      image: 'assets/images/onboarding2.png',
      icon: Icons.analytics_outlined,
    ),
    OnboardingPage(
      title: 'Secure & Private',
      description: 'Your financial data is encrypted and secure with us',
      image: 'assets/images/onboarding3.png',
      icon: Icons.security_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          PageView.builder(
            controller: _pageController,
            itemCount: _pages.length,
            onPageChanged: (index) => _currentPage.value = index,
            itemBuilder: (context, index) {
              return _buildPage(_pages[index]);
            },
          ),
          Positioned(
            bottom: 50,
            left: 0,
            right: 0,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    _pages.length,
                    (index) => Obx(
                      () => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        height: 8,
                        width: _currentPage.value == index ? 24 : 8,
                        decoration: BoxDecoration(
                          color: _currentPage.value == index
                              ? AppTheme.primaryLight
                              : Colors.grey[300],
                          borderRadius: BorderRadius.circular(4),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () => Get.offAllNamed('/auth'),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: AppTheme.secondaryLight,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_currentPage.value == _pages.length - 1) {
                            Get.offAllNamed('/auth');
                          } else {
                            _pageController.nextPage(
                              duration: const Duration(milliseconds: 300),
                              curve: Curves.easeInOut,
                            );
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryLight,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 32,
                            vertical: 16,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: Obx(
                          () => Text(
                            _currentPage.value == _pages.length - 1
                                ? 'Get Started'
                                : 'Next',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPage(OnboardingPage page) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Hero(
            tag: page.image,
            child: Container(
              height: Get.height * 0.4,
              width: Get.height * 0.4,
              decoration: BoxDecoration(
                color: AppTheme.primaryLight.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                page.icon,
                size: Get.height * 0.2,
                color: AppTheme.primaryLight,
              ),
            ),
          ),
          const SizedBox(height: 48),
          Text(
            page.title,
            style: Theme.of(Get.context!).textTheme.displayMedium?.copyWith(
                  color: AppTheme.primaryLight,
                  fontWeight: FontWeight.bold,
                ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Text(
            page.description,
            style: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
                  color: AppTheme.secondaryLight,
                ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

class OnboardingPage {
  final String title;
  final String description;
  final String image;
  final IconData icon;

  OnboardingPage({
    required this.title,
    required this.description,
    required this.image,
    required this.icon,
  });
} 