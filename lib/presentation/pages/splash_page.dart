import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';

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
      // Usar AuthBloc en lugar de ProfileService
      print(
        '🔍 SplashPage._handleAuthState() - Verificando estado de AuthBloc...',
      );

      // Disparar evento para verificar usuario actual
      context.read<AuthBloc>().add(AuthCheckRequested());

      // El BlocListener se encargará de la navegación
    }
  }

  Future<void> _checkOnboardingAndNavigate() async {
    print(
      '🔍 SplashPage._checkOnboardingAndNavigate() - Verificando onboarding...',
    );
    final onboardingCompleted = await StorageService.isOnboardingCompleted();
    print(
      '🔍 SplashPage._checkOnboardingAndNavigate() - onboardingCompleted: $onboardingCompleted',
    );

    if (!onboardingCompleted) {
      // Primera vez, mostrar onboarding
      print(
        '📚 SplashPage._checkOnboardingAndNavigate() - Primera vez, yendo a OnboardingPage',
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const OnboardingPage()),
      );
    } else {
      // Usuario no autenticado, ir a login
      print(
        '🔐 SplashPage._checkOnboardingAndNavigate() - Usuario no autenticado, yendo a LoginPage',
      );
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const LoginPage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        print(
          '🔍 SplashPage.BlocListener - Estado recibido: ${state.runtimeType}',
        );

        if (state is AuthAuthenticated) {
          print(
            '✅ SplashPage.BlocListener - Usuario autenticado, yendo a HomePage',
          );
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const HomePage()),
          );
        } else if (state is AuthUnauthenticated) {
          print(
            '🔐 SplashPage.BlocListener - Usuario no autenticado, verificando onboarding...',
          );
          _checkOnboardingAndNavigate();
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
