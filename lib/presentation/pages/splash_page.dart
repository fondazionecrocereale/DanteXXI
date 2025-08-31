import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/services/storage_service.dart';
import 'auth/login_page.dart';
import 'onboarding_page.dart';
import 'home_page.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _handleAuthState();
  }

  Future<void> _handleAuthState() async {
    // Verificar si el onboarding ya se completó
    final onboardingCompleted = await StorageService.isOnboardingCompleted();

    // Verificar si el usuario está autenticado
    final isAuthenticated = await StorageService.isLoggedIn();

    // Simular un delay para mostrar la pantalla de splash
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      if (!onboardingCompleted) {
        // Primera vez, mostrar onboarding
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingPage()),
        );
      } else if (isAuthenticated) {
        // Usuario autenticado, ir a home
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
      } else {
        // Usuario no autenticado, ir a login
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(gradient: AppColors.italianGradient),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo principal
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(60),
                ),
                child: const Icon(
                  Icons.school,
                  color: AppColors.primaryWhite,
                  size: 60,
                ),
              ),

              const SizedBox(height: 32),

              // Título de la app
              Text(
                'DanteXXI',
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryWhite,
                  letterSpacing: 2,
                ),
              ),

              const SizedBox(height: 8),

              // Subtítulo
              Text(
                'Aprende Italiano de Forma Inteligente',
                style: TextStyle(
                  fontSize: 18,
                  color: AppColors.primaryWhite.withValues(alpha: 0.9),
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 64),

              // Indicador de carga
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.primaryWhite,
                ),
                strokeWidth: 3,
              ),

              const SizedBox(height: 24),

              // Texto de carga
              Text(
                'Conectando con tu API...',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.primaryWhite.withValues(alpha: 0.8),
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
