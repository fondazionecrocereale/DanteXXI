# Ejemplo de Uso - Perfil con Datos Reales

## Usuario de Prueba en la Base de Datos

```json
{
  "idx": 4,
  "id": "e6f1abfb-4d20-4def-a416-96326d0542a5",
  "email": "test6@gmail.com",
  "first_name": "Test6",
  "last_name": "Test6",
  "avatar": null,
  "level": "A1",
  "total_xp": 0,
  "current_streak": 0,
  "longest_streak": 0,
  "lessons_completed": 0,
  "exercises_completed": 0,
  "words_learned": 0,
  "join_date": "2025-08-31 11:00:27.833579+00",
  "is_premium": false,
  "country": null,
  "credits": "0",
  "currency": "USD",
  "intereses": [],
  "language": "italiano",
  "last_sign_in": "2025-08-31 19:18:54.02042+00",
  "uid": "d8627a39-283b-c4d2-bdee-ab250e2adfb8",
  "created_at": "2025-08-31 11:00:27.833579+00",
  "updated_at": "2025-08-31 11:00:27.833579+00",
  "password": "123456"
}
```

## Cómo Probar la Funcionalidad

### 1. Abrir la Página de Perfil
- Ve a la página "Mi Perfil" en la aplicación
- Inicialmente verás un mensaje de que no tienes acceso

### 2. Cargar Datos Reales del Usuario
- Presiona el botón **"Cargar Datos Reales de Usuario (Test6)"**
- Esto simulará la autenticación del usuario de prueba

### 3. Ver los Datos Reales
Después de cargar, verás:

- **Nombre**: Test6 (en lugar de "Usuario")
- **Apellido**: Test6 (en lugar de "DanteXXI")
- **Email**: test6@gmail.com (en lugar de "usuario@example.com")
- **Nivel**: A1 (en lugar de "Principiante")
- **País**: (vacío, ya que es null en la base de datos)
- **Idioma**: italiano (en lugar de "Español")
- **Biografía**: (vacía, ya que no existe en la base de datos)
- **Intereses**: (lista vacía, ya que el array está vacío en la base de datos)

## Código de Ejemplo

### Para tu aplicación real, usa esto después de la autenticación:

```dart
// Después de que el usuario se autentique exitosamente:
await AuthService.initializeUserAfterAuth(
  id: userData['id'],
  email: userData['email'],
  firstName: userData['first_name'], // Mapear desde tu base de datos
  lastName: userData['last_name'],   // Mapear desde tu base de datos
  level: userData['level'],
  country: userData['country'],
  language: userData['language'],
  interests: userData['intereses'] ?? [],
  bio: userData['bio'], // Si tienes este campo
  emailNotifications: true, // Configurar según tus necesidades
  pushNotifications: true,  // Configurar según tus necesidades
  learningGoal: userData['learning_goal'], // Si tienes este campo
  dailyGoalMinutes: userData['daily_goal_minutes'] ?? 30, // Si tienes este campo
);
```

### Mapeo de Campos de tu Base de Datos:

| Campo en tu DB | Campo en la App | Ejemplo |
|----------------|------------------|---------|
| `first_name` | `firstName` | "Test6" |
| `last_name` | `lastName` | "Test6" |
| `email` | `email` | "test6@gmail.com" |
| `level` | `level` | "A1" |
| `country` | `country` | null |
| `language` | `language` | "italiano" |
| `intereses` | `interests` | [] |

## Resultado Esperado

✅ **Antes**: Campos con valores por defecto genéricos
- Nombre: "Usuario"
- Apellido: "DanteXXI"
- Email: "usuario@example.com"
- Nivel: "Principiante"

✅ **Después**: Campos con datos reales de tu base de datos
- Nombre: "Test6"
- Apellido: "Test6"
- Email: "test6@gmail.com"
- Nivel: "A1"

## Notas Importantes

1. **No hay perfiles por defecto**: La aplicación solo muestra datos reales
2. **Validación de autenticación**: Solo usuarios autenticados pueden ver su perfil
3. **Persistencia local**: Los datos se guardan en SharedPreferences
4. **Sincronización**: Los cambios se guardan inmediatamente

## Próximos Pasos para tu Aplicación

1. **Reemplazar `AuthService.loginExample()`** con tu API real de autenticación
2. **Mapear correctamente** los campos de tu base de datos
3. **Agregar manejo de tokens** de autenticación
4. **Implementar sincronización** con tu servidor
