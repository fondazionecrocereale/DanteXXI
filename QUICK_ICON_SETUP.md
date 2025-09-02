# 🚀 Configuración Rápida del Icono - DanteXXI

## ⚡ Pasos Rápidos

### **1. Preparar el Icono**
- Asegúrate de que `assets/icon/icon.png` existe
- Si tienes JPG, convierte a PNG (1024x1024 pixels)

### **2. Generar Iconos**
```bash
# Instalar dependencias
flutter pub get

# Generar iconos (comando moderno)
dart run flutter_launcher_icons:main

# O comando legacy
flutter pub run flutter_launcher_icons:main
```

## 📱 Verificar Resultado

Los iconos se generarán en:

- ✅ **Android**: `android/app/src/main/res/`
- ✅ **Web**: `web/icons/` + favicon automático
- ✅ **Windows**: `windows/runner/`
- ✅ **macOS**: `macos/Runner/Assets.xcassets/AppIcon.appiconset/`
- ✅ **Linux**: `linux/`

## 🎯 Probar la Aplicación

```bash
flutter run --debug
```

## 🔧 Si Algo Sale Mal

```bash
# Limpiar y reconstruir
flutter clean
flutter pub get
dart run flutter_launcher_icons:main
```

## 🚨 Errores Comunes

### **"Duplicate mapping key"**
- ✅ **Solucionado**: La configuración ya está corregida en `pubspec.yaml`

### **"Image not found"**
- Verificar que `assets/icon/icon.png` existe

### **"Invalid image format"**
- Convertir imagen a PNG
- Verificar tamaño 1024x1024 pixels

---

📚 **Documentación completa**: `ICON_SETUP_README.md`
