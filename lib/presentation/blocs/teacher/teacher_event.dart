import 'package:equatable/equatable.dart';

abstract class TeacherEvent extends Equatable {
  const TeacherEvent();

  @override
  List<Object> get props => [];
}

class LoadTeachers extends TeacherEvent {
  const LoadTeachers();
}

class LoadTeacherById extends TeacherEvent {
  final String teacherId;

  const LoadTeacherById(this.teacherId);

  @override
  List<Object> get props => [teacherId];
}

class LoadFeaturedTeachers extends TeacherEvent {
  const LoadFeaturedTeachers();
}

class SearchTeachers extends TeacherEvent {
  final String query;

  const SearchTeachers(this.query);

  @override
  List<Object> get props => [query];
}

class LoadTeacherCourses extends TeacherEvent {
  final String teacherId;

  const LoadTeacherCourses(this.teacherId);

  @override
  List<Object> get props => [teacherId];
}

class LoadFeaturedCourses extends TeacherEvent {
  const LoadFeaturedCourses();
}

class LoadFreeCourses extends TeacherEvent {
  const LoadFreeCourses();
}

class LoadPaidCourses extends TeacherEvent {
  const LoadPaidCourses();
}

class LoadCourseById extends TeacherEvent {
  final String courseId;

  const LoadCourseById(this.courseId);

  @override
  List<Object> get props => [courseId];
}

class SearchCourses extends TeacherEvent {
  final String query;

  const SearchCourses(this.query);

  @override
  List<Object> get props => [query];
}

class LoadTeacherArticles extends TeacherEvent {
  final String teacherId;

  const LoadTeacherArticles(this.teacherId);

  @override
  List<Object> get props => [teacherId];
}

class LoadFeaturedArticles extends TeacherEvent {
  const LoadFeaturedArticles();
}

class LoadLatestArticles extends TeacherEvent {
  const LoadLatestArticles();
}

class LoadArticleById extends TeacherEvent {
  final String articleId;

  const LoadArticleById(this.articleId);

  @override
  List<Object> get props => [articleId];
}

class SearchArticles extends TeacherEvent {
  final String query;

  const SearchArticles(this.query);

  @override
  List<Object> get props => [query];
}

class PurchaseCourse extends TeacherEvent {
  final String courseId;
  final double amount;

  const PurchaseCourse(this.courseId, this.amount);

  @override
  List<Object> get props => [courseId, amount];
}

class LoadUserPurchases extends TeacherEvent {
  const LoadUserPurchases();
}

class CheckCoursePurchased extends TeacherEvent {
  final String courseId;

  const CheckCoursePurchased(this.courseId);

  @override
  List<Object> get props => [courseId];
}
