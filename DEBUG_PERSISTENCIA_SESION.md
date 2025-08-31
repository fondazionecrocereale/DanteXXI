# Debug de Persistencia de Sesión - DanteXXI

## Problema Identificado

❌ **La sesión no se está guardando correctamente** - Necesitamos identificar en qué paso del flujo está fallando.

## Cambios Implementados para Debug

### 1. **ProfileService con Logs Detallados**
- ✅ Logs en `saveProfile()` para verificar cada paso
- ✅ Logs en `getProfile()` para verificar recuperación
- ✅ Logs en `hasActiveSession()` para verificar estado de sesión
- ✅ Método `debugCurrentState()` para verificar estado completo

### 2. **SessionManager Simplificado**
- ✅ Eliminada duplicación de lógica de sesión
- ✅ Ahora solo usa ProfileService para gestión de sesión
- ✅ Logs detallados en cada operación

### 3. **Página de Perfil con Botón de Debug**
- ✅ Botón naranja "Debug: Ver Estado Actual"
- ✅ Muestra estado en consola para análisis

## Cómo Debuggear la Persistencia

### **Paso 1: Verificar Estado Inicial**
1. Abre la aplicación
2. Ve a "Mi Perfil"
3. **Presiona el botón naranja "Debug: Ver Estado Actual"**
4. **Revisa la consola** para ver el estado actual

**Estado esperado inicial:**
```
🔍 === DEBUG PROFILE PAGE STATE ===
_profile: null
🔍 === DEBUG PROFILE SERVICE STATE ===
Session Key (user_session): null
Profile Key (user_profile): no existe
StorageService.isLoggedIn(): false
=====================================
```

### **Paso 2: Iniciar Sesión y Verificar**
1. **Presiona "Iniciar Sesión con Usuario Test6"**
2. **Observa los logs en consola** durante el proceso
3. **Espera a que termine** el proceso de login
4. **Presiona "Debug: Ver Estado Actual"** nuevamente

**Logs esperados durante login:**
```
🧪 SessionManager.startTestSession() - Iniciando sesión de prueba...
🚀 SessionManager.startSession() - Iniciando sesión para Test6 Test6
🔐 ProfileService.saveProfile() - Iniciando...
✅ ProfileService.saveProfile() - Perfil guardado en user_profile
✅ ProfileService.saveProfile() - Sesión marcada como activa en user_session
✅ ProfileService.saveProfile() - StorageService.setLoggedIn(true) completado
🔍 ProfileService.saveProfile() - Verificación: profile=true, session=true
✅ SessionManager.startSession() - Sesión iniciada exitosamente
🔍 === DEBUG PROFILE SERVICE STATE ===
Session Key (user_session): active
Profile Key (user_profile): existe
StorageService.isLoggedIn(): true
Profile Data: {id: e6f1abfb-4d20-4def-a416-96326d0542a5, email: test6@gmail.com, ...}
=====================================
```

**Estado esperado después del login:**
```
🔍 === DEBUG PROFILE PAGE STATE ===
_profile: existe
Profile data: Test6 Test6 (test6@gmail.com)
🔍 === DEBUG PROFILE SERVICE STATE ===
Session Key (user_session): active
Profile Key (user_profile): existe
StorageService.isLoggedIn(): true
Profile Data: {id: e6f1abfb-4d20-4def-a416-96326d0542a5, ...}
=====================================
```

### **Paso 3: Verificar Persistencia con Hot Restart**
1. **Mantén la aplicación abierta**
2. **Presiona Ctrl+S (o Cmd+S)** para hacer hot restart
3. **Observa la SplashPage** - debería ir a HomePage
4. **Ve a "Mi Perfil"** desde HomePage
5. **Presiona "Debug: Ver Estado Actual"**

**Estado esperado después de hot restart:**
```
🔍 === DEBUG PROFILE PAGE STATE ===
_profile: existe
Profile data: Test6 Test6 (test6@gmail.com)
🔍 === DEBUG PROFILE SERVICE STATE ===
Session Key (user_session): active
Profile Key (user_profile): existe
StorageService.isLoggedIn(): true
Profile Data: {id: e6f1abfb-4d20-4def-a416-96326d0542a5, ...}
=====================================
```

## Posibles Problemas y Soluciones

### **Problema 1: No se guarda el perfil**
**Síntomas:**
- Logs muestran error en `ProfileService.saveProfile()`
- `Profile Key (user_profile): no existe` después de login

**Solución:**
- Verificar que `EditableProfile.toJson()` funcione correctamente
- Verificar permisos de SharedPreferences

### **Problema 2: No se marca la sesión como activa**
**Síntomas:**
- `Session Key (user_session): null` después de login
- Perfil se guarda pero no se puede recuperar

**Solución:**
- Verificar que `prefs.setString(_sessionKey, 'active')` funcione
- Verificar que no haya conflictos de claves

### **Problema 3: StorageService no se sincroniza**
**Síntomas:**
- `StorageService.isLoggedIn(): false` después de login
- ProfileService funciona pero StorageService no

**Solución:**
- Verificar que `StorageService.setLoggedIn(true)` funcione
- Verificar que no haya excepciones silenciosas

### **Problema 4: Hot Restart no mantiene la sesión**
**Síntomas:**
- Sesión se guarda correctamente
- Pero después de hot restart va a LoginPage

**Solución:**
- Verificar que `SplashPage` use `ProfileService.hasActiveSession()`
- Verificar que no haya conflictos con `AuthBloc`

## Comandos de Debug

### **Para Ver Logs en Consola:**
- **VS Code**: Ver panel "Debug Console"
- **Android Studio**: Ver panel "Run" o "Debug"
- **Terminal**: Si ejecutas desde línea de comandos

### **Para Hot Restart:**
- **Windows/Linux**: `Ctrl + S`
- **Mac**: `Cmd + S`
- **VS Code**: `Ctrl + Shift + P` → "Flutter: Hot Restart"

## Archivos a Verificar

### 1. **`lib/core/services/profile_service.dart`**
- ✅ Logs en `saveProfile()`
- ✅ Logs en `getProfile()`
- ✅ Logs en `hasActiveSession()`
- ✅ Método `debugCurrentState()`

### 2. **`lib/core/services/session_manager.dart`**
- ✅ Logs en `startSession()`
- ✅ Logs en `checkActiveSession()`
- ✅ Logs en `endSession()`

### 3. **`lib/presentation/pages/profile_page.dart`**
- ✅ Botón de debug
- ✅ Método `_debugCurrentState()`

## Resultado Esperado

✅ **Después de implementar los logs:**
- Podrás ver exactamente en qué paso falla la persistencia
- Identificarás si el problema está en guardar, recuperar o verificar
- Tendrás información completa del estado de la aplicación

## Próximos Pasos

1. **Ejecuta la aplicación** y sigue los pasos de debug
2. **Revisa los logs** en la consola
3. **Identifica el punto exacto** donde falla la persistencia
4. **Comparte los logs** para análisis detallado

¡Con estos logs podremos identificar exactamente por qué no se guarda la sesión!
