import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_event.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoPlayEnabled = false;
  bool _downloadOverWifiOnly = true;

  String _selectedLanguage = 'Español';
  String _selectedDifficulty = 'A1';
  int _dailyGoal = 30;
  bool _streakReminders = true;
  bool _weeklyReports = true;
  bool _achievementNotifications = true;

  final List<String> _availableLanguages = [
    'Español',
    'English',
    'Français',
    'Deutsch',
    'Português',
  ];

  final List<String> _availableDifficulties = ['A1', 'A2', 'B1', 'B2', 'C1'];

  final List<int> _availableDailyGoals = [15, 30, 45, 60, 90];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configuraciones'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Configuraciones de la aplicación
            _buildSettingsSection(
              title: 'Aplicación',
              icon: Icons.settings,
              color: AppColors.primaryBlue,
              children: [
                _buildSwitchSetting(
                  title: 'Notificaciones',
                  subtitle: 'Recibe recordatorios de estudio',
                  icon: Icons.notifications,
                  value: _notificationsEnabled,
                  onChanged: (value) {
                    setState(() {
                      _notificationsEnabled = value;
                    });
                  },
                ),

                _buildSwitchSetting(
                  title: 'Sonidos',
                  subtitle: 'Efectos de sonido en la app',
                  icon: Icons.volume_up,
                  value: _soundEnabled,
                  onChanged: (value) {
                    setState(() {
                      _soundEnabled = value;
                    });
                  },
                ),

                _buildSwitchSetting(
                  title: 'Vibración',
                  subtitle: 'Vibración en notificaciones',
                  icon: Icons.vibration,
                  value: _vibrationEnabled,
                  onChanged: (value) {
                    setState(() {
                      _vibrationEnabled = value;
                    });
                  },
                ),

                _buildSwitchSetting(
                  title: 'Modo Oscuro',
                  subtitle: 'Cambiar tema de la aplicación',
                  icon: Icons.dark_mode,
                  value: _darkModeEnabled,
                  onChanged: (value) {
                    setState(() {
                      _darkModeEnabled = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Configuraciones de aprendizaje
            _buildSettingsSection(
              title: 'Aprendizaje',
              icon: Icons.school,
              color: AppColors.secondaryGreen,
              children: [
                _buildDropdownSetting(
                  title: 'Idioma de la App',
                  subtitle: 'Idioma de la interfaz',
                  icon: Icons.language,
                  value: _selectedLanguage,
                  items: _availableLanguages,
                  onChanged: (value) {
                    setState(() {
                      _selectedLanguage = value!;
                    });
                  },
                ),

                _buildDropdownSetting(
                  title: 'Dificultad por Defecto',
                  subtitle: 'Nivel inicial de lecciones',
                  icon: Icons.trending_up,
                  value: _selectedDifficulty,
                  items: _availableDifficulties,
                  onChanged: (value) {
                    setState(() {
                      _selectedDifficulty = value!;
                    });
                  },
                ),

                _buildDropdownSetting(
                  title: 'Meta Diaria',
                  subtitle: 'Minutos de estudio por día',
                  icon: Icons.timer,
                  value: '$_dailyGoal min',
                  items: _availableDailyGoals.map((e) => '$e min').toList(),
                  onChanged: (value) {
                    setState(() {
                      _dailyGoal = int.parse(value!.replaceAll(' min', ''));
                    });
                  },
                ),

                _buildSwitchSetting(
                  title: 'Reproducción Automática',
                  subtitle: 'Reproducir audio automáticamente',
                  icon: Icons.play_circle,
                  value: _autoPlayEnabled,
                  onChanged: (value) {
                    setState(() {
                      _autoPlayEnabled = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Configuraciones de notificaciones
            _buildSettingsSection(
              title: 'Notificaciones',
              icon: Icons.notifications_active,
              color: AppColors.secondaryOrange,
              children: [
                _buildSwitchSetting(
                  title: 'Recordatorios de Racha',
                  subtitle: 'Mantén tu racha de estudio',
                  icon: Icons.local_fire_department,
                  value: _streakReminders,
                  onChanged: (value) {
                    setState(() {
                      _streakReminders = value;
                    });
                  },
                ),

                _buildSwitchSetting(
                  title: 'Reportes Semanales',
                  subtitle: 'Resumen de tu progreso',
                  icon: Icons.assessment,
                  value: _weeklyReports,
                  onChanged: (value) {
                    setState(() {
                      _weeklyReports = value;
                    });
                  },
                ),

                _buildSwitchSetting(
                  title: 'Logros',
                  subtitle: 'Notificaciones de logros',
                  icon: Icons.emoji_events,
                  value: _achievementNotifications,
                  onChanged: (value) {
                    setState(() {
                      _achievementNotifications = value;
                    });
                  },
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Configuraciones de datos
            _buildSettingsSection(
              title: 'Datos y Almacenamiento',
              icon: Icons.storage,
              color: AppColors.secondaryBlue,
              children: [
                _buildSwitchSetting(
                  title: 'Descargar solo con WiFi',
                  subtitle: 'Ahorra datos móviles',
                  icon: Icons.wifi,
                  value: _downloadOverWifiOnly,
                  onChanged: (value) {
                    setState(() {
                      _downloadOverWifiOnly = value;
                    });
                  },
                ),

                _buildActionSetting(
                  title: 'Limpiar Cache',
                  subtitle: 'Liberar espacio de almacenamiento',
                  icon: Icons.cleaning_services,
                  onTap: () => _clearCache(),
                ),

                _buildActionSetting(
                  title: 'Exportar Datos',
                  subtitle: 'Descargar tu progreso',
                  icon: Icons.download,
                  onTap: () => _exportData(),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Configuraciones de cuenta
            _buildSettingsSection(
              title: 'Cuenta',
              icon: Icons.account_circle,
              color: AppColors.secondaryPurple,
              children: [
                _buildActionSetting(
                  title: 'Editar Perfil',
                  subtitle: 'Cambiar información personal',
                  icon: Icons.edit,
                  onTap: () => _editProfile(),
                ),

                _buildActionSetting(
                  title: 'Cambiar Contraseña',
                  subtitle: 'Actualizar contraseña de acceso',
                  icon: Icons.lock,
                  onTap: () => _changePassword(),
                ),

                _buildActionSetting(
                  title: 'Privacidad',
                  subtitle: 'Configurar privacidad de datos',
                  icon: Icons.privacy_tip,
                  onTap: () => _openPrivacySettings(),
                ),

                _buildActionSetting(
                  title: 'Cerrar Sesión',
                  subtitle: 'Salir de tu cuenta',
                  icon: Icons.logout,
                  onTap: () => _logout(),
                  isDestructive: true,
                ),
              ],
            ),

            const SizedBox(height: 24),

            // Información de la aplicación
            _buildSettingsSection(
              title: 'Acerca de',
              icon: Icons.info,
              color: AppColors.textSecondary,
              children: [
                _buildInfoSetting(
                  title: 'Versión',
                  subtitle: '1.0.0',
                  icon: Icons.app_settings_alt,
                ),

                _buildActionSetting(
                  title: 'Términos y Condiciones',
                  subtitle: 'Leer términos de uso',
                  icon: Icons.description,
                  onTap: () => _openTerms(),
                ),

                _buildActionSetting(
                  title: 'Política de Privacidad',
                  subtitle: 'Leer política de privacidad',
                  icon: Icons.security,
                  onTap: () => _openPrivacyPolicy(),
                ),

                _buildActionSetting(
                  title: 'Contacto',
                  subtitle: 'Enviar comentarios',
                  icon: Icons.contact_support,
                  onTap: () => _contactSupport(),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Botón de guardar
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveSettings,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryBlue,
                  foregroundColor: AppColors.primaryWhite,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Guardar Configuraciones',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingsSection({
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Container(
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header de la sección
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(16),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: color.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, color: color, size: 20),
                ),

                const SizedBox(width: 16),

                Text(
                  title,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ],
            ),
          ),

          // Contenido de la sección
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }

  Widget _buildSwitchSetting({
    required String title,
    required String subtitle,
    required IconData icon,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.primaryBlue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.primaryBlue, size: 20),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: AppColors.primaryBlue,
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownSetting({
    required String title,
    required String subtitle,
    required IconData icon,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.secondaryGreen.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.secondaryGreen, size: 20),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),

          DropdownButton<String>(
            value: value,
            onChanged: onChanged,
            underline: Container(),
            items: items.map((String item) {
              return DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                ),
              );
            }).toList(),
            icon: Icon(Icons.arrow_drop_down, color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }

  Widget _buildActionSetting({
    required String title,
    required String subtitle,
    required IconData icon,
    required VoidCallback onTap,
    bool isDestructive = false,
  }) {
    final color = isDestructive ? AppColors.error : AppColors.secondaryPurple;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
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

              const SizedBox(width: 16),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: isDestructive
                            ? AppColors.error
                            : AppColors.textPrimary,
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),

              Icon(
                Icons.arrow_forward_ios,
                color: AppColors.textLight,
                size: 16,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoSetting({
    required String title,
    required String subtitle,
    required IconData icon,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.textSecondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(icon, color: AppColors.textSecondary, size: 20),
          ),

          const SizedBox(width: 16),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    // TODO: Implementar guardado de configuraciones
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Configuraciones guardadas exitosamente'),
        backgroundColor: AppColors.success,
      ),
    );

    // Simular guardado
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pop();
    });
  }

  void _clearCache() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Limpiar Cache'),
        content: const Text(
          '¿Estás seguro de que quieres limpiar el cache? Esto liberará espacio pero puede afectar el rendimiento temporalmente.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Cache limpiado exitosamente'),
                  backgroundColor: AppColors.success,
                ),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Limpiar'),
          ),
        ],
      ),
    );
  }

  void _exportData() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Exportando datos...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _editProfile() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando a editar perfil...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _changePassword() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Navegando a cambiar contraseña...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _openPrivacySettings() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abriendo configuraciones de privacidad...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _logout() {
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
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.of(context).pop();
              context.read<AuthBloc>().add(AuthLogoutRequested());
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
            child: const Text('Cerrar Sesión'),
          ),
        ],
      ),
    );
  }

  void _openTerms() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abriendo términos y condiciones...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _openPrivacyPolicy() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abriendo política de privacidad...'),
        backgroundColor: AppColors.info,
      ),
    );
  }

  void _contactSupport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Abriendo contacto de soporte...'),
        backgroundColor: AppColors.info,
      ),
    );
  }
}
