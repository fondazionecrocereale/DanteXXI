import '../entities/teacher.dart';
import '../entities/course.dart';
import '../entities/article.dart';

abstract class TeacherRepository {
  // Teachers
  Future<List<Teacher>> getTeachers();
  Future<Teacher> getTeacherById(String id);
  Future<List<Teacher>> getFeaturedTeachers();
  Future<List<Teacher>> searchTeachers(String query);

  // Courses
  Future<List<Course>> getTeacherCourses(String teacherId);
  Future<List<Course>> getFeaturedCourses();
  Future<List<Course>> getFreeCourses();
  Future<List<Course>> getPaidCourses();
  Future<Course> getCourseById(String id);
  Future<List<Course>> searchCourses(String query);

  // Articles
  Future<List<Article>> getTeacherArticles(String teacherId);
  Future<List<Article>> getFeaturedArticles();
  Future<List<Article>> getLatestArticles();
  Future<Article> getArticleById(String id);
  Future<List<Article>> searchArticles(String query);

  // Purchases
  Future<bool> purchaseCourse(String courseId, double amount);
  Future<List<CoursePurchase>> getUserPurchases();
  Future<bool> isCoursePurchased(String courseId);
}
