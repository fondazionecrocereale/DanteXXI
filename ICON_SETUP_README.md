# 🎨 Configuración del Icono Personalizado - DanteXXI

## 📋 Descripción

Este documento explica cómo configurar el icono personalizado para la aplicación DanteXXI usando `flutter_launcher_icons`.

## 🚀 Pasos para Configurar el Icono

### 1. **Requisitos Previos**

- ✅ Flutter instalado y configurado
- ✅ Archivo de icono en formato PNG (1024x1024 pixels recomendado)

### 2. **Preparar el Icono**

El icono debe estar en formato PNG en la ruta `assets/icon/icon.png`.

**Si tienes un archivo JPG:**
- Abrir `assets/icon/icon.jpg` en un editor de imágenes
- Exportar como PNG con tamaño 1024x1024 pixels
- Guardar como `assets/icon/icon.png`

### 3. **Configuración del Icono**

La configuración ya está en `pubspec.yaml`:

```yaml
flutter_launcher_icons:
  android: "launcher_icon"
  ios: true
  image_path: "assets/icon/icon.png"
  min_sdk_android: 21
  
  web:
    generate: true
    image_path: "assets/icon/icon.png"
    background_color: "#009246"
    theme_color: "#CE2B37"
    favicon: true
  
  windows:
    generate: true
    image_path: "assets/icon/icon.png"
    icon_size: 48
  
  macos:
    generate: true
    image_path: "assets/icon/icon.png"
  
  linux:
    generate: true
    image_path: "assets/icon/icon.png"
```

### 4. **Generar los Iconos**

```bash
# Instalar dependencias
flutter pub get

# Generar iconos para todas las plataformas
flutter pub run flutter_launcher_icons:main

# O usar el comando moderno
dart run flutter_launcher_icons:main
```

### 5. **Verificar la Generación**

Después de ejecutar el comando, se generarán los iconos en:

- **Android**: `android/app/src/main/res/` (diferentes resoluciones)
- **iOS**: `ios/Runner/Assets.xcassets/AppIcon.appiconset/`
- **Web**: `web/icons/` + favicon
- **Windows**: `windows/runner/`
- **macOS**: `macos/Runner/Assets.xcassets/AppIcon.appiconset/`
- **Linux**: `linux/`

## 🎯 Especificaciones del Icono

### **Tamaño Recomendado**
- **Imagen fuente**: 1024x1024 pixels
- **Formato**: PNG (mejor calidad y transparencia)
- **Color de fondo**: #009246 (verde italiano)
- **Color del tema**: #CE2B37 (rojo italiano)

### **Plataformas Soportadas**
- ✅ Android (API 21+)
- ✅ iOS
- ✅ Web (con favicon automático)
- ✅ Windows
- ✅ macOS
- ✅ Linux

## 🔧 Personalización

### **Cambiar Colores**
Editar `pubspec.yaml`:

```yaml
web:
  background_color: "#TU_COLOR_AQUI"
  theme_color: "#TU_COLOR_AQUI"
```

### **Cambiar Tamaño del Icono**
```yaml
windows:
  icon_size: 64  # Cambiar de 48 a 64
```

### **Agregar Nuevas Plataformas**
```yaml
nueva_plataforma:
  generate: true
  image_path: "assets/icon/icon.png"
```

## 🚨 Solución de Problemas

### **Error: "Image not found"**
- Verificar que `assets/icon/icon.png` existe
- Verificar la ruta en `pubspec.yaml`

### **Error: "Invalid image format"**
- Convertir la imagen a PNG
- Verificar que la imagen sea cuadrada (1:1 aspect ratio)

### **Error: "Duplicate mapping key"**
- Verificar que no haya configuraciones duplicadas en `pubspec.yaml`
- Usar solo una configuración de `flutter_launcher_icons`

### **Iconos no se actualizan**
- Limpiar build: `flutter clean`
- Reconstruir: `flutter pub get && flutter pub run flutter_launcher_icons:main`

### **Problemas con Android**
- Verificar `min_sdk_android: 21` en la configuración
- Limpiar proyecto Android: `cd android && ./gradlew clean`

## 📱 Pruebas

### **Android**
```bash
flutter run --debug
```

### **iOS**
```bash
flutter run --debug
```

### **Web**
```bash
flutter run -d chrome
```

### **Windows**
```bash
flutter run -d windows
```

## 🎉 ¡Listo!

Después de seguir estos pasos, tu aplicación DanteXXI tendrá un icono personalizado en todas las plataformas soportadas, incluyendo un favicon automático para web.

## 📚 Recursos Adicionales

- [Documentación oficial de flutter_launcher_icons](https://pub.dev/packages/flutter_launcher_icons)
- [Guía de iconos de Flutter](https://flutter.dev/docs/development/ui/assets-and-images)
- [Generador de iconos online](https://appicon.co/)
