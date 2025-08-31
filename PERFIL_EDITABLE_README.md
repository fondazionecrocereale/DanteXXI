# Perfil Editable - DanteXXI

## Descripción

Se ha implementado un sistema de perfil editable que solo muestra datos reales del usuario autenticado, sin crear perfiles por defecto.

## Características

- ✅ **Solo datos reales**: No se crean perfiles por defecto
- ✅ **Validación de autenticación**: Solo usuarios autenticados pueden ver su perfil
- ✅ **Persistencia de datos**: Los datos se guardan en almacenamiento local
- ✅ **Actualización en tiempo real**: Los cambios se reflejan inmediatamente

## Arquitectura

### 1. Entidad EditableProfile
- **Archivo**: `lib/domain/entities/editable_profile.dart`
- **Descripción**: Define la estructura del perfil del usuario usando Freezed
- **Campos**: id, email, firstName, lastName, avatar, level, country, language, interests, bio, etc.

### 2. Servicio de Perfil
- **Archivo**: `lib/core/services/profile_service.dart`
- **Funciones**:
  - `getProfile()`: Obtiene el perfil del usuario
  - `saveProfile()`: Guarda el perfil
  - `updateProfile()`: Actualiza campos específicos
  - `clearProfile()`: Limpia el perfil (logout)

### 3. Servicio de Autenticación
- **Archivo**: `lib/core/services/auth_service.dart`
- **Funciones**:
  - `initializeUserAfterAuth()`: Inicializa datos del usuario después del login
  - `loginExample()`: Ejemplo de cómo usar el servicio
  - `logout()`: Cierra sesión
  - `isAuthenticated()`: Verifica si el usuario está autenticado

### 4. Página de Perfil
- **Archivo**: `lib/presentation/pages/profile_page.dart`
- **Funcionalidades**:
  - Muestra solo datos reales del usuario
  - Modo de edición con validaciones
  - Guardado automático de cambios
  - Manejo de errores

## Cómo usar

### 1. Inicializar datos del usuario después de la autenticación

```dart
// En tu página de login, después de autenticación exitosa:
await AuthService.initializeUserAfterAuth(
  id: userData['id'],
  email: userData['email'],
  firstName: userData['firstName'], // Nombre real del usuario
  lastName: userData['lastName'],   // Apellido real del usuario
  level: userData['level'],
  country: userData['country'],
  language: userData['language'],
  interests: userData['interests'],
  bio: userData['bio'],
  emailNotifications: userData['emailNotifications'],
  pushNotifications: userData['pushNotifications'],
  learningGoal: userData['learningGoal'],
  dailyGoalMinutes: userData['dailyGoalMinutes'],
);
```

### 2. Ejemplo de uso con datos simulados

```dart
// Para probar la funcionalidad:
await AuthService.loginExample(
  email: 'dante@example.com',
  password: 'password123',
);
```

### 3. Verificar autenticación

```dart
// Verificar si el usuario está autenticado:
final isAuth = await AuthService.isAuthenticated();
if (isAuth) {
  // Usuario autenticado, mostrar perfil
} else {
  // Usuario no autenticado, redirigir a login
}
```

### 4. Cerrar sesión

```dart
// Al cerrar sesión:
await AuthService.logout();
```

## Flujo de trabajo

1. **Usuario se autentica** → Se llama a `AuthService.initializeUserAfterAuth()`
2. **Datos se guardan** → Se almacenan en SharedPreferences
3. **Usuario accede al perfil** → Se cargan los datos reales
4. **Usuario edita perfil** → Se actualizan los datos
5. **Usuario cierra sesión** → Se limpian los datos

## Validaciones

- **Campos requeridos**: firstName y lastName son obligatorios
- **Tipos de datos**: Se validan los tipos de entrada
- **Autenticación**: Solo usuarios autenticados pueden acceder
- **Persistencia**: Los datos se mantienen entre sesiones

## Notas importantes

- **No hay perfiles por defecto**: Si no hay datos, se muestra mensaje de error
- **Datos reales**: Solo se muestran datos que vienen de la autenticación
- **Seguridad**: Los datos se almacenan localmente en el dispositivo
- **Sincronización**: Los cambios se guardan inmediatamente

## Próximos pasos

Para integrar completamente con tu backend:

1. Reemplazar `AuthService.loginExample()` con tu API real
2. Agregar manejo de tokens de autenticación
3. Implementar sincronización con el servidor
4. Agregar validaciones adicionales según tus necesidades
