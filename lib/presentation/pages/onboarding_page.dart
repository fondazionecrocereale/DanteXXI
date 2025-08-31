import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'auth/login_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingStep> _steps = [
    OnboardingStep(
      title: '¡Bienvenido a DanteXXI!',
      description:
          'Tu compañero inteligente para aprender italiano de manera efectiva y divertida.',
      icon: Icons.school,
      color: AppColors.primaryBlue,
    ),
    OnboardingStep(
      title: 'Aprende a tu ritmo',
      description:
          'Contenido personalizado según tu nivel y progreso de aprendizaje.',
      icon: Icons.trending_up,
      color: AppColors.secondaryGreen,
    ),
    OnboardingStep(
      title: 'Práctica interactiva',
      description:
          'Ejercicios, lecciones y contenido multimedia para una experiencia completa.',
      icon: Icons.play_circle,
      color: AppColors.secondaryOrange,
    ),
    OnboardingStep(
      title: '¡Comienza ahora!',
      description:
          'Únete a miles de estudiantes que ya están aprendiendo italiano con DanteXXI.',
      icon: Icons.rocket_launch,
      color: AppColors.secondaryPurple,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Indicador de progreso
            _buildProgressIndicator(),

            // Contenido de las páginas
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _steps.length,
                itemBuilder: (context, index) {
                  return _buildOnboardingStep(_steps[index]);
                },
              ),
            ),

            // Botones de navegación
            _buildNavigationButtons(),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: List.generate(_steps.length, (index) {
          return Expanded(
            child: Container(
              height: 4,
              margin: EdgeInsets.only(right: index < _steps.length - 1 ? 8 : 0),
              decoration: BoxDecoration(
                color: _currentPage == index
                    ? _steps[index].color
                    : AppColors.borderLight,
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildOnboardingStep(OnboardingStep step) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Icono
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: step.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(60),
            ),
            child: Icon(step.icon, color: step.color, size: 60),
          ),

          const SizedBox(height: 40),

          // Título
          Text(
            step.title,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          // Descripción
          Text(
            step.description,
            style: TextStyle(
              fontSize: 16,
              color: AppColors.textSecondary,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          // Botón de saltar (solo en las primeras páginas)
          if (_currentPage < _steps.length - 1)
            TextButton(
              onPressed: () => _completeOnboarding(),
              child: Text(
                'Saltar',
                style: TextStyle(color: AppColors.textSecondary, fontSize: 16),
              ),
            ),

          const Spacer(),

          // Botón de siguiente/comenzar
          ElevatedButton(
            onPressed: () {
              if (_currentPage < _steps.length - 1) {
                _pageController.nextPage(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                );
              } else {
                _completeOnboarding();
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: _steps[_currentPage].color,
              foregroundColor: AppColors.primaryWhite,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              _currentPage < _steps.length - 1 ? 'Siguiente' : '¡Comenzar!',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _completeOnboarding() {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => const LoginPage()),
    );
  }
}

class OnboardingStep {
  final String title;
  final String description;
  final IconData icon;
  final Color color;

  OnboardingStep({
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });
}
