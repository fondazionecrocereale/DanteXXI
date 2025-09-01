import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import '../../core/constants/app_colors.dart';
import '../../core/constants/app_texts.dart';
import '../../core/services/profile_service.dart';
import '../../core/services/error_handler_service.dart';
import '../../core/services/auth_service.dart';
import '../../core/services/session_manager.dart';
import '../../domain/entities/editable_profile.dart';
import '../widgets/custom_text_field.dart';
import '../widgets/custom_button.dart';

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

  @override
  void initState() {
    super.initState();
    _initializeControllers();
    _loadProfile();
  }

  void _initializeControllers() {
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _bioController = TextEditingController();
    _phoneController = TextEditingController();
    _learningGoalController = TextEditingController();
    _dailyGoalController = TextEditingController();
  }

  Future<void> _loadProfile() async {
    print('🔄 ProfilePage._loadProfile() - Iniciando...');
    setState(() => _isLoading = true);
    try {
      final profile = await ProfileService.getProfile();
      print(
        '🔍 ProfilePage._loadProfile() - Profile obtenido: ${profile != null ? 'existe' : 'null'}',
      );

      if (profile != null) {
        print('✅ ProfilePage._loadProfile() - Asignando perfil a _profile');
        _profile = profile;
        print(
          '🔍 ProfilePage._loadProfile() - _profile después de asignar: ${_profile != null ? 'existe' : 'null'}',
        );

        _populateControllers();
        print('✅ ProfilePage._loadProfile() - Controllers poblados');

        // Mostrar mensaje de que la sesión se mantuvo activa
        if (mounted) {
          ErrorHandlerService.showInfoSnackBar(
            context,
            'Sesión mantenida: Bienvenido de vuelta, ${profile.firstName}!',
          );
        }

        print('✅ ProfilePage._loadProfile() - Perfil cargado exitosamente');
      } else {
        print('❌ ProfilePage._loadProfile() - No hay perfil disponible');
        // No hay perfil - el usuario debe estar autenticado para ver esta página
        setState(() => _isLoading = false);
        // No crear perfil por defecto, solo mostrar que no hay datos
        return;
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
              onPressed: _logout,
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
              _buildPersonalInfoSection(),
              const SizedBox(height: 24),
              _buildLearningPreferencesSection(),
              //const SizedBox(height: 24),
              //_buildNotificationSettingsSection(),
              const SizedBox(height: 24),
              _buildInterestsSection(),
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
                          '${_profile?.firstName?.substring(0, 1) ?? 'U'}${_profile?.lastName?.substring(0, 1) ?? 'D'}',
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
          activeColor: AppColors.primaryBlue,
        ),
        SwitchListTile(
          title: const Text('Notificaciones Push'),
          value: _pushNotifications,
          onChanged: _isEditing
              ? (value) => setState(() => _pushNotifications = value)
              : null,
          activeColor: AppColors.primaryBlue,
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
          value: value,
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
