import 'package:flutter/material.dart';
import '../../../domain/entities/course.dart';

class CourseLessonsList extends StatelessWidget {
  final String courseId;
  final bool isPurchased;

  const CourseLessonsList({
    super.key,
    required this.courseId,
    required this.isPurchased,
  });

  @override
  Widget build(BuildContext context) {
    // Mock data for lessons
    final lessons = [
      CourseLesson(
        id: '1',
        courseId: courseId,
        title: 'Introducción al Italiano',
        description: 'Aprende los conceptos básicos del idioma italiano',
        videoUrl: 'https://example.com/video1.mp4',
        duration: 15,
        order: 1,
        isFree: true,
        isCompleted: false,
        transcript: 'Transcripción de la lección...',
        resources: ['PDF de vocabulario', 'Ejercicios prácticos'],
      ),
      CourseLesson(
        id: '2',
        courseId: courseId,
        title: 'Pronunciación Básica',
        description: 'Domina la pronunciación correcta de las letras italianas',
        videoUrl: 'https://example.com/video2.mp4',
        duration: 20,
        order: 2,
        isFree: false,
        isCompleted: false,
        transcript: 'Transcripción de la lección...',
        resources: ['Audio de pronunciación', 'Ejercicios de fonética'],
      ),
      CourseLesson(
        id: '3',
        courseId: courseId,
        title: 'Vocabulario Esencial',
        description: 'Las 100 palabras más importantes en italiano',
        videoUrl: 'https://example.com/video3.mp4',
        duration: 25,
        order: 3,
        isFree: false,
        isCompleted: false,
        transcript: 'Transcripción de la lección...',
        resources: ['Lista de vocabulario', 'Tarjetas de memoria'],
      ),
    ];

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lecciones del Curso',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: lessons.length,
              itemBuilder: (context, index) {
                final lesson = lessons[index];
                return _LessonItem(
                  lesson: lesson,
                  isPurchased: isPurchased,
                  onTap: () {
                    if (lesson.isFree || isPurchased) {
                      // TODO: Navigate to lesson video
                    } else {
                      // TODO: Show purchase required dialog
                    }
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _LessonItem extends StatelessWidget {
  final CourseLesson lesson;
  final bool isPurchased;
  final VoidCallback onTap;

  const _LessonItem({
    required this.lesson,
    required this.isPurchased,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final canAccess = lesson.isFree || isPurchased;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        border: Border.all(
          color: canAccess ? Colors.green : Colors.grey[300]!,
          width: 1,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ListTile(
        onTap: canAccess ? onTap : null,
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: canAccess ? Colors.green : Colors.grey[300],
            shape: BoxShape.circle,
          ),
          child: Icon(
            canAccess ? Icons.play_arrow : Icons.lock,
            color: canAccess ? Colors.white : Colors.grey[600],
          ),
        ),
        title: Text(
          lesson.title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: canAccess ? Colors.black : Colors.grey[600],
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              lesson.description,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: canAccess ? Colors.grey[600] : Colors.grey[400],
              ),
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.access_time, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text(
                  '${lesson.duration} min',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey[500]),
                ),
                if (!lesson.isFree && !isPurchased) ...[
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'PAGO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ],
        ),
        trailing: canAccess
            ? Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey[400])
            : Icon(Icons.lock, color: Colors.grey[400]),
      ),
    );
  }
}
