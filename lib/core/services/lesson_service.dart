import 'package:flutter/material.dart';

class LessonService {
  // Simular actualización de progreso (en el futuro se conectará a tu API de Golang)
  static Future<void> completeLessonAndNavigate({
    required BuildContext context,
    required String sectionTitle,
    required int lessonId,
  }) async {
    try {
      // Aquí en el futuro harás una llamada a tu API de Golang
      // await _updateLessonProgress(sectionTitle, lessonId);

      // Por ahora solo mostramos el mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('¡Lección completada! 🎉'),
          backgroundColor: Colors.green,
        ),
      );

      // Navegar de vuelta al mapa de aprendizaje
      Navigator.of(context).popUntil((route) => route.isFirst);
    } catch (e) {
      debugPrint('Error completing lesson: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error al completar lección: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  // En el futuro, este método se conectará a tu API de Golang
  static Future<void> _updateLessonProgress(
    String sectionTitle,
    int lessonId,
  ) async {
    // TODO: Implementar llamada a tu API de Golang
    // Ejemplo:
    // final response = await http.post(
    //   Uri.parse('https://tu-api-golang.com/lessons/complete'),
    //   body: {
    //     'sectionTitle': sectionTitle,
    //     'lessonId': lessonId,
    //   },
    // );

    debugPrint('Lesson $lessonId completed in section $sectionTitle');
  }
}
