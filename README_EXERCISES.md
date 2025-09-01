# 🎯 Sistema de Ejercicios de DanteXXI

## 📋 Descripción General

Este sistema implementa **5 tipos diferentes de ejercicios** interactivos, cada uno con su propio widget especializado, exactamente como en CiceroXXI. Cada tipo tiene un diseño único y funcionalidades específicas.

## 🚀 Tipos de Ejercicios Implementados

### 1. **Multiple Choice** (`multiple_choice`)
- **Widget**: `MultipleChoiceWidget`
- **Archivo**: `assets/curso/3.json`
- **Características**: 
  - Pregunta con opciones de respuesta
  - Etiqueta "NUEVA PALABRA" en púrpura
  - 3 vidas (corazones rojos)
  - Botones de navegación

### 2. **Multiple Choice Alternativo** (`multiple_choice_alt`)
- **Widget**: `MultipleChoiceAltWidget`
- **Archivo**: `assets/curso/4.json`
- **Características**:
  - Personaje emoji 👦 con globo de chat
  - Barra de progreso y 2 vidas
  - Diseño más visual y atractivo
  - Instrucción "Selecciona el significado correcto"

### 3. **Completar Espacios** (`fill_in_the_blank`)
- **Widget**: `FillInTheBlankWidget`
- **Archivo**: `assets/curso/5.json`
- **Características**:
  - Barra de progreso y 2 vidas
  - Título "COMPLETAR EL ESPACIO"
  - Opciones para llenar el espacio en blanco
  - Botones de navegación

### 4. **Emparejar Palabras** (`matching_pairs`)
- **Widget**: `MatchingPairsWidget`
- **Archivo**: `assets/curso/6.json`
- **Características**:
  - Dos columnas de palabras para emparejar
  - Barra de progreso y 3 vidas
  - Sistema de emparejamiento interactivo
  - Colores para palabras seleccionadas y emparejadas

### 5. **Traducción** (`translation`)
- **Widget**: `TranslationWidget`
- **Archivo**: `assets/curso/7.json`
- **Características**:
  - Personaje con globo de chat azul
  - Palabras seleccionables para formar la traducción
  - Etiqueta "NUEVA PALABRA" en púrpura
  - Botón de volumen para escuchar la pregunta

## 📁 Estructura de Archivos

```
lib/presentation/widgets/exercises/
├── multiple_choice_widget.dart
├── multiple_choice_alt_widget.dart
├── fill_in_the_blank_widget.dart
├── matching_pairs_widget.dart
└── translation_widget.dart

assets/curso/
├── 1.json (Saluti e Presentazioni - multiple_choice + translation)
├── 2.json (Lección Intermedia - fill_in_the_blank + matching_pairs)
├── 3.json (Multiple Choice)
├── 4.json (Multiple Choice Alt)
├── 5.json (Fill in the Blank)
├── 6.json (Matching Pairs)
├── 7.json (Translation)
└── 8.json (Test All Types - todos los tipos)
```

## 🔧 Cómo Usar

### 1. **Configurar el SplashView**
El `SplashView` determina qué archivo JSON cargar basándose en el ID de la lección:

```dart
switch (widget.id) {
  case 1: jsonPath = 'assets/curso/1.json';
  case 2: jsonPath = 'assets/curso/2.json';
  case 3: jsonPath = 'assets/curso/3.json';
  case 4: jsonPath = 'assets/curso/4.json';
  case 5: jsonPath = 'assets/curso/5.json';
  case 6: jsonPath = 'assets/curso/6.json';
  case 7: jsonPath = 'assets/curso/7.json';
  case 8: jsonPath = 'assets/curso/8.json';
}
```

### 2. **Estructura JSON de Ejercicios**
Cada archivo JSON debe seguir esta estructura:

```json
{
  "title": "Título de la Lección",
  "content": [
    {
      "exerciseType": "tipo_de_ejercicio",
      "question": "Pregunta del ejercicio",
      "sound": "ruta_del_audio.mp3",
      "options": ["opción1", "opción2", "opción3", "opción4"],
      "correctAnswer": "respuesta_correcta",
      "soundWrongAnswer": "wrong.mp3",
      "soundCorrectAnswer": "correct.mp3"
    }
  ]
}
```

### 3. **Tipos de Ejercicios y Campos Requeridos**

#### **Multiple Choice**
```json
{
  "exerciseType": "multiple_choice",
  "question": "Pregunta",
  "options": ["opción1", "opción2", "opción3", "opción4"],
  "correctAnswer": "opción1"
}
```

#### **Multiple Choice Alternativo**
```json
{
  "exerciseType": "multiple_choice_alt",
  "question": "Pregunta",
  "options": ["opción1", "opción2", "opción3", "opción4"],
  "correctAnswer": "opción1"
}
```

#### **Completar Espacios**
```json
{
  "exerciseType": "fill_in_the_blank",
  "question": "Pregunta con _____ espacio",
  "options": ["opción1", "opción2", "opción3", "opción4"],
  "correctAnswer": "opción1"
}
```

#### **Emparejar Palabras**
```json
{
  "exerciseType": "matching_pairs",
  "question": "Instrucción",
  "options": [
    {"left": "palabra1", "right": "traducción1"},
    {"left": "palabra2", "right": "traducción2"}
  ],
  "correctPairs": [
    {"left": "palabra1", "right": "traducción1"},
    {"left": "palabra2", "right": "traducción2"}
  ]
}
```

#### **Traducción**
```json
{
  "exerciseType": "translation",
  "question": "Texto a traducir",
  "wordOptions": ["palabra1", "palabra2", "palabra3"],
  "correctAnswer": ["palabra1", "palabra2"]
}
```

## 🎮 Funcionalidades Comunes

### **Sistema de Vidas**
- Cada widget tiene un sistema de vidas (corazones rojos)
- Las vidas se pierden al responder incorrectamente
- Game over cuando se pierden todas las vidas

### **Audio**
- Soporte para sonidos de pregunta
- Sonidos de respuesta correcta/incorrecta
- Botón de volumen en algunos widgets

### **Navegación**
- Botón "Anterior" para volver a la pregunta previa
- Botón "Siguiente" para continuar
- Botón "Finalizar" en la última pregunta
- Integración con `LessonService` para completar lecciones

### **Estados Visuales**
- Colores para respuestas correctas (verde) e incorrectas (rojo)
- Estados de selección y resultado
- Indicadores de progreso
- Diseños responsivos y atractivos

## 🚀 Próximos Pasos

1. **Crear archivos de audio** en `assets/audio/`:
   - `splash.mp3` - Sonido de carga
   - `correct.mp3` - Sonido de respuesta correcta
   - `wrong.mp3` - Sonido de respuesta incorrecta

2. **Personalizar ejercicios** modificando los archivos JSON

3. **Integrar con API de Golang** para guardar progreso

4. **Agregar más tipos de ejercicios** según sea necesario

## 🔍 Pruebas

Para probar todos los tipos de ejercicios, usa el ID 8 en el `SplashView`:
```dart
Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => SplashView(id: 8, title: "Prueba Completa"),
  ),
);
```

Esto cargará `8.json` que incluye un ejemplo de cada tipo de ejercicio.

## 🎯 Ventajas de la Nueva Estructura

### **Más Intuitivo:**
- **ID 1** → `1.json` ✅
- **ID 2** → `2.json` ✅
- **ID 3** → `3.json` ✅

### **Fácil de Mantener:**
- Cada lección tiene su archivo numerado
- Fácil identificar qué archivo corresponde a qué lección
- Estructura clara y organizada

### **Escalable:**
- Fácil agregar nuevas lecciones (9.json, 10.json, etc.)
- Nomenclatura consistente
- Sin confusión sobre qué archivo usar
