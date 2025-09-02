# 🎯 **ROADMAP COMPLETO - DANTEXXI APP**

## 📋 **ÍNDICE**

1. [Estado Actual del Proyecto](#estado-actual-del-proyecto)
2. [Funcionalidades Identificadas y Adaptables](#funcionalidades-identificadas-y-adaptables)
3. [Funcionalidades Especificas para Italiano](#funcionalidades-especificas-para-italiano)
4. [Arquitectura y Tecnologias](#arquitectura-y-tecnologias)
5. [Sistema de Reels Educativos](#sistema-de-reels-educativos)
6. [Sistema de Audiolibros](#sistema-de-audiolibros)
7. [Mapa de Aprendizaje Visual](#mapa-de-aprendizaje-visual)
8. [Sistema Responsive Design](#sistema-responsive-design)
9. [Sistema de Ejercicios Interactivos](#sistema-de-ejercicios-interactivos)
10. [Sistema de Flashcards Similar a Anki](#sistema-de-flashcards-similar-a-anki)
11. [Entrenador de Verbos Italianos](#entrenador-de-verbos-italianos)
12. [Splash Screen Inteligente](#splash-screen-inteligente)
13. [Sistema de Gramatica Italiana Completa](#sistema-de-gramatica-italiana-completa)
14. [Sistema de Libros Sin Audio](#sistema-de-libros-sin-audio)
15. [Sistema de Temas y Modo Oscuro](#sistema-de-temas-y-modo-oscuro)
16. [Root App y Navegacion](#root-app-y-navegacion)
17. [Estructura del Proyecto](#estructura-del-proyecto)
18. [Cronograma Detallado](#cronograma-detallado)
19. [Recomendaciones](#recomendaciones)

---

## 🚀 **ESTADO ACTUAL DEL PROYECT**

### ✅ **COMPLETADO (100%)**

#### **1. Arquitectura y Configuración Base:**
- ✅ **Clean Architecture** implementada completamente
- ✅ **Bloc Pattern** con flutter_bloc y equatable
- ✅ **Dependency Injection** con GetIt
- ✅ **Code Generation** con Freezed y json_serializable
- ✅ **HTTP Client** con Dio y Retrofit
- ✅ **Local Storage** con SharedPreferences
- ✅ **Error Handling** y logging implementado
- ✅ **UI Components** con Google Fonts, Shimmer, Cached Network Image

#### **2. Sistema de Autenticación:**
- ✅ **Splash Screen Inteligente** con navegación automática
- ✅ **Login/Registro** con gestión de sesiones
- ✅ **Perfil de usuario** con foto y datos personales
- ✅ **Gestión de sesiones** y tokens de autenticación
- ✅ **Recuperación de contraseña** por email

#### **3. Navegación y Estructura:**
- ✅ **Sistema de rutas personalizado** (RouteGenerator + NavigationService)
- ✅ **Bottom Navigation** adaptativa
- ✅ **Navegación responsive** según tipo de dispositivo
- ✅ **Integración completa** con todas las funcionalidades

#### **4. Sistema de Notificaciones Locales:**
- ✅ **NotificationService** completamente implementado
- ✅ **Notificaciones diarias** de hechos curiosos sobre Italia
- ✅ **Notificaciones aleatorias** con URLs clickeables
- ✅ **Configuración en ProfilePage** con switches y time picker
- ✅ **Notificación de prueba** inmediata
- ✅ **Permisos Android** configurados correctamente

#### **5. Sistema de Reels Educativos:**
- ✅ **API Integration** con endpoint `/reels`
- ✅ **ReelsBloc** para gestión de estado
- ✅ **ReelsStaggeredGrid** con diseño responsive
- ✅ **ReelsStaggeredShimmer** para loading states
- ✅ **Navegación a VideoPlayerPage** con datos completos
- ✅ **Diseño mejorado** sin espacios blancos excesivos

#### **6. Sistema de Audiolibros:**
- ✅ **AudiobooksPage** con diseño moderno y responsive
- ✅ **AudiobookDetailsPage** para mostrar capítulos
- ✅ **AudiobookPlayerPage** con diseño de libro elegante
- ✅ **Sincronización de subtítulos** con audio
- ✅ **Navegación por capítulos** y transcripciones
- ✅ **Integración con JSON** de audiolibros italianos

#### **7. Sistema de Radio Italiana:**
- ✅ **RadioPage** con lista de estaciones italianas
- ✅ **RadioBloc** para gestión de estado de reproducción
- ✅ **MusicPlayerWidget** con controles completos
- ✅ **RadioStationsGrid** con indicadores visuales
- ✅ **Integración con just_audio** para reproducción
- ✅ **13 estaciones italianas** hardcodeadas con URLs

#### **8. Widgets Especializados:**
- ✅ **WordOfDayWidget** con cache diario y shimmer
- ✅ **ItalianHolidayWidget** con detección automática de festivos
- ✅ **NotificationTestWidget** (eliminado del HomePage)
- ✅ **Widgets responsive** con MediaQuery

#### **9. HomePage Mejorada:**
- ✅ **RefreshIndicator** con pull-to-refresh
- ✅ **Botón de refresh** en AppBar
- ✅ **Acciones rápidas** con navegación a todas las secciones
- ✅ **Sección de radio eliminada** del HomePage
- ✅ **Acceso directo a radio** desde acciones rápidas
- ✅ **Estructura limpia** y organizada

#### **10. Sistema de Temas y Colores:**
- ✅ **AppColors** con paleta italiana completa
- ✅ **AppTexts** con textos centralizados
- ✅ **Diseño consistente** en toda la aplicación
- ✅ **Colores responsivos** que se adaptan al contenido

### 🔄 **EN PROGRESO (75%)**

#### **1. Sistema de Ejercicios Interactivos:**
- 🔄 **Estructura base** implementada
- 🔄 **5 tipos de ejercicios** definidos
- 🔄 **JSON de ejercicios** creado
- ⏳ **Integración completa** con UI pendiente
- ⏳ **Sistema de audio** pendiente
- ⏳ **Progreso individual** pendiente

#### **2. Sistema de Diccionario:**
- 🔄 **Estructura de datos** implementada
- 🔄 **JSON de vocabulario** creado
- ⏳ **Búsqueda avanzada** pendiente
- ⏳ **Sistema de favoritos** pendiente
- ⏳ **Información completa** de palabras pendiente

### ⏳ **PENDIENTE (0%)**

#### **1. Mapa de Aprendizaje Visual:**
- ⏳ **CustomPainter** para dibujar conexiones
- ⏳ **Nodos interactivos** para lecciones
- ⏳ **Estados de progreso** visuales
- ⏳ **Navegación intuitiva** por el mapa

#### **2. Sistema de Flashcards Similar a Anki:**
- ⏳ **Sistema de repetición espaciada**
- ⏳ **Algoritmo SM-2** adaptado
- ⏳ **Categorización por tipos gramaticales**
- ⏳ **Progreso individual** por palabra

#### **3. Entrenador de Verbos Italianos:**
- ⏳ **Sistema de conjugación completa**
- ⏳ **Tiempos verbales** específicos
- ⏳ **Ejercicios de conjugación** progresivos
- ⏳ **Feedback inmediato** con explicaciones

#### **4. Sistema de Gramática Italiana Completa:**
- ⏳ **Lecciones estructuradas** por niveles CEFR
- ⏳ **Reglas gramaticales** explicadas
- ⏳ **Ejercicios de aplicación** para cada concepto
- ⏳ **Progreso secuencial** en el aprendizaje

#### **5. Sistema de Libros Sin Audio (Lectura):**
- ⏳ **Biblioteca de textos** italianos
- ⏳ **Ejercicios de comprensión** integrados
- ⏳ **Sistema de lectura progresiva**
- ⏳ **Análisis de texto** interactivo

#### **6. Sistema Responsive Design Avanzado:**
- ⏳ **Widget Responsive** personalizado
- ⏳ **Breakpoints específicos** para dispositivos
- ⏳ **Layouts optimizados** para cada tipo
- ⏳ **Navegación adaptativa** completa

#### **7. Sistema de Temas y Modo Oscuro:**
- ⏳ **Modo claro y oscuro** implementación
- ⏳ **Sistema de temas** personalizables
- ⏳ **Colores responsivos** adaptativos
- ⏳ **Fuentes italianas** elegantes

### 📊 **ESTADÍSTICAS DEL PROYECTO:**

- **Funcionalidades Completadas**: 10/17 (59%)
- **Funcionalidades en Progreso**: 2/17 (12%)
- **Funcionalidades Pendientes**: 5/17 (29%)
- **Progreso General**: ~65%

### 🎯 **PRÓXIMOS PASOS RECOMENDADOS:**

1. **Completar Sistema de Ejercicios** (Prioridad Alta)
2. **Implementar Sistema de Diccionario** (Prioridad Alta)
3. **Desarrollar Mapa de Aprendizaje Visual** (Prioridad Media)
4. **Implementar Sistema de Flashcards** (Prioridad Media)
5. **Crear Entrenador de Verbos** (Prioridad Media)
6. **Desarrollar Sistema de Gramática** (Prioridad Baja)
7. **Implementar Modo Oscuro** (Prioridad Baja)

---

## 🔍 **ANÁLISIS DE CICEROXXI - FUNCIONALIDADES ADAPTABLES**

### **Funcionalidades Identificadas y Adaptables:**

#### **1. Sistema de Autenticación:**
- **Login/Registro** con Firebase (adaptar a Golang API)
- **Perfil de usuario** con foto y datos personales
- **Gestión de sesiones** y tokens de autenticación
- **Recuperación de contraseña** por email

#### **2. Sistema de Aprendizaje Interactivo:**
- **Lecciones estructuradas** por niveles CEFR
- **Sistema de progreso** individual por usuario
- **Evaluación continua** del aprendizaje
- **Certificaciones** por nivel alcanzado

#### **3. Contenido Gramatical:**
- **Reglas gramaticales** explicadas claramente
- **Ejemplos prácticos** en contexto italiano
- **Ejercicios de aplicación** para cada concepto
- **Progreso secuencial** en el aprendizaje

#### **4. Sistema de Diccionario:**
- **Base de datos** de palabras italianas
- **Búsqueda avanzada** con filtros
- **Información completa** de cada palabra
- **Sistema de favoritos** personal

#### **5. Sistema de Ejercicios:**
- **Múltiples tipos** de ejercicios interactivos
- **Audio integrado** para pronunciación
- **Feedback inmediato** con explicaciones
- **Seguimiento de progreso** detallado

#### **6. Contenido Multimedia:**
- **Videos educativos** con subtítulos
- **Audio nativo** italiano para pronunciación
- **Imágenes culturales** de Italia
- **Recursos visuales** para aprendizaje

#### **7. Contenido Cultural:**
- **Historia de Italia** por épocas
- **Arte y literatura** italiana
- **Gastronomía** regional italiana
- **Tradiciones** y costumbres italianas

#### **8. Sistema de Evaluación:**
- **Tests de nivel** iniciales
- **Evaluaciones continuas** del progreso
- **Reportes detallados** de rendimiento
- **Recomendaciones** personalizadas

#### **9. Interfaz Responsive:**
- **Adaptación automática** a diferentes dispositivos
- **Navegación intuitiva** en móvil y desktop
- **Diseño optimizado** para cada pantalla
- **Experiencia consistente** en todas las plataformas

---

## 🇮🇹 **FUNCIONALIDADES ESPECIFICAS PARA ITALIANO**

### **1. Sistema de Conjugación de Verbos:**
- **500+ verbos italianos** con conjugaciones completas
- **Tiempos verbales** desde A1 hasta C2
- **Verbos irregulares** con patrones especiales
- **Ejercicios de conjugación** progresivos

### **2. Sistema de Pronunciación:**
- **Audio nativo** italiano para todas las palabras
- **Ejercicios de pronunciación** con grabación del usuario
- **Comparación** con pronunciación nativa
- **Feedback inmediato** de la pronunciación

### **3. Contenido Cultural Italiano:**
- **Historia de Italia** desde la antigüedad hasta hoy
- **Literatura italiana** con fragmentos adaptados
- **Arte italiano** con explicaciones culturales
- **Gastronomía italiana** con recetas y vocabulario

### **4. Niveles CEFR Específicos:**
- **A1-A2**: Italiano básico para principiantes
- **B1-B2**: Italiano intermedio para conversación
- **C1-C2**: Italiano avanzado para dominio completo

### **5. Ejercicios Específicos para Italiano:**
- **Ejercicios de género** y número de sustantivos
- **Práctica de artículos** definidos e indefinidos
- **Ejercicios de preposiciones** con casos regidos
- **Práctica de expresiones** idiomáticas italianas

---

## 🏗️ **ARQUITECTURA Y TECNOLOGIAS**

### **Stack Tecnológico:**
- **Frontend**: Flutter 3.35.2 con Dart 3.9 
- **State Management**: flutter_bloc + equatable
- **Dependency Injection**: GetIt
- **Code Generation**: Freezed + json_serializable
- **Navigation**: Sistema de rutas personalizado (RouteGenerator + NavigationService)
- **HTTP Client**: Dio + Retrofit
- **Local Storage**: Shared Preferences + Hive
- **Error Monitoring**: Sentry
- **Logging**: Logger
- **UI Components**: Google Fonts, Shimmer, Cached Network Image
- **Audio/Video**: Just Audio, Video Player
- **Backend**: Golang + PostgreSQL (Supabase, Render)

### **Arquitectura Clean:**
- **Domain Layer**: Entities, Use Cases, Repositories
- **Data Layer**: Data Sources, Repositories Implementation
- **Presentation Layer**: Pages, Widgets, Blocs
- **Infrastructure**: Services, Utils, Routes

### **Estrategia de Almacenamiento Híbrida:**

#### **Datos Locales (JSON Assets):**
- **Vocabulario base** (15,000+ palabras italianas)
- **Conjugaciones completas** de verbos regulares e irregulares
- **Reglas gramaticales** fundamentales
- **Contenido de lecciones** estático
- **Ejercicios básicos** y plantillas
- **Recursos multimedia** (imágenes, audio básico)

#### **Datos Dinámicos (Golang API + PostgreSQL):**
- **Progreso del usuario** y estadísticas
- **Favoritos y listas** personalizadas
- **Reels educativos** y contenido dinámico
- **Audiolibros** y transcripciones
- **Ejercicios personalizados** basados en progreso
- **Contenido cultural** actualizado
- **Datos de usuario** y preferencias
- **Analytics** y métricas de aprendizaje

---

## 🎬 **SISTEMA DE REELS EDUCATIVOS**

### **Características Principales:**
- **Videos Cortos** (15-60 segundos) con ejercicios integrados
- **Subtítulos Sincronizados** en italiano y español
- **Ejercicios Interactivos** durante la reproducción
- **Categorización por Nivel** y tema gramatical
- **Sistema de Recomendaciones** personalizado

### **Tipos de Reels:**

#### **1. Reels Gramaticales:**
- **Explicación de reglas** con ejemplos visuales
- **Uso de tiempos verbales** en contexto
- **Concordancia** de género y número
- **Preposiciones** y casos regidos

#### **2. Reels de Vocabulario:**
- **Palabras nuevas** con pronunciación nativa
- **Expresiones idiomáticas** en situaciones reales
- **Sinónimos y antónimos** con ejemplos
- **Familia de palabras** relacionadas

#### **3. Reels Culturales:**
- **Historia italiana** en formato visual
- **Tradiciones** y costumbres italianas
- **Gastronomía** con vocabulario específico
- **Arte y literatura** italiana

### **Funcionalidades Técnicas:**

#### **1. Reproducción de Video:**
- **Control de reproducción** personalizado
- **Velocidad ajustable** (0.5x - 2x)
- **Subtítulos configurables** (italiano/español)
- **Calidad adaptativa** según conexión

#### **2. Ejercicios Integrados:**
- **Preguntas durante** la reproducción
- **Pausa automática** para ejercicios
- **Feedback inmediato** con explicaciones
- **Puntuación en tiempo real**

#### **3. Sistema de Recomendaciones:**
- **Algoritmo inteligente** basado en progreso
- **Filtros por nivel** y categoría
- **Historial de visualización** del usuario
- **Sugerencias personalizadas** continuas

---

## 📚 **SISTEMA DE AUDIOLIBROS**

### **Características Principales:**
- **Libros en Audio** narrados por hablantes nativos
- **Transcripciones Sincronizadas** con el audio
- **Ejercicios de Comprensión** integrados
- **Sistema de Marcadores** y notas
- **Progreso de Escucha** individual

### **Tipos de Contenido:**

#### **1. Literatura Italiana:**
- **Clásicos adaptados** por nivel CEFR
- **Autores contemporáneos** italianos
- **Cuentos populares** tradicionales
- **Poesía italiana** recitada

#### **2. Contenido Educativo:**
- **Historias culturales** de Italia
- **Biografías** de personajes italianos importantes
- **Descripciones** de lugares y monumentos
- **Conversaciones** en situaciones reales

### **Funcionalidades del Reproductor:**

#### **1. Control de Audio:**
- **Velocidad ajustable** (0.5x - 2x)
- **Control de volumen** individual
- **Pausa y reanudación** automática
- **Navegación por capítulos** y secciones

#### **2. Transcripciones:**
- **Texto sincronizado** con el audio
- **Resaltado** de la palabra actual
- **Búsqueda en transcripción** por palabra
- **Traducción** de términos difíciles

#### **3. Ejercicios de Comprensión:**
- **Preguntas durante** la escucha
- **Pausa automática** para ejercicios
- **Evaluación continua** del entendimiento
- **Recomendaciones** de repaso

---

## 🗺️ **MAPA DE APRENDIZAJE VISUAL**

### **Características Principales:**
- **Representación Visual** del progreso de aprendizaje
- **Nodos Interactivos** para cada lección
- **Conexiones Visuales** entre lecciones relacionadas
- **Estados de Progreso** claramente visibles
- **Navegación Intuitiva** por el mapa

### **Componentes del Mapa:**

#### **1. Nodos de Aprendizaje:**
- **Lecciones individuales** representadas como nodos
- **Estados visuales** (bloqueado, disponible, completado)
- **Información de progreso** en cada nodo
- **Navegación directa** al hacer clic

#### **2. Conexiones y Rutas:**
- **Líneas de conexión** entre lecciones relacionadas
- **Rutas de aprendizaje** sugeridas
- **Dependencias** entre lecciones
- **Caminos alternativos** de aprendizaje

#### **3. Indicadores de Progreso:**
- **Porcentaje completado** por sección
- **Nivel de dificultad** de cada lección
- **Tiempo estimado** para completar
- **Recomendaciones** de siguiente paso

### **Funcionalidades Técnicas:**

#### **1. Renderizado del Mapa:**
- **CustomPainter** para dibujar conexiones
- **Posicionamiento dinámico** de nodos
- **Zoom y pan** para navegación
- **Responsive design** para diferentes pantallas

#### **2. Interactividad:**
- **Gestos táctiles** para navegación
- **Animaciones fluidas** entre estados
- **Feedback visual** inmediato
- **Navegación por teclado** opcional

#### **3. Integración con Datos:**
- **Sincronización** con progreso del usuario
- **Actualización en tiempo real** del estado
- **Persistencia** de posiciones y estados
- **Sincronización** con backend

---

## 📱 **SISTEMA RESPONSIVE DESIGN**

### **Características Principales:**
- **Adaptación Automática** a diferentes tamaños de pantalla
- **Breakpoints Definidos** para dispositivos específicos
- **Layouts Optimizados** para cada tipo de dispositivo
- **Navegación Adaptativa** según el contexto
- **Experiencia Consistente** en todas las plataformas

### **Breakpoints del Sistema:**

#### **1. Mobile (≤500px):**
- **Navegación inferior** con bottom navigation bar
- **Layout vertical** optimizado para scroll
- **Elementos apilados** verticalmente
- **Navegación por gestos** táctiles
- **Optimización** para pantallas pequeñas

#### **2. Large Mobile (500px - 700px):**
- **Navegación híbrida** (inferior + superior)
- **Layout semi-horizontal** para elementos
- **Grid de 2 columnas** para contenido
- **Navegación táctil** mejorada
- **Balance** entre móvil y tablet

#### **3. Tablet (700px - 1080px):**
- **Navegación lateral** con drawer
- **Layout de 2-3 columnas** para contenido
- **Sidebar** para navegación secundaria
- **Elementos más grandes** para mejor usabilidad
- **Optimización** para pantallas medianas

#### **4. Desktop (1080px - 1400px):**
- **Navegación superior** completa
- **Layout de 3-4 columnas** para contenido
- **Sidebar fijo** para navegación
- **Elementos de tamaño estándar** desktop
- **Navegación por teclado** completa

#### **5. Extra Large Screen (≥1400px):**
- **Layout de 4+ columnas** para contenido
- **Navegación expandida** con más opciones
- **Elementos más grandes** para pantallas grandes
- **Optimización** para monitores de alta resolución
- **Experiencia premium** para usuarios desktop

### **Widget Responsive:**

#### **1. Implementación Técnica:**
- **Widget Responsive** personalizado
- **MediaQuery** para detección de tamaño
- **LayoutBuilder** para construcción dinámica
- **Flexible y Expanded** para distribución
- **AspectRatio** para proporciones consistentes

#### **2. Características del Widget:**
- **Detección automática** del tipo de dispositivo
- **Renderizado condicional** según breakpoint
- **Transiciones suaves** entre layouts
- **Optimización de performance** por dispositivo
- **Fallbacks** para dispositivos no soportados

### **Características por Tipo de Dispositivo:**

#### **1. Mobile:**
- **Touch-first design** con gestos intuitivos
- **Navegación simplificada** con acceso rápido
- **Contenido prioritizado** por importancia
- **Optimización** para uso con una mano
- **Navegación por swipe** entre secciones

#### **2. Tablet:**
- **Dual-pane layout** para mejor productividad
- **Navegación contextual** según el contenido
- **Gestos avanzados** para navegación
- **Optimización** para uso horizontal y vertical
- **Navegación por stylus** opcional

#### **3. Desktop:**
- **Keyboard navigation** completa
- **Shortcuts** para acciones frecuentes
- **Multi-window support** para contenido
- **Drag and drop** para interacciones
- **Navegación por mouse** optimizada

---

## 🎯 **SISTEMA DE EJERCICIOS INTERACTIVOS**

### **Características Principales:**
- **5 Tipos de Ejercicios** diferentes y especializados
- **Sistema de Audio** integrado para feedback
- **Progreso Individual** por tipo de ejercicio
- **Dificultad Adaptativa** según rendimiento
- **Integración Completa** con otros sistemas

### **Tipos de Ejercicios Disponibles:**

#### **1. Multiple Choice (Opción Múltiple):**
- **Preguntas con 4 opciones** de respuesta
- **Audio de pregunta** opcional
- **Explicación** de la respuesta correcta
- **Feedback inmediato** con sonidos
- **Progreso visual** del ejercicio

#### **2. Translation Exercise (Ejercicio de Traducción):**
- **Traducción bidireccional** (español ↔ italiano)
- **Múltiples respuestas** correctas posibles
- **Validación inteligente** de respuestas
- **Sugerencias** para respuestas incorrectas
- **Contexto cultural** de la traducción

#### **3. Fill in the Blank (Completar Espacios):**
- **Espacios en blanco** en frases italianas
- **Opciones múltiples** para cada espacio
- **Validación contextual** de respuestas
- **Explicación gramatical** de la respuesta
- **Dificultad progresiva** por nivel

#### **4. Matching Pairs (Emparejar Pares):**
- **Elementos relacionados** para emparejar
- **Validación visual** de emparejamientos
- **Feedback inmediato** de cada par
- **Explicación** de las relaciones
- **Dificultad ajustable** por número de pares

#### **5. What Exercise Is (Identificación de Tipo):**
- **Identificación del tipo** de ejercicio
- **Enrutamiento inteligente** al ejercicio correcto
- **Validación** de la selección
- **Explicación** del tipo de ejercicio
- **Navegación fluida** entre ejercicios

### **Características Técnicas Comunes:**

#### **1. Sistema de Audio:**
- **Sonidos de respuesta** correcta/incorrecta
- **Audio de preguntas** en italiano
- **Control de volumen** individual
- **Reproducción automática** configurable
- **Fallback** para dispositivos sin audio

#### **2. Sistema de Progreso:**
- **Contador de ejercicios** completados
- **Porcentaje de éxito** por sesión
- **Historial de respuestas** del usuario
- **Recomendaciones** de repaso
- **Sincronización** con progreso general

#### **3. Sistema de Validación:**
- **Validación en tiempo real** de respuestas
- **Múltiples respuestas** correctas posibles
- **Tolerancia a errores** de escritura
- **Sugerencias inteligentes** para respuestas
- **Explicaciones detalladas** de errores

### **Estructura de Datos JSON:**

#### **1. GrammarExercise (Contenedor Principal):**
- **Metadatos** del ejercicio (título, descripción, nivel)
- **Lista de Questions** con diferentes tipos
- **Configuración** de audio y sonidos
- **Configuración** de tiempo y dificultad
- **Metadatos** de progreso y estadísticas

#### **2. Question (Pregunta Individual):**
- **exerciseType**: Tipo específico de ejercicio
- **question**: Texto de la pregunta
- **sound**: Audio opcional de la pregunta
- **options**: Opciones para multiple choice/fill in blank
- **wordOptions**: Opciones para ejercicios de traducción
- **correctAnswer**: Respuesta correcta única
- **correctAnswerList**: Lista de respuestas correctas
- **correctPairs**: Pares correctos para matching
- **pairOptions**: Opciones de pares disponibles
- **soundCorrectAnswer**: Sonido de respuesta correcta
- **soundWrongAnswer**: Sonido de respuesta incorrecta

#### **3. Configuración de Audio:**
- **Sonidos de feedback** configurables
- **Volumen por defecto** ajustable
- **Reproducción automática** opcional
- **Fallbacks** para dispositivos sin audio
- **Optimización** de archivos de audio

---

## 🃏 **SISTEMA DE FLASHCARDS SIMILAR A ANKI**

### **Características Principales:**
- **Sistema de Repetición Espaciada** (Spaced Repetition System)
- **Algoritmo SM-2** adaptado para aprendizaje de idiomas
- **Categorización por Tipos Gramaticales** italianos
- **Progreso Individual** por palabra/verbo
- **Sistema de Calidad** (1-5) para evaluar dificultad

### **Tipos de Flashcards Disponibles:**

#### **1. Categorías Gramaticales:**
- **Adjetivos** (Aggettivi) con declinaciones
- **Adverbios** (Avverbi) con comparativos y superlativos
- **Conjunciones** (Congiunzioni) coordinantes y subordinantes
- **Interjecciones** (Interiezioni) expresivas
- **Sustantivos** (Sostantivi) con género y número
- **Preposiciones** (Preposizioni) con casos regidos
- **Verbos** (Verbi) con conjugaciones completas

#### **2. Sistema de Repetición Espaciada:**
- **Factor de Facilidad** (Easiness Factor): 1.3 - 2.5
- **Intervalos Progresivos** basados en rendimiento
- **Calidad de Respuesta** (1-5) para evaluar dificultad
- **Cálculo de Intervalos** optimizado para idiomas
- **Reinicio inteligente** para palabras olvidadas

---

## 🔤 **ENTRENADOR DE VERBOS ITALIANOS**

### **Características Principales:**
- **Entrenamiento por Tiempo Verbal** específico
- **Sistema de Conjugación Completa** para cada verbo
- **Práctica Progresiva** desde tiempos simples a complejos
- **Feedback Inmediato** con explicaciones gramaticales

### **Tiempos Verbales Disponibles:**
- **Indicativo**: Presente, Imperfecto, Passato Prossimo, Passato Remoto, Futuro
- **Congiuntivo**: Presente, Imperfecto, Passato, Trapassato
- **Condicional**: Presente, Passato
- **Imperativo**: Presente, Futuro

### **Tipos de Ejercicios:**
- **Ejercicios de Conjugación** con pronombres personales
- **Ejercicios de Uso** en contexto
- **Ejercicios de Contexto** con situaciones reales
- **Sistema de Progreso** por tiempo verbal

---

## 🚀 **SPLASH SCREEN INTELIGENTE**

### **Características Principales:**
- **Pantalla de Inicio Inteligente** que decide la navegación
- **Detección Automática** del estado de autenticación
- **Animación de Carga** con branding de la app
- **Redirección Inteligente** según el estado del usuario

### **Lógica de Navegación:**
- **Primera Vez**: Redirigir a registro después de 3-5 segundos
- **Usuario Registrado**: Verificar token y redirigir a home o login
- **Usuario Anónimo**: Mostrar opciones de login/registro

### **Componentes del Splash:**
- **Branding Visual** con logo de DanteXXI
- **Animación de Carga** estilizada
- **Información de Estado** del proceso de carga
- **Verificación de Estado** y preparación de recursos

---

## 📖 **SISTEMA DE GRAMATICA ITALIANA COMPLETA**

### **Características Principales:**
- **Gramática Estructurada** por niveles CEFR
- **Lecciones Interactivas** con ejemplos prácticos
- **Reglas Gramaticales** explicadas claramente
- **Ejercicios de Aplicación** para cada concepto

### **Categorías Gramaticales:**
- **Morfología**: Sustantivos, adjetivos, artículos, pronombres, adverbios
- **Sintaxis**: Estructura de oraciones, concordancia, orden de palabras
- **Verbos y Conjugaciones**: Tiempos verbales, auxiliares, formas no personales
- **Conectores y Estructuras**: Conjunciones, preposiciones, expresiones temporales

---

## 📚 **SISTEMA DE LIBROS SIN AUDIO (LECTURA)**

### **Características Principales:**
- **Biblioteca de Textos** italianos por niveles CEFR
- **Ejercicios de Comprensión** integrados en cada texto
- **Sistema de Lectura Progresiva** desde A1 hasta C2
- **Análisis de Texto** con herramientas interactivas

### **Tipos de Contenido:**
- **Literatura Italiana**: Clásicos, contemporáneos, poesía, teatro
- **Textos Informativos**: Artículos, académicos, históricos, científicos
- **Contenido Cultural**: Historia, arte, gastronomía, tradiciones

---

## 🌙 **SISTEMA DE TEMAS Y MODO OSCURO**

### **Características Principales:**
- **Modo Claro y Oscuro** completamente implementados
- **Sistema de Temas** personalizables
- **Colores Responsivos** que se adaptan al contenido
- **Fuentes Italianas** elegantes y legibles

### **Modo Claro:**
- **Paleta de Colores**: Azul, verde y rojo italianos
- **Elementos de Interfaz**: AppBar blanco, tarjetas con sombras sutiles
- **Tipografía**: Google Fonts "Lora" y "Tinos"

### **Modo Oscuro:**
- **Paleta de Colores**: Versiones suaves para mejor visibilidad
- **Adaptaciones Especiales**: Contraste optimizado, colores de estado adaptados
- **Experiencia Consistente**: Mantiene claridad y usabilidad

---

## 🏠 **ROOT APP Y NAVEGACION**

### **Características Principales:**
- **Aplicación Principal** con navegación adaptativa
- **Sistema de Rutas Personalizado** (RouteGenerator + NavigationService)
- **Navegación Responsive** según tipo de dispositivo
- **Integración Completa** con todas las funcionalidades

### **Sistema de Navegación:**
- **RouteGenerator**: Generación inteligente de rutas
- **NavigationService**: Servicio centralizado de navegación
- **RoutingData**: Estructura de datos para rutas y parámetros
- **StringExtensions**: Extensiones para parsing de URLs

### **Estructura de Navegación:**
- **Rutas Principales**: Home, Lecciones, Diccionario, Ejercicios
- **Rutas Secundarias**: Perfil, Configuración, Ayuda
- **Rutas Dinámicas**: Lecciones específicas, ejercicios individuales
- **Navegación Anidada**: Subsecciones y contenido relacionado

---

## 📁 **ESTRUCTURA DEL PROYECTO**

### **Organización de Carpetas:**
```
lib/
├── domain/          # Lógica de negocio
├── data/            # Capa de datos
├── presentation/    # Interfaz de usuario
├── core/            # Utilidades y servicios
├── di/              # Inyección de dependencias
└── routes/          # Sistema de navegación
```

### **Arquitectura Clean:**
- **Domain Layer**: Entities, Use Cases, Repositories
- **Data Layer**: Data Sources, Repositories Implementation
- **Presentation Layer**: Pages, Widgets, Blocs
- **Infrastructure**: Services, Utils, Routes

---

## 📅 **CRONOGRAMA DETALLADO**

### **MES 1: FUNDAMENTOS Y ARQUITECTURA** ✅ **COMPLETADO**
- **Semana 1-2**: Configuración del proyecto, Clean Architecture
- **Semana 3-4**: Implementación de Bloc Pattern, GetIt, Freezed

### **MES 2: AUTENTICACIÓN Y PERFIL** ✅ **COMPLETADO**
- **Semana 1-2**: Sistema de autenticación con Golang API
- **Semana 3-4**: Perfil de usuario y gestión de datos

### **MES 3: SISTEMA DE LECCIONES** ⏳ **PENDIENTE**
- **Semana 1-2**: Estructura de lecciones y progreso
- **Semana 3-4**: Sistema de niveles CEFR

### **MES 4: DICCIONARIO Y VOCABULARIO** 🔄 **EN PROGRESO**
- **Semana 1-2**: Base de datos de palabras italianas
- **Semana 3-4**: Funcionalidades de búsqueda y favoritos

### **MES 5: EJERCICIOS INTERACTIVOS** 🔄 **EN PROGRESO**
- **Semana 1-2**: Implementación de tipos de ejercicios
- **Semana 3-4**: Sistema de audio y feedback

### **MES 6: GRAMÁTICA ITALIANA** ⏳ **PENDIENTE**
- **Semana 1-2**: Sistema de conjugación de verbos
- **Semana 3-4**: Tablas de declinación y reglas gramaticales

### **MES 7: CONTENIDO CULTURAL** ✅ **COMPLETADO**
- **Semana 1-2**: Historia, arte y literatura italiana
- **Semana 3-4**: Gastronomía y geografía italiana

### **MES 8: REELS Y AUDIOLIBROS** ✅ **COMPLETADO**
- **Semana 1-2**: Sistema de reels educativos
- **Semana 3-4**: Sistema de audiolibros con transcripciones

### **MES 9: MAPA DE APRENDIZAJE VISUAL** ⏳ **PENDIENTE**
- **Semana 1-2**: Implementación del mapa visual
- **Semana 3-4**: Navegación y estados del mapa

### **MES 10: SISTEMA RESPONSIVE** 🔄 **EN PROGRESO**
- **Semana 1-2**: Implementación del widget responsive
- **Semana 3-4**: Adaptación para diferentes dispositivos

### **MES 11: SISTEMA DE FLASHCARDS** ⏳ **PENDIENTE**
- **Semana 1-2**: Implementación del sistema de repetición espaciada
- **Semana 3-4**: Algoritmo SM-2 y gestión de progreso

### **MES 12: INTEGRACIÓN Y TESTING** ⏳ **PENDIENTE**
- **Semana 1-2**: Integración de todas las funcionalidades
- **Semana 3-4**: Testing exhaustivo y lanzamiento beta

---

## 🎯 **RECOMENDACIONES**

### **Técnicas:**
- **Implementar lazy loading** para optimizar rendimiento
- **Usar caching inteligente** para datos frecuentemente accedidos
- **Implementar offline-first** para mejor experiencia de usuario
- **Optimizar imágenes** y recursos multimedia
- **Usar compresión** para datos JSON y audio

### **UX/UI:**
- **Diseño intuitivo** basado en patrones de iOS/Android
- **Animaciones fluidas** para transiciones
- **Feedback inmediato** para todas las acciones
- **Accesibilidad** para usuarios con necesidades especiales
- **Modo oscuro** opcional

### **Performance:**
- **Lazy loading** de imágenes y contenido
- **Caching inteligente** de datos
- **Optimización de consultas** a la base de datos
- **Compresión de assets** multimedia
- **Background processing** para tareas pesadas

---

## 🏁 **CONCLUSIONES**

El roadmap de DanteXXI representa una aplicación de aprendizaje de italiano **completamente integral** que combina:

- **Funcionalidades probadas** de CiceroXXI adaptadas al italiano
- **Arquitectura moderna** con Clean Architecture y Bloc Pattern
- **Sistema responsive** que funciona en todos los dispositivos
- **Ejercicios interactivos** variados y atractivos
- **Sistema de flashcards** similar a Anki con repetición espaciada
- **Entrenador de verbos** completo por tiempo verbal
- **Splash screen inteligente** con navegación automática
- **Sistema de gramática** estructurado por niveles CEFR
- **Libros sin audio** para práctica de lectura
- **Modo oscuro** con sistema de temas personalizable
- **Root app** con navegación adaptativa
- **Contenido cultural** rico y auténtico
- **Tecnologías de vanguardia** para mejor rendimiento

La aplicación está diseñada para ser **escalable, mantenible y centrada en el usuario**, proporcionando una experiencia de aprendizaje de italiano de **clase mundial**.

### **Estado Actual: 65% Completado** 🎉

**Próximos pasos prioritarios:**
1. Completar Sistema de Ejercicios Interactivos
2. Finalizar Sistema de Diccionario
3. Implementar Mapa de Aprendizaje Visual
4. Desarrollar Sistema de Flashcards
5. Crear Entrenador de Verbos Italianos
