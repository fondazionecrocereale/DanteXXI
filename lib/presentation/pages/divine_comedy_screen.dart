import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../domain/entities/divine_comedy_model.dart';
import '../widgets/learning_new_map.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class DivineComedyScreen extends StatefulWidget {
  const DivineComedyScreen({super.key});

  @override
  State<DivineComedyScreen> createState() => _DivineComedyScreenState();
}

class _DivineComedyScreenState extends State<DivineComedyScreen> {
  List<DivineComedyModel> _sections = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadSections();
  }

  Future<void> _loadSections() async {
    setState(() => _isLoading = true);
    try {
      final jsonString = await rootBundle.loadString(
        'assets/data/italian_learning_map.json',
      );
      final jsonData = json.decode(jsonString);

      final sections = jsonData['sections'] as List<dynamic>;
      final List<DivineComedyModel> allSections = [];

      for (final section in sections) {
        final lessons = section['lessons'] as List<dynamic>;
        final List<Lesson> sectionLessons = [];

        for (final lesson in lessons) {
          final lessonObj = Lesson(
            id: lesson['id'] ?? 0,
            isCompleted: lesson['isCompleted'] ?? false,
            isUnlocked: lesson['isUnlocked'] ?? false,
            livello: lesson['livello'] ?? 'A1',
            nextLessonIds: List<int>.from(lesson['nextLessonIds'] ?? []),
            position: Position(
              x: (lesson['position']?['x'] ?? 0.5).toDouble(),
              y: (lesson['position']?['y'] ?? 0.5).toDouble(),
            ),
            title: lesson['title'] ?? '',
            uid: lesson['uid'] ?? '',
          );
          sectionLessons.add(lessonObj);
        }

        final sectionObj = DivineComedyModel(
          title: section['title'] ?? '',
          cefrRange: List<String>.from(section['cefr_range'] ?? []),
          baseColor: ColorModel(
            red: section['baseColor']?['red'] ?? 172,
            green: section['baseColor']?['green'] ?? 21,
            blue: section['baseColor']?['blue'] ?? 21,
          ),
          textColor: ColorModel(
            red: section['textColor']?['red'] ?? 255,
            green: section['textColor']?['green'] ?? 255,
            blue: section['textColor']?['blue'] ?? 255,
          ),
          cardColor: ColorModel(
            red: section['cardColor']?['red'] ?? 133,
            green: section['cardColor']?['green'] ?? 27,
            blue: section['cardColor']?['blue'] ?? 27,
          ),
          backgroundImage: section['backgroundImage'] ?? '',
          lessons: sectionLessons,
        );

        allSections.add(sectionObj);
      }

      setState(() {
        _sections = allSections;
        _isLoading = false;
      });
    } catch (e) {
      debugPrint('Error loading sections: $e');
      setState(() {
        _sections = _generateSampleSections();
        _isLoading = false;
      });
    }
  }

  List<DivineComedyModel> _generateSampleSections() {
    return [
      DivineComedyModel(
        title: 'LVDVS A1',
        cefrRange: ['A1'],
        baseColor: ColorModel(red: 172, green: 21, blue: 21),
        textColor: ColorModel(red: 255, green: 255, blue: 255),
        cardColor: ColorModel(red: 133, green: 27, blue: 27),
        backgroundImage: 'assets/images/fresco2.png',
        lessons: [
          Lesson(
            id: 1,
            isCompleted: true,
            isUnlocked: true,
            livello: 'A1',
            nextLessonIds: [2],
            position: Position(x: 0.2, y: 0.1),
            title: 'IMPERIVM ROMANVM',
            uid: 'latin_a1_1',
          ),
          Lesson(
            id: 2,
            isCompleted: true,
            isUnlocked: true,
            livello: 'A1',
            nextLessonIds: [3],
            position: Position(x: 0.8, y: 0.2),
            title: 'LITTERAE ET NVMERI',
            uid: 'latin_a1_2',
          ),
          Lesson(
            id: 3,
            isCompleted: false,
            isUnlocked: true,
            livello: 'A1',
            nextLessonIds: [4],
            position: Position(x: 0.2, y: 0.3),
            title: 'FAMILIA ROMANA',
            uid: 'latin_a1_3',
          ),
          Lesson(
            id: 4,
            isCompleted: false,
            isUnlocked: false,
            livello: 'A1',
            nextLessonIds: [5],
            position: Position(x: 0.8, y: 0.4),
            title: 'LIBER TVVS LATINVS',
            uid: 'latin_a1_4',
          ),
          Lesson(
            id: 5,
            isCompleted: false,
            isUnlocked: false,
            livello: 'A1',
            nextLessonIds: [6],
            position: Position(x: 0.2, y: 0.5),
            title: 'PVER IMPROBVS',
            uid: 'latin_a1_5',
          ),
          Lesson(
            id: 6,
            isCompleted: false,
            isUnlocked: false,
            livello: 'A1',
            nextLessonIds: [7],
            position: Position(x: 0.8, y: 0.6),
            title: 'DOMINVS ET SERVI',
            uid: 'latin_a1_6',
          ),
          Lesson(
            id: 7,
            isCompleted: false,
            isUnlocked: false,
            livello: 'A1',
            nextLessonIds: [8],
            position: Position(x: 0.2, y: 0.7),
            title: 'VILLA ET HORTVS',
            uid: 'latin_a1_7',
          ),
          Lesson(
            id: 8,
            isCompleted: false,
            isUnlocked: false,
            livello: 'A1',
            nextLessonIds: [9],
            position: Position(x: 0.8, y: 0.8),
            title: 'VIA LATINA',
            uid: 'latin_a1_8',
          ),
          Lesson(
            id: 9,
            isCompleted: false,
            isUnlocked: false,
            livello: 'A1',
            nextLessonIds: [],
            position: Position(x: 0.2, y: 0.9),
            title: 'PVELLA ET ROSA',
            uid: 'latin_a1_9',
          ),
        ],
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(133, 27, 27, 1),
      body: _isLoading
          ? shimmerSkeleton()
          : SingleChildScrollView(child: buildBody(context, _sections)),
    );
  }

  Widget shimmerSkeleton() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Container(width: 200, height: 20, color: Colors.grey[300]),
          ),
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            height: 40,
            margin: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}

Widget buildBody(BuildContext context, List<DivineComedyModel> sections) {
  return sections.isEmpty
      ? const Center(child: CircularProgressIndicator())
      : ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: sections.length,
          itemBuilder: (context, index) {
            debugPrint('Building section: ${sections[index].title}');
            return SectionCard(section: sections[index]);
          },
        );
}

class SectionCard extends StatelessWidget {
  final DivineComedyModel section;

  const SectionCard({super.key, required this.section});

  double _calculateMapHeight(List<Lesson> lessons, double screenWidth) {
    if (lessons.isEmpty) return 150.0;

    final validLessons = lessons
        .where(
          (lesson) =>
              lesson.id != 0 &&
              (lesson.position.x != 0.0 || lesson.position.y != 0.0),
        )
        .toList();
    if (validLessons.isEmpty) return 150.0;

    final maxY = validLessons
        .map((lesson) => lesson.position.y)
        .reduce((a, b) => a > b ? a : b);

    const nodeHeight = 80.0;
    const textHeight = 20.0;
    const padding = 40.0;
    final calculatedHeight =
        (maxY * screenWidth) + (nodeHeight / 2) + textHeight + padding;

    return calculatedHeight < 150.0 ? 150.0 : calculatedHeight;
  }

  double _calculateMapWidth(List<Lesson> lessons, double screenWidth) {
    if (lessons.isEmpty) return screenWidth;

    final validLessons = lessons
        .where(
          (lesson) =>
              lesson.id != 0 &&
              (lesson.position.x != 0.0 || lesson.position.y != 0.0),
        )
        .toList();
    if (validLessons.isEmpty) return screenWidth;

    final maxX = validLessons
        .map((lesson) => lesson.position.x)
        .reduce((a, b) => a > b ? a : b);

    const nodeWidth = 80.0;
    const padding = 40.0;
    final calculatedWidth = (maxX * screenWidth) + (nodeWidth / 2) + padding;

    return calculatedWidth;
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final mapHeight = _calculateMapHeight(section.lessons, screenWidth);
    final mapWidth = _calculateMapWidth(section.lessons, screenWidth);

    return Card(
      color: Colors.transparent,
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(section.backgroundImage),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
              Colors.black.withOpacity(0.2),
              BlendMode.dstATop,
            ),
          ),
          color: section.cardColor.toColor().withOpacity(0.8),
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                section.title,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: section.textColor.toColor(),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),
              Text(
                "Gradus: ${section.cefrRange.join(' - ')}",
                style: TextStyle(
                  fontSize: 16,
                  color: section.textColor.toColor(),
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.5),
                      offset: const Offset(1, 1),
                      blurRadius: 2,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 4),

              if (section.lessons.isEmpty)
                const Text(
                  "No lessons available.",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                )
              else
                SizedBox(
                  height: mapHeight + mapHeight,
                  width: mapWidth,
                  child: LearningNewMap(section: section),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
