import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/teacher.dart';
import '../../blocs/teacher/teacher_bloc.dart';
import '../../blocs/teacher/teacher_state.dart';
import 'teacher_card.dart';

class FeaturedTeachersSection extends StatelessWidget {
  const FeaturedTeachersSection({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TeacherBloc, TeacherState>(
      builder: (context, state) {
        if (state is TeacherLoading) {
          return const Padding(
            padding: EdgeInsets.all(16.0),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        // Mock data for featured teachers
        final featuredTeachers = [
          Teacher(
            id: '1',
            name: 'Marco Rossi',
            email: 'marco@example.com',
            bio: 'Profesor nativo de italiano con 10 años de experiencia',
            profileImageUrl: 'https://via.placeholder.com/150',
            coverImageUrl: 'https://via.placeholder.com/400x200',
            logoUrl: 'https://via.placeholder.com/50',
            isVerified: true,
            totalStudents: 1250,
            totalCourses: 15,
            totalArticles: 45,
            rating: 4.8,
            specializations: ['Gramática', 'Conversación'],
            languages: ['Italiano', 'Español', 'Inglés'],
            joinDate: DateTime.now().subtract(const Duration(days: 365)),
            isActive: true,
            createdAt: DateTime.now().subtract(const Duration(days: 365)),
            updatedAt: DateTime.now(),
          ),
          Teacher(
            id: '2',
            name: 'Giulia Bianchi',
            email: 'giulia@example.com',
            bio: 'Especialista en cultura italiana y arte',
            profileImageUrl: 'https://via.placeholder.com/150',
            coverImageUrl: 'https://via.placeholder.com/400x200',
            logoUrl: 'https://via.placeholder.com/50',
            isVerified: true,
            totalStudents: 890,
            totalCourses: 12,
            totalArticles: 32,
            rating: 4.9,
            specializations: ['Cultura', 'Arte', 'Historia'],
            languages: ['Italiano', 'Español', 'Francés'],
            joinDate: DateTime.now().subtract(const Duration(days: 200)),
            isActive: true,
            createdAt: DateTime.now().subtract(const Duration(days: 200)),
            updatedAt: DateTime.now(),
          ),
        ];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
              child: Row(
                children: [
                  Text(
                    'Profesores Destacados',
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {
                      // TODO: Navigate to all featured teachers
                    },
                    child: const Text('Ver todos'),
                  ),
                ],
              ),
            ),

            // Featured teachers horizontal list
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: featuredTeachers.length,
                itemBuilder: (context, index) {
                  final teacher = featuredTeachers[index];
                  return Container(
                    width: 280,
                    margin: const EdgeInsets.only(right: 12),
                    child: TeacherCard(
                      teacher: teacher,
                      onTap: () {
                        // TODO: Navigate to teacher profile
                      },
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),
          ],
        );
      },
    );
  }
}
