import 'package:flutter/material.dart';
import '../../domain/entities/divine_comedy_model.dart';

class LearningPathPainter extends CustomPainter {
  final List<Lesson> lessons;
  final Size screenSize;

  LearningPathPainter(this.lessons, this.screenSize);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.grey.shade400
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    for (final lesson in lessons) {
      if (lesson.id == 0 ||
          lesson.position.x == 0.0 ||
          lesson.position.y == 0.0) {
        debugPrint(
          'Skipping invalid lesson: ID=${lesson.id}, Title=${lesson.title}',
        );
        continue;
      }

      for (final nextId in lesson.nextLessonIds) {
        final nextLesson = lessons.firstWhere(
          (l) => l.id == nextId,
          orElse: () => Lesson.dummy(),
        );

        if (nextLesson.id != 0) {
          final from = Offset(
            lesson.position.x * screenSize.width,
            lesson.position.y * screenSize.height,
          );
          final to = Offset(
            nextLesson.position.x * screenSize.width,
            nextLesson.position.y * screenSize.height,
          );
          canvas.drawLine(from, to, paint);
          debugPrint(
            'Drawing line from ${lesson.title} ($from) to ${nextLesson.title} ($to)',
          );
        } else {
          debugPrint(
            'No valid next lesson found for ID=$nextId from ${lesson.title}',
          );
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
