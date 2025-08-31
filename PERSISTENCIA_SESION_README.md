# Persistencia de Sesión - DanteXXI

## Descripción

Se ha implementado un sistema de persistencia de sesión que mantiene al usuario autenticado entre sesiones de la aplicación. Ahora cuando sales y vuelves a entrar a la app, tu sesión se mantiene activa automáticamente.

## Características

- ✅ **Sesión persistente**: La sesión se mantiene activa entre cierres de la aplicación
- ✅ **Verificación automática**: Al abrir la app, verifica automáticamente si hay una sesión activa
- ✅ **Mensaje de bienvenida**: Muestra un mensaje cuando se mantiene la sesión
- ✅ **Gestión de sesión**: Botones para iniciar y cerrar sesión
- ✅ **Datos persistentes**: Los datos del usuario se mantienen en almacenamiento local

## Arquitectura

### 1. SessionManager
- **Archivo**: `lib/core/services/session_manager.dart`
- **Funciones**:
  - `checkActiveSession()`: Verifica si hay una sesión activa
  - `startSession()`: Inicia una nueva sesión
  - `endSession()`: Cierra la sesión actual
  - `isSessionExpired()`: Verifica si la sesión ha expirado
  - `startTestSession()`: Inicia sesión con usuario de prueba

### 2. ProfileService (mejorado)
- **Archivo**: `lib/core/services/profile_service.dart`
- **Funciones**:
  - `getProfile()`: Obtiene el perfil del usuario
  - `saveProfile()`: Guarda el perfil en almacenamiento local
  - `clearProfile()`: Limpia el perfil al cerrar sesión

### 3. ProfilePage (mejorada)
- **Archivo**: `lib/presentation/pages/profile_page.dart`
- **Funcionalidades**:
  - Verificación automática de sesión al cargar
  - Mensaje de bienvenida cuando se mantiene la sesión
  - Botón para iniciar sesión con usuario de prueba
  - Botón para cerrar sesión
  - Validación de autenticación

## Cómo Funciona

### 1. **Al abrir la aplicación por primera vez**
- No hay sesión activa
- Se muestra mensaje de que debe autenticarse
- El usuario debe presionar "Iniciar Sesión con Usuario Test6"

### 2. **Al iniciar sesión**
- Se crea el perfil del usuario con datos reales
- Se guarda la información de sesión en SharedPreferences
- Se muestra el perfil del usuario

### 3. **Al cerrar la aplicación y volver a abrirla**
- La app verifica automáticamente si hay una sesión activa
- Si hay sesión, carga automáticamente el perfil del usuario
- Muestra mensaje: "Sesión mantenida: Bienvenido de vuelta, Test6!"

### 4. **Al cerrar sesión manualmente**
- Se limpia el perfil del usuario
- Se elimina la información de sesión
- Se vuelve al estado inicial

## Flujo de Trabajo

```
1. Abrir App → Verificar sesión activa
2. Si NO hay sesión → Mostrar mensaje de autenticación
3. Si HAY sesión → Cargar perfil automáticamente + Mensaje de bienvenida
4. Usuario puede:
   - Ver/editar su perfil
   - Cerrar sesión manualmente
5. Al cerrar app → Sesión se mantiene
6. Al volver a abrir → Sesión se restaura automáticamente
```

## Código de Ejemplo

### Para tu aplicación real, usa esto después de la autenticación:

```dart
// Después de que el usuario se autentique exitosamente:
await SessionManager.startSession(
  id: userData['id'],
  email: userData['email'],
  firstName: userData['first_name'],
  lastName: userData['last_name'],
  level: userData['level'],
  country: userData['country'],
  language: userData['language'],
  interests: userData['intereses'] ?? [],
  bio: userData['bio'],
  emailNotifications: true,
  pushNotifications: true,
  learningGoal: userData['learning_goal'],
  dailyGoalMinutes: userData['daily_goal_minutes'] ?? 30,
);
```

### Para verificar si hay una sesión activa:

```dart
// Al iniciar la aplicación:
final hasActiveSession = await SessionManager.checkActiveSession();
if (hasActiveSession) {
  // Usuario ya está autenticado, cargar perfil
  await _loadProfile();
} else {
  // Usuario no autenticado, mostrar login
  _showLoginScreen();
}
```

### Para cerrar sesión:

```dart
// Al cerrar sesión:
await SessionManager.endSession();
// Limpiar UI y mostrar pantalla de login
```

## Beneficios

1. **Mejor experiencia de usuario**: No necesita autenticarse cada vez
2. **Datos persistentes**: El perfil se mantiene entre sesiones
3. **Seguridad**: La sesión se puede cerrar manualmente
4. **Flexibilidad**: Fácil de integrar con tu sistema de autenticación real

## Próximos Pasos

Para integrar completamente con tu backend:

1. **Reemplazar `SessionManager.startTestSession()`** con tu API real
2. **Agregar manejo de tokens** de autenticación
3. **Implementar expiración de sesión** según tus políticas
4. **Agregar sincronización** con tu servidor
5. **Implementar refresh tokens** para sesiones largas

## Notas Importantes

- **Persistencia local**: Los datos se almacenan en SharedPreferences
- **Sin expiración automática**: La sesión se mantiene hasta que se cierre manualmente
- **Datos reales**: Solo se muestran datos que vienen de la autenticación
- **Seguridad**: Los datos se limpian al cerrar sesión

## Resultado Final

✅ **Antes**: Usuario debía autenticarse cada vez que abría la app
✅ **Después**: Usuario mantiene su sesión activa automáticamente

Ahora cuando entres a la aplicación, verás tu perfil cargado automáticamente con un mensaje de bienvenida, y cuando cierres y vuelvas a abrir la app, tu sesión se mantendrá activa.
