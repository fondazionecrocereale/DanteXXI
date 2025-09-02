import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/divine_comedy_model.dart';
import '../../domain/entities/lesson.dart';
import 'learning_node.dart';
import 'learning_path_painter.dart';
import '../pages/splash_view.dart';
import '../../core/services/learning_progress_service.dart';

class LearningNewMap extends StatefulWidget {
  final DivineComedyModel section;

  const LearningNewMap({super.key, required this.section});

  @override
  State<LearningNewMap> createState() => _LearningNewMapState();
}

class _LearningNewMapState extends State<LearningNewMap> {
  List<Lesson> _lessons = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() => _isLoading = true);
    try {
      // Por ahora usamos los datos de la sección directamente
      // En el futuro se puede integrar con Firestore
      setState(() {
        _lessons = widget.section.lessons;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint("Error in _loadInitialData: $e");
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? shimmerSkeleton()
        : LayoutBuilder(
            builder: (context, constraints) {
              final mapSize = Size(constraints.maxWidth, constraints.maxHeight);
              return buildBody(context, _lessons, mapSize);
            },
          );
  }

  Widget buildBody(BuildContext context, List<Lesson> lessons, Size mapSize) {
    if (lessons.isEmpty) {
      return const Center(child: Text('No lessons available for this section'));
    }
    return InteractiveViewer(
      maxScale: 2.5,
      minScale: 0.8,
      child: Stack(
        children: [
          CustomPaint(
            painter: LearningPathPainter(lessons, mapSize),
            size: mapSize,
          ),
          for (final lesson in lessons)
            if (lesson.id != 0)
              Positioned(
                left: lesson.position.x * mapSize.width - 40,
                top: lesson.position.y * mapSize.height - 40,
                child: LearningNode(
                  title: lesson.title,
                  isUnlocked: lesson.isUnlocked,
                  isCompleted: lesson.isCompleted,
                  onTap: () async {
                    if (lesson.isUnlocked) {
                      debugPrint('Tapped lesson: ${lesson.title}');

                      // Verificar si puede jugar la lección usando LearningProgressService
                      final canPlay =
                          await LearningProgressService.canPlayLesson();
                      if (!canPlay) {
                        if (mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(
                                'No tienes vidas suficientes. Espera 30 minutos para regenerar.',
                              ),
                              backgroundColor: Colors.orange,
                            ),
                          );
                        }
                        return;
                      }

                      // Navegar a SplashView para cargar la lección
                      if (mounted) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                SplashView(id: lesson.id, title: lesson.title),
                          ),
                        );
                      }
                    }
                  },
                ),
              ),
        ],
      ),
    );
  }

  Widget shimmerSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(width: 200, height: 20, color: Colors.grey[300]),
          const SizedBox(height: 4),
          Container(
            width: double.infinity,
            height: 40,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ],
      ),
    );
  }
}
