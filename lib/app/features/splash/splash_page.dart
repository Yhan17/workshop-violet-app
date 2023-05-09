import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../shared/utils/app_animations.dart';

class SplashPage extends HookWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        final prefs = await SharedPreferences.getInstance();

        Future.delayed(const Duration(seconds: 5), () {
          if (prefs.containsKey('user')) {
            GoRouter.of(context).pushReplacement("/home");
          } else {
            GoRouter.of(context).pushReplacement("/login");
          }
        });
      });
      return null;
    }, const []);

    return Scaffold(
      body: Center(
        child: LottieBuilder.asset(
          AppAnimations.splashAnimation,
        ),
      ),
    );
  }
}
