import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import '../blocs/auth/auth_event.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import '../../core/services/storage_service.dart';
import '../../core/services/profile_service.dart';
import 'onboarding_page.dart';
import 'home_page.dart';
import 'auth/login_page.dart';

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
    print(
      '🚀 SplashPage._handleAuthState() - Iniciando verificación de estado...',
    );

    // Simular un delay para mostrar la pantalla de splash
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      // PRIMERO: Verificar si hay una sesión activa (prioridad máxima)
      print('🔍 SplashPage._handleAuthState() - Verificando sesión activa...');
      final hasActiveSession = await ProfileService.hasActiveSession();
      final profile = await ProfileService.getProfile();

      print(
        '🔍 SplashPage._handleAuthState() - hasActiveSession: $hasActiveSession',
      );
      print(
        '🔍 SplashPage._handleAuthState() - profile: ${profile != null ? 'existe' : 'null'}',
      );

      if (hasActiveSession && profile != null) {
        // ✅ USUARIO AUTENTICADO - Ir directamente a HomePage
        print(
          '✅ SplashPage._handleAuthState() - Usuario autenticado, yendo a HomePage',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const HomePage()),
        );
        return; // Salir aquí, no verificar onboarding
      }

      // SEGUNDO: Si no hay sesión activa, verificar onboarding
      print(
        '🔍 SplashPage._handleAuthState() - No hay sesión activa, verificando onboarding...',
      );
      final onboardingCompleted = await StorageService.isOnboardingCompleted();
      print(
        '🔍 SplashPage._handleAuthState() - onboardingCompleted: $onboardingCompleted',
      );

      if (!onboardingCompleted) {
        // Primera vez, mostrar onboarding
        print(
          '📚 SplashPage._handleAuthState() - Primera vez, yendo a OnboardingPage',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const OnboardingPage()),
        );
      } else {
        // Usuario no autenticado, ir a login
        print(
          '🔐 SplashPage._handleAuthState() - Usuario no autenticado, yendo a LoginPage',
        );
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state is AuthUnauthenticated) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryBlue,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo o nombre de la app
              Text(
                AppTexts.appName,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 20),
              // Indicador de carga
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
