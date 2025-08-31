# 🇮🇹 **DANTEXXI** - Aplicación de Aprendizaje de Italiano

## 📱 **Descripción**

DanteXXI es una aplicación móvil moderna y completa para aprender italiano, diseñada con arquitectura limpia y tecnologías de vanguardia. La aplicación combina funcionalidades probadas de aprendizaje de idiomas con características específicas para el italiano.

## 🚀 **Características Principales**

- **🎯 Arquitectura Clean** con Flutter Bloc Pattern
- **🇮🇹 Contenido Específico para Italiano** con niveles CEFR
- **🎬 Sistema de Reels Educativos** con ejercicios integrados
- **📚 Sistema de Audiolibros** con transcripciones sincronizadas
- **🗺️ Mapa de Aprendizaje Visual** interactivo
- **📱 Diseño Responsive** para todos los dispositivos
- **🎯 Ejercicios Interactivos** de 5 tipos diferentes
- **🃏 Sistema de Flashcards** similar a Anki
- **🔤 Entrenador de Verbos Italianos** completo
- **🌙 Modo Oscuro** con sistema de temas
- **🚀 Splash Screen Inteligente** con navegación automática

## 🏗️ **Arquitectura y Tecnologías**

### **Stack Tecnológico**
- **Frontend**: Flutter 3.35.2 con Dart 3.9
- **State Management**: flutter_bloc + equatable
- **Dependency Injection**: GetIt
- **Code Generation**: Freezed + json_serializable
- **HTTP Client**: Dio + Retrofit
- **Local Storage**: Shared Preferences + Hive
- **Error Monitoring**: Sentry
- **Logging**: Logger
- **UI Components**: Google Fonts, Shimmer, Cached Network Image

### **Arquitectura Clean**
```
lib/
├── core/           # Constantes, errores, red, utilidades
├── domain/         # Entidades, repositorios, casos de uso
├── data/           # Fuentes de datos, modelos, implementaciones
├── presentation/   # Páginas, widgets, blocs
├── di/             # Inyección de dependencias
├── routes/         # Sistema de navegación
└── shared/         # Widgets y extensiones compartidas
```

## 📋 **Estado Actual del Proyecto**

### ✅ **Completado (MES 1 - Semana 1-2)**
- [x] Configuración del proyecto Flutter
- [x] Estructura de carpetas Clean Architecture
- [x] Dependencias y configuración del pubspec.yaml
- [x] Constantes de la aplicación (colores, textos, configuración)
- [x] Sistema de manejo de errores y excepciones
- [x] Clase Result para operaciones exitosas/fallidas
- [x] Cliente Dio configurado con interceptores
- [x] Sistema de inyección de dependencias con GetIt
- [x] Bloc de autenticación (estados, eventos, lógica)
- [x] Splash Screen inteligente con animaciones
- [x] Main.dart configurado con temas y providers
- [x] Configuración de fuentes italianas (Lora, Tinos)

### 🔄 **En Progreso**
- [ ] Implementación de Bloc Pattern completo
- [ ] Sistema de navegación y rutas
- [ ] Páginas de autenticación (login/registro)

### 📅 **Próximos Pasos (MES 1 - Semana 3-4)**
- [ ] Implementación de Bloc Pattern para todas las funcionalidades
- [ ] Sistema de navegación con RouteGenerator
- [ ] Páginas de onboarding y autenticación
- [ ] Configuración de Hive para almacenamiento local

## 🎯 **Roadmap del Proyecto**

### **MES 1: FUNDAMENTOS Y ARQUITECTURA** ✅
- **Semana 1-2**: ✅ Configuración del proyecto, Clean Architecture
- **Semana 3-4**: 🔄 Implementación de Bloc Pattern, GetIt, Freezed

### **MES 2: AUTENTICACIÓN Y PERFIL**
- **Semana 1-2**: Sistema de autenticación con Golang API
- **Semana 3-4**: Perfil de usuario y gestión de datos

### **MES 3: SISTEMA DE LECCIONES**
- **Semana 1-2**: Estructura de lecciones y progreso
- **Semana 3-4**: Sistema de niveles CEFR

### **MES 4: DICCIONARIO Y VOCABULARIO**
- **Semana 1-2**: Base de datos de palabras italianas
- **Semana 3-4**: Funcionalidades de búsqueda y favoritos

### **MES 5: EJERCICIOS INTERACTIVOS**
- **Semana 1-2**: Implementación de tipos de ejercicios
- **Semana 3-4**: Sistema de audio y feedback

### **MES 6: GRAMÁTICA ITALIANA**
- **Semana 1-2**: Sistema de conjugación de verbos
- **Semana 3-4**: Tablas de declinación y reglas gramaticales

### **MES 7: CONTENIDO CULTURAL**
- **Semana 1-2**: Historia, arte y literatura italiana
- **Semana 3-4**: Gastronomía y geografía italiana

### **MES 8: REELS Y AUDIOLIBROS**
- **Semana 1-2**: Sistema de reels educativos
- **Semana 3-4**: Sistema de audiolibros con transcripciones

### **MES 9: MAPA DE APRENDIZAJE VISUAL**
- **Semana 1-2**: Implementación del mapa visual
- **Semana 3-4**: Navegación y estados del mapa

### **MES 10: SISTEMA RESPONSIVE**
- **Semana 1-2**: Implementación del widget responsive
- **Semana 3-4**: Adaptación para diferentes dispositivos

### **MES 11: SISTEMA DE FLASHCARDS**
- **Semana 1-2**: Implementación del sistema de repetición espaciada
- **Semana 3-4**: Algoritmo SM-2 y gestión de progreso

### **MES 12: INTEGRACIÓN Y TESTING**
- **Semana 1-2**: Integración de todas las funcionalidades
- **Semana 3-4**: Testing exhaustivo y lanzamiento beta

## 🚀 **Cómo Ejecutar el Proyecto**

### **Prerrequisitos**
- Flutter 3.35.2 o superior
- Dart 3.9 o superior
- Android Studio / VS Code con extensiones Flutter

### **Instalación**
1. Clonar el repositorio:
```bash
git clone <repository-url>
cd dantexxi
```

2. Instalar dependencias:
```bash
flutter pub get
```

3. Ejecutar la aplicación:
```bash
flutter run
```

### **Generación de Código**
Para generar archivos de código (Freezed, Retrofit, etc.):
```bash
flutter packages pub run build_runner build
```

## 🎨 **Diseño y UI/UX**

### **Paleta de Colores**
- **Verde Italiano**: #009246 (Primary)
- **Rojo Italiano**: #CE2B37 (Primary)
- **Blanco Italiano**: #FFFFFF (Primary)
- **Azul Secundario**: #1E88E5
- **Verde Secundario**: #4CAF50

### **Fuentes**
- **Lora**: Para títulos y texto principal
- **Tinos**: Para texto secundario y descripciones

### **Temas**
- **Tema Claro**: Colores vibrantes con sombras sutiles
- **Tema Oscuro**: Versiones suaves para mejor visibilidad
- **Tema Automático**: Se adapta al sistema del dispositivo

## 📱 **Plataformas Soportadas**

- ✅ **Android** (API 21+)
- ✅ **iOS** (12.0+)
- ✅ **Web** (Chrome, Firefox, Safari, Edge)
- ✅ **Windows** (10+)
- ✅ **macOS** (10.14+)
- ✅ **Linux** (Ubuntu 18.04+)

## 🤝 **Contribución**

1. Fork el proyecto
2. Crea una rama para tu feature (`git checkout -b feature/AmazingFeature`)
3. Commit tus cambios (`git commit -m 'Add some AmazingFeature'`)
4. Push a la rama (`git push origin feature/AmazingFeature`)
5. Abre un Pull Request

## 📄 **Licencia**

Este proyecto está bajo la Licencia MIT. Ver el archivo `LICENSE` para más detalles.

## 📞 **Contacto**

- **Desarrollador**: [Tu Nombre]
- **Email**: [tu-email@ejemplo.com]
- **Proyecto**: [https://github.com/usuario/dantexxi](https://github.com/usuario/dantexxi)

## 🙏 **Agradecimientos**

- **Flutter Team** por el framework increíble
- **Bloc Library** por el patrón de state management
- **Comunidad Flutter** por el apoyo continuo
- **Italia** por la inspiración cultural y lingüística

---

**🇮🇹 ¡Aprende italiano de manera moderna y efectiva con DanteXXI! 🚀**
