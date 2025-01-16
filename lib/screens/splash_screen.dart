import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/route_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool _dontShowAgain = false; // Checkbox state

  @override
  void initState() {
    super.initState();
    _checkPreference(); // Check saved preference on startup
  }

  Future<void> _checkPreference() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool dontShowAgain = prefs.getBool('dontShowSplash') ?? false;
    if (dontShowAgain) {
      _navigateToHome(); // Automatically navigate if preference is set
    }
  }

  Future<void> _savePreferenceAndNavigate() async {
    if (_dontShowAgain) {
      // Save user preference to not show the splash screen again
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('dontShowSplash', true);
    }
    _navigateToHome();
  }

  void _navigateToHome() {
    // Enable full-screen UI mode
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
    // Navigate to the HomeScreen
    Get.off(() => const HomeScreen());
  }

  @override
  Widget build(BuildContext context) {
    final mq = MediaQuery.of(context).size; // MediaQuery for responsive design

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Main content: Icon and text
          Positioned(
            left: mq.width * 0.1,
            top: mq.height * 0.1,
            width: mq.width * 0.8,
            child: Column(
              children: [
                Icon(
                  Icons.health_and_safety,
                  size: mq.width * 0.4,
                  color: Colors.green,
                ),
                SizedBox(height: mq.height * 0.02),
                Text(
                  '''
نکته مهم: 
کاربر عزیز، برای استفاده رایگان از این برنامه لطفاً چند ثانیه صبر کنید تا تبلیغات نمایش داده شده به پایان برسد. در اینصورت شما به راحتی و بدون هیچ هزینه‌ای می‌توانید از خدمات این برنامه بهره‌مند شوید در غیر اینصورت اتصال تکمیل نخواهد شد. از همراهی شما سپاسگزاریم! ❤️


این نرم افزار برای حفظ کامل حریم شخصی هیچ اطلاعاتی از کاربران را ذخیره و به اشتراک نمیگذارد.
''',
                  textAlign: TextAlign.justify,
                  textDirection: TextDirection.rtl,
                  style: TextStyle(
                    fontSize: 18,
                    color: Theme.of(context).textTheme.bodyLarge?.color,
                  ),
                ),
              ],
            ),
          ),

          // Bottom section: Checkbox and button
          Positioned(
            bottom: mq.height * 0.05,
            width: mq.width,
            child: Column(
              children: [
                // Checkbox to skip splash screen
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Checkbox(
                      value: _dontShowAgain,
                      onChanged: (bool? value) {
                        setState(() {
                          _dontShowAgain = value ?? false;
                        });
                      },
                    ),
                    Text(
                      'Don’t show this page again',
                      style: TextStyle(
                        fontSize: 16,
                        color: Theme.of(context).textTheme.bodyLarge?.color,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: mq.height * 0.02),
                // Button to navigate
                ElevatedButton(
                  onPressed: _savePreferenceAndNavigate,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: mq.width * 0.3,
                      vertical: mq.height * 0.02,
                    ),
                  ),
                  child: const Text(
                    'Enter App',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
