import 'dart:convert';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WordOfDayService {
  static const String _wordOfDayKey = 'word_of_day';
  static const String _creationDateKey = 'word_creation_date';
  static const String _expirationDateKey = 'word_expiration_date';

  // Lista de archivos JSON del diccionario que se usan
  static const List<String> _dictionaryFiles = [
    'assets/dictionary/nouns.json',
    'assets/dictionary/verbs.json',
    'assets/dictionary/adjectives.json',
    'assets/dictionary/adverbs.json',
    'assets/dictionary/prepositions.json',
    'assets/dictionary/conjunctions.json',
    'assets/dictionary/interjections.json',
  ];

  // Modelo para la palabra del día
  static Map<String, dynamic>? _cachedWord;
  static DateTime? _cachedCreationDate;
  static DateTime? _cachedExpirationDate;

  /// Obtiene la palabra del día, ya sea desde cache o generando una nueva
  static Future<Map<String, dynamic>?> getWordOfDay() async {
    final prefs = await SharedPreferences.getInstance();

    // Verificar si ya tenemos una palabra cacheada para hoy
    final creationDateString = prefs.getString(_creationDateKey);
    final expirationDateString = prefs.getString(_expirationDateKey);
    final wordJson = prefs.getString(_wordOfDayKey);

    if (creationDateString != null &&
        expirationDateString != null &&
        wordJson != null) {
      final creationDate = DateTime.parse(creationDateString);
      final expirationDate = DateTime.parse(expirationDateString);
      final now = DateTime.now();

      // Si la palabra no ha expirado, usarla
      if (now.isBefore(expirationDate)) {
        _cachedWord = jsonDecode(wordJson);
        _cachedCreationDate = creationDate;
        _cachedExpirationDate = expirationDate;
        return _cachedWord;
      }
    }

    // Si no hay palabra válida, generar una nueva
    return await _generateNewWordOfDay();
  }

  /// Genera una nueva palabra del día
  static Future<Map<String, dynamic>?> _generateNewWordOfDay() async {
    try {
      // Cargar todas las palabras de todos los archivos
      final allWords = <Map<String, dynamic>>[];

      for (final filePath in _dictionaryFiles) {
        try {
          final jsonString = await rootBundle.loadString(filePath);
          final jsonData = jsonDecode(jsonString);

          // Extraer la lista de palabras según el tipo de archivo
          String key = '';
          if (filePath.contains('nouns')) {
            key = 'nouns';
          } else if (filePath.contains('verbs'))
            key = 'verbs';
          else if (filePath.contains('adjectives'))
            key = 'adjectives';
          else if (filePath.contains('adverbs'))
            key = 'adverbs';
          else if (filePath.contains('prepositions'))
            key = 'prepositions';
          else if (filePath.contains('conjunctions'))
            key = 'conjunctions';
          else if (filePath.contains('interjections'))
            key = 'interjections';

          if (jsonData[key] != null) {
            allWords.addAll(List<Map<String, dynamic>>.from(jsonData[key]));
          }
        } catch (e) {
          print('Error loading dictionary file $filePath: $e');
        }
      }

      if (allWords.isEmpty) {
        print('No words found in dictionary files');
        return null;
      }

      // Seleccionar una palabra aleatoria
      final random = Random();
      final selectedWord = allWords[random.nextInt(allWords.length)];

      // Calcular fechas
      final now = DateTime.now();
      final creationDate = DateTime(now.year, now.month, now.day);
      final expirationDate = creationDate.add(const Duration(days: 1));

      // Guardar en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_wordOfDayKey, jsonEncode(selectedWord));
      await prefs.setString(_creationDateKey, creationDate.toIso8601String());
      await prefs.setString(
        _expirationDateKey,
        expirationDate.toIso8601String(),
      );

      // Actualizar cache
      _cachedWord = selectedWord;
      _cachedCreationDate = creationDate;
      _cachedExpirationDate = expirationDate;

      return selectedWord;
    } catch (e) {
      print('Error generating word of day: $e');
      return null;
    }
  }

  /// Limpia el cache de la palabra del día
  static Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_wordOfDayKey);
    await prefs.remove(_creationDateKey);
    await prefs.remove(_expirationDateKey);

    _cachedWord = null;
    _cachedCreationDate = null;
    _cachedExpirationDate = null;
  }

  /// Obtiene la fecha de creación de la palabra actual
  static DateTime? getCreationDate() {
    return _cachedCreationDate;
  }

  /// Obtiene la fecha de expiración de la palabra actual
  static DateTime? getExpirationDate() {
    return _cachedExpirationDate;
  }

  /// Verifica si la palabra actual ha expirado
  static bool isExpired() {
    if (_cachedExpirationDate == null) return true;
    return DateTime.now().isAfter(_cachedExpirationDate!);
  }
}
