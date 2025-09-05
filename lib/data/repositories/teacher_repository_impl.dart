import '../../../domain/entities/teacher.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/entities/article.dart';
import '../../../domain/repositories/teacher_repository.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  @override
  Future<List<Teacher>> getTeachers() async {
    // Mock data - in real app this would come from API
    await Future.delayed(const Duration(seconds: 1));
    return [
      Teacher(
        id: '1',
        name: 'Marco Rossi',
        email: 'marco.rossi@example.com',
        bio: 'Profesor de italiano con 10 años de experiencia',
        profileImageUrl: 'https://via.placeholder.com/150',
        coverImageUrl: 'https://via.placeholder.com/400x200',
        logoUrl: 'https://via.placeholder.com/50',
        isVerified: true,
        totalStudents: 1250,
        totalCourses: 15,
        totalArticles: 45,
        rating: 4.8,
        specializations: ['Gramática', 'Conversación', 'Cultura Italiana'],
        languages: ['Italiano', 'Español', 'Inglés'],
        joinDate: DateTime(2020, 1, 15),
        isActive: true,
        createdAt: DateTime(2020, 1, 15),
        updatedAt: DateTime.now(),
      ),
      Teacher(
        id: '2',
        name: 'Giulia Bianchi',
        email: 'giulia.bianchi@example.com',
        bio: 'Especialista en literatura italiana y arte',
        profileImageUrl: 'https://via.placeholder.com/150',
        coverImageUrl: 'https://via.placeholder.com/400x200',
        logoUrl: 'https://via.placeholder.com/50',
        isVerified: true,
        totalStudents: 890,
        totalCourses: 12,
        totalArticles: 32,
        rating: 4.9,
        specializations: ['Literatura', 'Arte', 'Historia Italiana'],
        languages: ['Italiano', 'Español', 'Francés'],
        joinDate: DateTime(2020, 3, 10),
        isActive: true,
        createdAt: DateTime(2020, 3, 10),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<Teacher> getTeacherById(String teacherId) async {
    await Future.delayed(const Duration(seconds: 1));
    final teachers = await getTeachers();
    return teachers.firstWhere((teacher) => teacher.id == teacherId);
  }

  @override
  Future<List<Teacher>> getFeaturedTeachers() async {
    await Future.delayed(const Duration(seconds: 1));
    final teachers = await getTeachers();
    return teachers.where((teacher) => teacher.isVerified).toList();
  }

  @override
  Future<List<Teacher>> searchTeachers(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    final teachers = await getTeachers();
    return teachers
        .where(
          (teacher) =>
              teacher.name.toLowerCase().contains(query.toLowerCase()) ||
              teacher.bio.toLowerCase().contains(query.toLowerCase()) ||
              teacher.specializations.any(
                (spec) => spec.toLowerCase().contains(query.toLowerCase()),
              ),
        )
        .toList();
  }

  @override
  Future<List<Course>> getTeacherCourses(String teacherId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Course(
        id: '1',
        teacherId: teacherId,
        title: 'Italiano Básico A1',
        description: 'Curso completo para principiantes',
        thumbnailUrl: 'https://via.placeholder.com/300x200',
        videoUrl: 'https://via.placeholder.com/video1',
        price: 0.0,
        isFree: true,
        duration: 120,
        totalLessons: 20,
        completedLessons: 0,
        rating: 4.7,
        totalStudents: 500,
        status: CourseStatus.published,
        level: CourseLevel.beginner,
        tags: ['Básico', 'Principiante', 'A1'],
        createdAt: DateTime.now().subtract(const Duration(days: 30)),
        updatedAt: DateTime.now(),
      ),
      Course(
        id: '2',
        teacherId: teacherId,
        title: 'Conversación Avanzada',
        description: 'Mejora tu fluidez en italiano',
        thumbnailUrl: 'https://via.placeholder.com/300x200',
        videoUrl: 'https://via.placeholder.com/video2',
        price: 50.0,
        isFree: false,
        duration: 180,
        totalLessons: 15,
        completedLessons: 0,
        rating: 4.9,
        totalStudents: 200,
        status: CourseStatus.published,
        level: CourseLevel.advanced,
        tags: ['Conversación', 'Avanzado', 'Fluidez'],
        createdAt: DateTime.now().subtract(const Duration(days: 15)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<List<Course>> getFeaturedCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<Course>> getFreeCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<Course>> getPaidCourses() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<Course> getCourseById(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Course(
      id: courseId,
      teacherId: '1',
      title: 'Italiano Básico A1',
      description: 'Curso completo para principiantes',
      thumbnailUrl: 'https://via.placeholder.com/300x200',
      videoUrl: 'https://via.placeholder.com/video1',
      price: 0.0,
      isFree: true,
      duration: 120,
      totalLessons: 20,
      completedLessons: 0,
      rating: 4.7,
      totalStudents: 500,
      status: CourseStatus.published,
      level: CourseLevel.beginner,
      tags: ['Básico', 'Principiante', 'A1'],
      createdAt: DateTime.now().subtract(const Duration(days: 30)),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<List<Course>> searchCourses(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<Article>> getTeacherArticles(String teacherId) async {
    await Future.delayed(const Duration(seconds: 1));
    return [
      Article(
        id: '1',
        teacherId: teacherId,
        title: 'Los secretos de la pronunciación italiana',
        excerpt: 'Aprende a pronunciar correctamente el italiano',
        content: 'Contenido completo del artículo...',
        coverImageUrl: 'https://via.placeholder.com/400x200',
        category: ArticleCategory.pronunciation,
        tags: ['Pronunciación', 'Básico', 'Fonética'],
        isPublished: true,
        readTime: 5,
        views: 1250,
        likes: 89,
        comments: 12,
        publishedAt: DateTime.now().subtract(const Duration(days: 7)),
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
        updatedAt: DateTime.now(),
      ),
    ];
  }

  @override
  Future<List<Article>> getFeaturedArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<List<Article>> getLatestArticles() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<Article> getArticleById(String articleId) async {
    await Future.delayed(const Duration(seconds: 1));
    return Article(
      id: articleId,
      teacherId: '1',
      title: 'Los secretos de la pronunciación italiana',
      excerpt: 'Aprende a pronunciar correctamente el italiano',
      content: 'Contenido completo del artículo...',
      coverImageUrl: 'https://via.placeholder.com/400x200',
      category: ArticleCategory.pronunciation,
      tags: ['Pronunciación', 'Básico', 'Fonética'],
      isPublished: true,
      readTime: 5,
      views: 1250,
      likes: 89,
      comments: 12,
      publishedAt: DateTime.now().subtract(const Duration(days: 7)),
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      updatedAt: DateTime.now(),
    );
  }

  @override
  Future<List<Article>> searchArticles(String query) async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<bool> purchaseCourse(String courseId, double amount) async {
    await Future.delayed(const Duration(seconds: 2));
    // Mock purchase - in real app this would process payment
    return true;
  }

  @override
  Future<List<CoursePurchase>> getUserPurchases() async {
    await Future.delayed(const Duration(seconds: 1));
    return [];
  }

  @override
  Future<bool> isCoursePurchased(String courseId) async {
    await Future.delayed(const Duration(seconds: 1));
    // Mock - in real app this would check user's purchases
    return false;
  }
}
