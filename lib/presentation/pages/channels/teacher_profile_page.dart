import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/entities/teacher.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/entities/article.dart';
import '../../blocs/teacher/teacher_bloc.dart';
import '../../blocs/teacher/teacher_event.dart';
import '../../blocs/teacher/teacher_state.dart';
import '../../widgets/teacher/teacher_header.dart';
import '../../widgets/teacher/course_grid.dart';
import '../../widgets/teacher/article_list.dart';
import '../../widgets/teacher/teacher_stats.dart' as teacher_widgets;
import 'course_detail_page.dart';
import 'article_detail_page.dart';

class TeacherProfilePage extends StatefulWidget {
  final String teacherId;

  const TeacherProfilePage({super.key, required this.teacherId});

  @override
  State<TeacherProfilePage> createState() => _TeacherProfilePageState();
}

class _TeacherProfilePageState extends State<TeacherProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  Teacher? _teacher;
  List<Course> _courses = [];
  List<Article> _articles = [];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    context.read<TeacherBloc>().add(LoadTeacherById(widget.teacherId));
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: BlocBuilder<TeacherBloc, TeacherState>(
        builder: (context, state) {
          if (state is TeacherLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TeacherError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text(
                    'Error al cargar el profesor',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    state.message,
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      context.read<TeacherBloc>().add(
                        LoadTeacherById(widget.teacherId),
                      );
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            );
          } else if (state is TeacherLoaded) {
            _teacher = state.teacher;
            _courses = state.courses;
            _articles = state.articles;
          }

          if (_teacher == null) {
            return const Center(child: CircularProgressIndicator());
          }

          return NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                  expandedHeight: 300,
                  floating: false,
                  pinned: true,
                  backgroundColor: Colors.transparent,
                  flexibleSpace: FlexibleSpaceBar(
                    background: TeacherHeader(
                      teacher: _teacher!,
                      onFollow: () {
                        // TODO: Implement follow functionality
                      },
                    ),
                  ),
                ),
              ];
            },
            body: Column(
              children: [
                // Tab Bar
                Container(
                  color: Theme.of(context).colorScheme.surface,
                  child: TabBar(
                    controller: _tabController,
                    tabs: const [
                      Tab(text: 'Cursos'),
                      Tab(text: 'Artículos'),
                      Tab(text: 'Estadísticas'),
                    ],
                    labelColor: Theme.of(context).colorScheme.primary,
                    unselectedLabelColor: Colors.grey[600],
                    indicatorColor: Theme.of(context).colorScheme.primary,
                  ),
                ),

                // Tab Content
                Expanded(
                  child: TabBarView(
                    controller: _tabController,
                    children: [
                      // Courses Tab
                      CourseGrid(
                        courses: _courses,
                        onCourseTap: (course) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CourseDetailPage(courseId: course.id),
                            ),
                          );
                        },
                      ),

                      // Articles Tab
                      ArticleList(
                        articles: _articles,
                        onArticleTap: (article) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  ArticleDetailPage(articleId: article.id),
                            ),
                          );
                        },
                      ),

                      // Stats Tab
                      teacher_widgets.TeacherStats(teacher: _teacher!),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
