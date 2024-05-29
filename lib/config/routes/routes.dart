import 'package:flutter/material.dart';
import 'package:them/core/resource/pages/home.dart';
import 'package:them/features/auth/presentation/pages/menu.dart';
import 'package:them/features/onboarding/presentation/pages/introduction_animation.dart';

class AppRouter {
  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch(settings.name) {
      case '/':
        return _materialRoute(const IntroductionAnimationScreen());
      case '/auth' :
        return _materialRoute(const WelcomeScreen());
      case '/dashboard' :
        return _materialRoute(const HomePage());
      default :
        return _materialRoute(const WelcomeScreen());
    }

  }

  static Route<dynamic> _materialRoute(Widget view) {
    return PageRouteBuilder(
      pageBuilder: (_, __, ___) => view,
      transitionDuration: const Duration(milliseconds: 200),
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final slideTween = Tween<Offset>(
          begin: const Offset(1.0, 0.0), // Start from off-screen right
          end: const Offset(0.0, 0.0), // Slide to the center
        );
        return SlideTransition(
          position: animation.drive(slideTween),
          child: child,
        );
      },
    );
  }
}