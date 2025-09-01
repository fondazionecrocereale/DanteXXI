import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';
import '../blocs/auth/auth_state.dart';
import '../widgets/custom_button.dart';
import '../widgets/word_of_day_widget.dart';
import 'lessons_page.dart';
import 'exercises_page.dart';
import 'dictionary_page.dart';
import 'profile_page.dart';
import 'settings_page.dart';
import 'divine_comedy_screen.dart';
import 'reels_page.dart';
import 'audiobooks_page.dart';
import 'audiobook_details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 2;

  final List<Widget> _pages = [
    const DivineComedyScreen(),
    const ReelsPage(),
    const HomeContent(),
    const DictionaryPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backgroundCard,
        selectedItemColor: AppColors.primaryBlue,
        unselectedItemColor: AppColors.textSecondary,
        selectedLabelStyle: const TextStyle(fontWeight: FontWeight.w600),
        unselectedLabelStyle: const TextStyle(fontWeight: FontWeight.w500),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            activeIcon: Icon(Icons.map),
            label: AppTexts.learningMap,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_stable),
            activeIcon: Icon(Icons.video_stable),
            label: AppTexts.reels,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            activeIcon: Icon(Icons.home),
            label: AppTexts.home,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book_outlined),
            activeIcon: Icon(Icons.book),
            label: AppTexts.dictionary,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: AppTexts.profile,
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppTexts.appName),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const SettingsPage()),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _showLogoutDialog(context),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Saludo del usuario
              _buildUserGreeting(),

              const SizedBox(height: 32),

              // Estadísticas rápidas
              _buildQuickStats(),

              const SizedBox(height: 32),

              // Palabra del día
              const WordOfDayWidget(),

              const SizedBox(height: 32),

              // Lecciones recomendadas
              _buildRecommendedLessons(context),

              //const SizedBox(height: 32),

              // Acciones rápidas
              //_buildQuickActions(context),
              const SizedBox(height: 32),

              // Widget Premium
              _buildPremiumWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserGreeting() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '¡Buongiorno! 👋',
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
            // fontFamily: 'Lora',
          ),
        ),
        const SizedBox(height: 8),
        Text(
          '¿Listo para aprender italiano hoy?',
          style: TextStyle(
            fontSize: 16,
            color: AppColors.textSecondary,
            // fontFamily: 'Tinos',
          ),
        ),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Row(
      children: [
        Expanded(
          child: _buildStatCard(
            icon: Icons.school,
            title: 'Lecciones',
            value: '12',
            subtitle: 'Completadas',
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.quiz,
            title: 'Ejercicios',
            value: '45',
            subtitle: 'Resueltos',
            color: AppColors.secondaryGreen,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: _buildStatCard(
            icon: Icons.trending_up,
            title: 'Nivel',
            value: 'A2',
            subtitle: 'Actual',
            color: AppColors.secondaryOrange,
          ),
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required String value,
    required String subtitle,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: color, size: 20),
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: color,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
          Text(
            subtitle,
            style: const TextStyle(fontSize: 10, color: AppColors.textLight),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Acciones Rápidas',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: CustomButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const LessonsPage()),
                ),
                text: 'Continuar Lección',
                icon: Icons.play_arrow,
                height: 56,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomButton(
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const ExercisesPage(),
                  ),
                ),
                text: 'Practicar',
                icon: Icons.quiz,
                height: 56,
                backgroundColor: AppColors.secondaryGreen,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRecommendedLessons(BuildContext context) {
    return FutureBuilder<String>(
      future: rootBundle.loadString('assets/data/italian_audiobooks.json'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || !snapshot.hasData) {
          return const Center(child: Text('Error cargando audiolibros'));
        }

        try {
          final Map<String, dynamic> jsonData = json.decode(snapshot.data!);
          final List<dynamic> audiobooks = jsonData['italian_audiobooks'];

          // Tomar solo los primeros 3 audiobooks para la homepage
          final List<dynamic> featuredAudiobooks = audiobooks.take(3).toList();

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Audiolibros',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  CustomTextButton(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => const AudiobooksPage(),
                      ),
                    ),
                    text: 'Ver todos',
                    textColor: AppColors.primaryBlue,
                  ),
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 200,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: featuredAudiobooks.length,
                  itemBuilder: (context, index) {
                    final audiobook = featuredAudiobooks[index];
                    final colors = [
                      AppColors.primaryBlue,
                      AppColors.secondaryGreen,
                      AppColors.secondaryOrange,
                    ];

                    return Padding(
                      padding: EdgeInsets.only(
                        right: index < featuredAudiobooks.length - 1 ? 16 : 0,
                      ),
                      child: _buildAudiobookCard(
                        title: audiobook['name'] ?? '',
                        author: audiobook['author'] ?? '',
                        description: audiobook['description'] ?? '',
                        level: audiobook['level'] ?? '',
                        duration: audiobook['duration'] ?? '',
                        color: colors[index % colors.length],
                        image: audiobook['image'] ?? '',
                        audiobookData: audiobook,
                        context: context,
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        } catch (e) {
          return const Center(child: Text('Error procesando datos'));
        }
      },
    );
  }

  Widget _buildAudiobookCard({
    required String title,
    required String author,
    required String description,
    required String level,
    required String duration,
    required Color color,
    required String image,
    required Map<String, dynamic> audiobookData,
    required BuildContext context,
  }) {
    return Container(
      width: 200,
      decoration: BoxDecoration(
        color: AppColors.backgroundCard,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowLight,
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () => Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) =>
                  AudiobookDetailsPage(audiobook: audiobookData),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        level,
                        style: TextStyle(
                          color: color,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.headphones, color: color, size: 24),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  author,
                  style: TextStyle(
                    fontSize: 12,
                    color: color,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 11,
                    color: AppColors.textSecondary,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.access_time,
                      size: 16,
                      color: AppColors.textSecondary,
                    ),
                    Text(
                      duration,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPremiumWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hacete Premium',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFD700), // Dorado premium
                Color(0xFFFFA500), // Naranja dorado
                Color(0xFFFF8C00), // Naranja oscuro
              ],
            ),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFFD700).withValues(alpha: 0.3),
                blurRadius: 15,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.star,
                          color: AppColors.primaryWhite,
                          size: 24,
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          'Premium',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: AppColors.primaryWhite,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Desbloquea contenido exclusivo y acelera tu aprendizaje',
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.primaryWhite,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primaryWhite,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Lecciones ilimitadas',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Icon(
                          Icons.check_circle,
                          color: AppColors.primaryWhite,
                          size: 16,
                        ),
                        const SizedBox(width: 6),
                        const Text(
                          'Sin anuncios',
                          style: TextStyle(
                            fontSize: 12,
                            color: AppColors.primaryWhite,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    CustomButton(
                      onPressed: () => _showPremiumDialog(context),
                      text: '¡Hacete Premium!',
                      backgroundColor: AppColors.primaryWhite,
                      textColor: const Color(0xFFFF8C00),
                      height: 40,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 20),
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                  color: AppColors.primaryWhite.withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(40),
                ),
                child: const Icon(
                  Icons.workspace_premium,
                  size: 40,
                  color: AppColors.primaryWhite,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  void _showPremiumDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Row(
          children: [
            const Icon(
              Icons.workspace_premium,
              color: Color(0xFFFFD700),
              size: 28,
            ),
            const SizedBox(width: 12),
            const Text(
              '¡Hacete Premium!',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFFFF8C00),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Desbloquea todo el potencial de tu aprendizaje:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            _buildPremiumFeature('🎯 Lecciones ilimitadas'),
            _buildPremiumFeature('🚫 Sin anuncios'),
            _buildPremiumFeature('📊 Estadísticas avanzadas'),
            _buildPremiumFeature('🎧 Audiolibros completos'),
            _buildPremiumFeature('🏆 Logros exclusivos'),
            _buildPremiumFeature('💬 Soporte prioritario'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: const Color(0xFFFFD700).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: const Color(0xFFFFD700)),
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.local_offer, color: Color(0xFFFF8C00), size: 20),
                  SizedBox(width: 8),
                  Text(
                    '¡50% de descuento por tiempo limitado!',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFF8C00),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Más tarde'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              _processPremiumPurchase(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF8C00),
              foregroundColor: AppColors.primaryWhite,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text(
              '¡Suscribirse Ahora!',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPremiumFeature(String feature) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Color(0xFFFF8C00), size: 20),
          const SizedBox(width: 12),
          Text(feature, style: const TextStyle(fontSize: 14)),
        ],
      ),
    );
  }

  void _processPremiumPurchase(BuildContext context) {
    // TODO: Implementar lógica de compra premium
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('¡Funcionalidad de suscripción premium próximamente!'),
        backgroundColor: Color(0xFFFF8C00),
        duration: Duration(seconds: 3),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cerrar Sesión'),
        content: const Text('¿Estás seguro de que quieres cerrar sesión?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }
}
