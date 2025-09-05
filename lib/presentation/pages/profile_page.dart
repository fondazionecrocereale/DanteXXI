import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/constants/app_colors.dart';
import '../../core/services/profile_service.dart';
import '../../core/services/error_handler_service.dart';
import '../../core/services/session_manager.dart';
import '../../core/services/notification_service.dart';
import '../../domain/entities/editable_profile.dart';
import '../../domain/entities/user.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/wallet/user_web3_info.dart';
import '../blocs/auth/auth_bloc.dart';
import '../blocs/auth/auth_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final _formKey = GlobalKey<FormState>();
  final _imagePicker = ImagePicker();

  EditableProfile? _profile;
  bool _isEditing = false;
  bool _isLoading = false;

  // Controllers para los campos editables
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _bioController;
  late TextEditingController _phoneController;
  late TextEditingController _learningGoalController;
  late TextEditingController _dailyGoalController;

  String? _selectedLevel;
  String? _selectedCountry;
  String? _selectedLanguage;
  List<String> _selectedInterests = [];
  bool _emailNotifications = true;
  bool _pushNotifications = true;

  // Configuraciones de la aplicación
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  bool _vibrationEnabled = true;
  bool _darkModeEnabled = false;
  bool _autoPlayEnabled = false;
  bool _downloadOverWifiOnly = true;

  String _selectedAppLanguage = 'Español';
  String _selectedDifficulty = 'A1';
  int _dailyGoal = 30;
  bool _streakReminders = true;
  bool _weeklyReports = true;
  bool _achievementNotifications = true;

  // Configuración de notificaciones locales
  bool _dailyFactNotifications = false;
  bool _randomFactNotifications = false;
  TimeOfDay _notificationTime = const TimeOfDay(hour: 9, minute: 0);
  bool _notificationsInitialized = false;

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
  void initState() {
    super.initState();
    _initializeControllers();
    _loadProfile();
    _initializeNotifications();
  }

  void _initializeControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _bioController = TextEditingController();
    _phoneController = TextEditingController();
    _learningGoalController = TextEditingController();
    _dailyGoalController = TextEditingController();
  }

  Future<void> _initializeNotifications() async {
    try {
      await NotificationService.initialize();
      setState(() {
        _notificationsInitialized = true;
      });
    } catch (e) {
      print('Error inicializando notificaciones: $e');
    }
  }

  Future<void> _selectNotificationTime() async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _notificationTime,
    );
    if (picked != null && picked != _notificationTime) {
      setState(() {
        _notificationTime = picked;
      });
      _updateNotificationSchedule();
    }
  }

  Future<void> _updateNotificationSchedule() async {
    if (!_notificationsInitialized) return;

    try {
      // Cancelar notificaciones existentes
      await NotificationService.cancelAllNotifications();

      // Programar nuevas notificaciones según la configuración
      if (_dailyFactNotifications) {
        await _scheduleDailyNotification();
      }

      if (_randomFactNotifications) {
        await _scheduleRandomNotification();
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Configuración de notificaciones actualizada'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error actualizando notificaciones: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _scheduleDailyNotification() async {
    await NotificationService.initialize();

    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      _notificationTime.hour,
      _notificationTime.minute,
    );

    final nextScheduledDate = scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    // Usar el método existente del NotificationService
    await NotificationService.scheduleDailyFactNotification();
  }

  Future<void> _scheduleRandomNotification() async {
    await NotificationService.initialize();

    // Programar para una hora después de la hora seleccionada
    final now = DateTime.now();
    final scheduledDate = DateTime(
      now.year,
      now.month,
      now.day,
      _notificationTime.hour + 1,
      _notificationTime.minute,
    );

    final nextScheduledDate = scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;

    // Usar el método existente del NotificationService
    await NotificationService.scheduleRandomFactNotification();
  }

  Future<void> _testNotification() async {
    try {
      await NotificationService.showImmediateFactNotification();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Notificación de prueba enviada'),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error enviando notificación: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<void> _loadProfile() async {
    print('🔄 ProfilePage._loadProfile() - Iniciando...');
    setState(() => _isLoading = true);
    try {
      // Usar AuthBloc en lugar de ProfileService
      final authState = context.read<AuthBloc>().state;
      print(
        '🔍 ProfilePage._loadProfile() - AuthState: ${authState.runtimeType}',
      );

      if (authState is AuthAuthenticated) {
        print(
          '✅ ProfilePage._loadProfile() - Usuario autenticado: ${authState.user['email']}',
        );

        // Convertir User del AuthBloc a EditableProfile
        _profile = EditableProfile(
          id: authState.user['id'],
          email: authState.user['email'],
          firstName: authState.user['firstName'],
          lastName: authState.user['lastName'],
          avatar: authState.user['avatar'],
          level: authState.user['level'] ?? 'A1',
          country: authState.user['country'] ?? 'Italia',
          language: authState.user['language'] ?? 'italiano',
          interests: List<String>.from(authState.user['intereses'] ?? []),
          bio: 'Usuario de DanteXXI',
          phoneNumber: null,
          learningGoal: 'Aprender italiano',
          dailyGoalMinutes: 30,
          emailNotifications: true,
          pushNotifications: true,
        );

        print('✅ ProfilePage._loadProfile() - Perfil creado desde AuthBloc');
        _populateControllers();
        print('✅ ProfilePage._loadProfile() - Controllers poblados');

        // Mostrar mensaje de bienvenida (solo si el widget está montado y el contexto es válido)
        if (mounted && context.mounted) {
          // Usar un delay para asegurar que el ScaffoldMessenger esté disponible
          Future.delayed(const Duration(milliseconds: 100), () {
            if (mounted && context.mounted) {
              ErrorHandlerService.showInfoSnackBar(
                context,
                'Bienvenido, ${authState.user['firstName']}!',
              );
            }
          });
        }

        print('✅ ProfilePage._loadProfile() - Perfil cargado exitosamente');
      } else {
        print('❌ ProfilePage._loadProfile() - Usuario no autenticado');
        _profile = null;
      }
    } catch (e) {
      print('❌ ProfilePage._loadProfile() - Error: $e');
      ErrorHandlerService.showErrorSnackBar(context, 'Error al cargar perfil');
    } finally {
      setState(() => _isLoading = false);
      print('🔄 ProfilePage._loadProfile() - Finalizado, _isLoading = false');
    }
  }

  void _populateControllers() {
    if (_profile != null) {
      _firstNameController.text = _profile!.firstName;
      _lastNameController.text = _profile!.lastName;
      _bioController.text = _profile!.bio ?? '';
      _phoneController.text = _profile!.phoneNumber ?? '';
      _learningGoalController.text = _profile!.learningGoal ?? '';
      _dailyGoalController.text = (_profile!.dailyGoalMinutes ?? 30).toString();

      _selectedLevel = _profile!.level;
      _selectedCountry = _profile!.country;
      _selectedLanguage = _profile!.language;
      _selectedInterests = _profile!.interests ?? [];
      _emailNotifications = _profile!.emailNotifications ?? true;
      _pushNotifications = _profile!.pushNotifications ?? true;
    }
  }

  Future<void> _pickImage() async {
    try {
      print('📸 ProfilePage._pickImage() - Iniciando selección de imagen...');

      final XFile? image = await _imagePicker.pickImage(
        source: ImageSource.gallery,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 80,
      );

      if (image != null) {
        print(
          '📸 ProfilePage._pickImage() - Imagen seleccionada: ${image.path}',
        );

        // Mostrar indicador de carga
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Guardando imagen...'),
              duration: Duration(seconds: 1),
            ),
          );
        }

        // Guardar imagen en el perfil
        await ProfileService.saveProfileImage(image.path);

        // Recargar el perfil para mostrar la nueva imagen
        await _loadProfile();

        if (mounted) {
          ErrorHandlerService.showSuccessSnackBar(
            context,
            'Imagen de perfil actualizada exitosamente',
          );
        }

        print('✅ ProfilePage._pickImage() - Imagen guardada exitosamente');
      } else {
        print('📸 ProfilePage._pickImage() - No se seleccionó imagen');
      }
    } catch (e) {
      print('❌ ProfilePage._pickImage() - Error: $e');

      if (mounted) {
        ErrorHandlerService.showErrorSnackBar(
          context,
          'Error al seleccionar imagen: $e',
        );
      }
    }
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _populateControllers(); // Restaurar valores originales
      }
    });
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      final updates = ProfileUpdateRequest(
        firstName: _firstNameController.text.trim(),
        lastName: _lastNameController.text.trim(),
        bio: _bioController.text.trim(),
        phoneNumber: _phoneController.text.trim(),
        level: _selectedLevel,
        country: _selectedCountry,
        language: _selectedLanguage,
        interests: _selectedInterests,
        learningGoal: _learningGoalController.text.trim(),
        dailyGoalMinutes: int.tryParse(_dailyGoalController.text),
        emailNotifications: _emailNotifications,
        pushNotifications: _pushNotifications,
      );

      await ProfileService.updateProfile(updates);
      await _loadProfile(); // Recargar perfil actualizado

      setState(() => _isEditing = false);
      ErrorHandlerService.showSuccessSnackBar(
        context,
        'Perfil actualizado exitosamente',
      );
    } catch (e) {
      ErrorHandlerService.showErrorSnackBar(
        context,
        'Error al actualizar perfil',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Método para cargar datos reales del usuario de prueba de la base de datos
  Future<void> _loadRealUserData() async {
    setState(() => _isLoading = true);
    try {
      print('🚀 ProfilePage._loadRealUserData() - Iniciando...');

      await SessionManager.startTestSession();
      print(
        '✅ ProfilePage._loadRealUserData() - Sesión iniciada, recargando perfil...',
      );

      // Recargar perfil con datos reales
      await _loadProfile();

      print(
        '🔍 ProfilePage._loadRealUserData() - Estado después de _loadProfile:',
      );
      print('  _profile: ${_profile != null ? 'existe' : 'null'}');
      if (_profile != null) {
        print('  Profile data: ${_profile!.firstName} ${_profile!.lastName}');
      }

      ErrorHandlerService.showSuccessSnackBar(
        context,
        'Sesión iniciada con usuario Test6. La sesión se mantendrá activa.',
      );
    } catch (e) {
      print('❌ ProfilePage._loadRealUserData() - Error: $e');
      ErrorHandlerService.showErrorSnackBar(
        context,
        'Error al iniciar sesión con usuario Test6',
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  // Método para cerrar sesión
  Future<void> _logout() async {
    try {
      await SessionManager.endSession();
      setState(() {
        _profile = null;
        _isEditing = false;
      });
      ErrorHandlerService.showSuccessSnackBar(
        context,
        'Sesión cerrada exitosamente',
      );
    } catch (e) {
      ErrorHandlerService.showErrorSnackBar(context, 'Error al cerrar sesión');
    }
  }

  // Método de debug para verificar el estado actual
  Future<void> _debugCurrentState() async {
    try {
      print('🔍 === DEBUG PROFILE PAGE STATE ===');
      print('_profile: ${_profile != null ? 'existe' : 'null'}');
      if (_profile != null) {
        print(
          'Profile data: ${_profile!.firstName} ${_profile!.lastName} (${_profile!.email})',
        );
      }

      await ProfileService.debugCurrentState();

      ErrorHandlerService.showInfoSnackBar(
        context,
        'Estado actual enviado a consola (ver logs)',
      );
    } catch (e) {
      print('❌ Error en _debugCurrentState: $e');
      ErrorHandlerService.showErrorSnackBar(
        context,
        'Error al obtener estado de debug',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    print('🏗️ ProfilePage.build() - Reconstruyendo UI');
    print(
      '🔍 ProfilePage.build() - _profile: ${_profile != null ? 'existe' : 'null'}',
    );
    print('🔍 ProfilePage.build() - _isEditing: $_isEditing');
    print('🔍 ProfilePage.build() - _isLoading: $_isLoading');

    if (_isLoading) {
      print('⏳ ProfilePage.build() - Mostrando loading');
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    // Si no hay perfil, mostrar mensaje de que el usuario debe autenticarse
    if (_profile == null) {
      print('🔍 ProfilePage.build() - Mostrando pantalla de no acceso');
      return Scaffold(
        appBar: AppBar(
          title: const Text('Mi Perfil'),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.person_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              const Text(
                'No tienes acceso a esta página',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'Debes autenticarte para ver tu perfil',
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
              const SizedBox(height: 32),
              // Botón de debug para verificar el estado actual
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: _debugCurrentState,
                  icon: const Icon(Icons.bug_report),
                  label: const Text('Debug: Ver Estado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Botón para iniciar sesión con usuario de prueba
              SizedBox(
                width: 200,
                child: ElevatedButton.icon(
                  onPressed: _loadRealUserData,
                  icon: const Icon(Icons.person),
                  label: const Text('Iniciar Sesión Test6'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryBlue,
                    foregroundColor: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Mi Perfil'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEdit,
          ),
          if (_isEditing)
            IconButton(icon: const Icon(Icons.save), onPressed: _saveProfile),
          if (!_isEditing && _profile != null)
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _logout(),
              tooltip: 'Cerrar Sesión',
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              const SizedBox(height: 24),

              // Sección de Identidad Web3
              _buildWeb3Section(),

              const SizedBox(height: 24),

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

              // Configuraciones de notificaciones locales
              _buildSettingsSection(
                title: 'Notificaciones Locales',
                icon: Icons.notifications_active,
                color: AppColors.secondaryOrange,
                children: [
                  _buildSwitchSetting(
                    title: 'Hechos Diarios',
                    subtitle: 'Recibe un hecho curioso sobre Italia cada día',
                    icon: Icons.calendar_today,
                    value: _dailyFactNotifications,
                    onChanged: (value) {
                      setState(() {
                        _dailyFactNotifications = value;
                      });
                      _updateNotificationSchedule();
                    },
                  ),

                  _buildSwitchSetting(
                    title: 'Hechos Aleatorios',
                    subtitle: 'Recibe hechos curiosos en momentos aleatorios',
                    icon: Icons.shuffle,
                    value: _randomFactNotifications,
                    onChanged: (value) {
                      setState(() {
                        _randomFactNotifications = value;
                      });
                      _updateNotificationSchedule();
                    },
                  ),

                  _buildActionSetting(
                    title: 'Hora de Notificación',
                    subtitle: _notificationTime.format(context),
                    icon: Icons.access_time,
                    onTap: _selectNotificationTime,
                  ),

                  _buildActionSetting(
                    title: 'Probar Notificación',
                    subtitle: 'Envía una notificación de prueba',
                    icon: Icons.send,
                    onTap: _testNotification,
                  ),

                  if (!_notificationsInitialized)
                    _buildInfoSetting(
                      title: 'Estado',
                      subtitle: 'Inicializando notificaciones...',
                      icon: Icons.info,
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
                    value: _selectedAppLanguage,
                    items: _availableLanguages,
                    onChanged: (value) {
                      setState(() {
                        _selectedAppLanguage = value!;
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
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Center(
      child: Column(
        children: [
          GestureDetector(
            onTap: _isEditing ? _pickImage : null,
            child: Stack(
              children: [
                CircleAvatar(
                  radius: 60,
                  backgroundImage: _profile?.avatar != null
                      ? FileImage(File(_profile!.avatar!))
                      : null,
                  child: _profile?.avatar == null
                      ? Text(
                          '${_profile?.firstName.substring(0, 1) ?? 'U'}${_profile?.lastName.substring(0, 1) ?? 'D'}',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                          ),
                        )
                      : null,
                ),
                if (_isEditing)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.primaryBlue,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.3),
                            blurRadius: 4,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.camera_alt,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                // Indicador de que se puede tocar cuando está editando
                if (_isEditing)
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.1),
                        shape: BoxShape.circle,
                      ),
                      child: const Center(
                        child: Icon(Icons.edit, color: Colors.white, size: 32),
                      ),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '${_profile?.firstName ?? ''} ${_profile?.lastName ?? ''}',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            _profile?.email ?? '',
            style: TextStyle(fontSize: 16, color: Colors.grey[600]),
          ),
          if (_isEditing) ...[
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.primaryBlue.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: AppColors.primaryBlue.withValues(alpha: 0.3),
                ),
              ),
              child: Text(
                'Toca la imagen para cambiarla',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.primaryBlue,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildPersonalInfoSection() {
    return _buildSection(
      title: 'Información Personal',
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextField(
                controller: _firstNameController,
                labelText: 'Nombre',
                readOnly: !_isEditing,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'El nombre es requerido';
                  return null;
                },
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: CustomTextField(
                controller: _lastNameController,
                labelText: 'Apellido',
                readOnly: !_isEditing,
                validator: (value) {
                  if (value?.isEmpty ?? true) return 'El apellido es requerido';
                  return null;
                },
              ),
            ),
          ],
        ),
        //const SizedBox(height: 16),
        // CustomTextField(
        // controller: _bioController,
        //  labelText: 'Biografía',
        // readOnly: !_isEditing,
        //maxLines: 3,
        //),
        //const SizedBox(height: 16),
        //CustomTextField(
        // controller: _phoneController,
        //labelText: 'Teléfono',
        //readOnly: !_isEditing,
        // keyboardType: TextInputType.phone,
        //),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: _buildDropdown(
                label: 'Nivel',
                value: _selectedLevel,
                items: ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'],
                onChanged: _isEditing
                    ? (value) => setState(() => _selectedLevel = value)
                    : null,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: _buildDropdown(
                label: 'País',
                value: _selectedCountry,
                items: ['Italia', 'España', 'México', 'Argentina', 'Colombia'],
                onChanged: _isEditing
                    ? (value) => setState(() => _selectedCountry = value)
                    : null,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        // Botón para probar la inicialización de usuario con datos reales de la base de datos
        // Solo mostrar si no hay sesión activa
        if (!_isEditing && _profile == null)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _loadRealUserData,
              icon: const Icon(Icons.person),
              label: const Text('Iniciar Sesión con Usuario Test6'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryBlue,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 12),
              ),
            ),
          ),
        // Botón de debug para verificar el estado actual
        /*if (!_isEditing)
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: _debugCurrentState,
              icon: const Icon(Icons.bug_report),
              label: const Text('Debug: Ver Estado Actual'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 8),
              ),
            ),
          ),*/
        // Mostrar estado de sesión cuando estés logueado
        if (!_isEditing && _profile != null)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.green.withOpacity(0.1),
              border: Border.all(color: Colors.green),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Icon(Icons.check_circle, color: Colors.green),
                SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Sesión activa como ${_profile!.firstName} ${_profile!.lastName}',
                    style: TextStyle(
                      color: Colors.green[700],
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _buildLearningPreferencesSection() {
    return _buildSection(
      title: 'Preferencias de Aprendizaje',
      children: [
        _buildDropdown(
          label: 'Idioma de la App',
          value: _selectedLanguage,
          items: ['italiano', 'español', 'inglés'],
          onChanged: _isEditing
              ? (value) => setState(() => _selectedLanguage = value)
              : null,
        ),
        const SizedBox(height: 16),
        //CustomTextField(
        //controller: _learningGoalController,
        //labelText: 'Meta de Aprendizaje',
        //readOnly: !_isEditing,
        //maxLines: 2,
        //),
        //const SizedBox(height: 16),
        //CustomTextField(
        // controller: _dailyGoalController,
        //labelText: 'Meta Diaria (minutos)',
        //readOnly: !_isEditing,
        //keyboardType: TextInputType.number,
        //validator: (value) {
        // final minutes = int.tryParse(value ?? '');
        //if (minutes == null || minutes <= 0)
        // return 'Ingresa un número válido';
        //return null;
        // },
        //),
      ],
    );
  }

  Widget _buildNotificationSettingsSection() {
    return _buildSection(
      title: 'Notificaciones',
      children: [
        SwitchListTile(
          title: const Text('Notificaciones por Email'),
          value: _emailNotifications,
          onChanged: _isEditing
              ? (value) => setState(() => _emailNotifications = value)
              : null,
          activeThumbColor: AppColors.primaryBlue,
        ),
        SwitchListTile(
          title: const Text('Notificaciones Push'),
          value: _pushNotifications,
          onChanged: _isEditing
              ? (value) => setState(() => _pushNotifications = value)
              : null,
          activeThumbColor: AppColors.primaryBlue,
        ),
      ],
    );
  }

  Widget _buildInterestsSection() {
    final allInterests = [
      'Cultura',
      'Viajes',
      'Cocina',
      'Música',
      'Arte',
      'Historia',
      'Deportes',
      'Tecnología',
      'Literatura',
      'Cine',
      'Fotografía',
    ];

    return _buildSection(
      title: 'Intereses',
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: allInterests.map((interest) {
            final isSelected = _selectedInterests.contains(interest);
            return FilterChip(
              label: Text(interest),
              selected: isSelected,
              onSelected: _isEditing
                  ? (selected) {
                      setState(() {
                        if (selected) {
                          _selectedInterests.add(interest);
                        } else {
                          _selectedInterests.remove(interest);
                        }
                      });
                    }
                  : null,
              selectedColor: AppColors.primaryBlue.withOpacity(0.3),
              checkmarkColor: AppColors.primaryBlue,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.primaryBlue,
          ),
        ),
        const SizedBox(height: 16),
        ...children,
      ],
    );
  }

  Widget _buildDropdown({
    required String label,
    required String? value,
    required List<String> items,
    required ValueChanged<String?>? onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          initialValue: value,
          items: items
              .map((item) => DropdownMenuItem(value: item, child: Text(item)))
              .toList(),
          onChanged: onChanged,
          decoration: InputDecoration(
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 12,
            ),
          ),
        ),
      ],
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
            activeThumbColor: AppColors.primaryBlue,
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

  /// Construye la sección de información Web3
  Widget _buildWeb3Section() {
    return BlocBuilder<AuthBloc, AuthState>(
      builder: (context, authState) {
        if (authState is AuthAuthenticated) {
          return Card(
            elevation: 2,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.fingerprint,
                        color: Colors.amber[700],
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Identidad Descentralizada',
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Colors.amber[700],
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  UserWeb3Info(user: authState.user),
                ],
              ),
            ),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _learningGoalController.dispose();
    _dailyGoalController.dispose();
    super.dispose();
  }
}
