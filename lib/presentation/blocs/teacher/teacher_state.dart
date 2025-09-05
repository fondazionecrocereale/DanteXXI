import 'package:equatable/equatable.dart';
import '../../../domain/entities/teacher.dart';
import '../../../domain/entities/course.dart';
import '../../../domain/entities/article.dart';

abstract class TeacherState extends Equatable {
  const TeacherState();

  @override
  List<Object> get props => [];
}

class TeacherInitial extends TeacherState {}

class TeacherLoading extends TeacherState {}

class TeacherLoaded extends TeacherState {
  final List<Teacher> teachers;
  final Teacher? teacher;
  final List<Course> courses;
  final List<Article> articles;
  final List<CoursePurchase> purchases;
  final bool isCoursePurchased;

  const TeacherLoaded({
    this.teachers = const [],
    this.teacher,
    this.courses = const [],
    this.articles = const [],
    this.purchases = const [],
    this.isCoursePurchased = false,
  });

  @override
  List<Object> get props => [
    teachers,
    teacher ?? '',
    courses,
    articles,
    purchases,
    isCoursePurchased,
  ];

  TeacherLoaded copyWith({
    List<Teacher>? teachers,
    Teacher? teacher,
    List<Course>? courses,
    List<Article>? articles,
    List<CoursePurchase>? purchases,
    bool? isCoursePurchased,
  }) {
    return TeacherLoaded(
      teachers: teachers ?? this.teachers,
      teacher: teacher ?? this.teacher,
      courses: courses ?? this.courses,
      articles: articles ?? this.articles,
      purchases: purchases ?? this.purchases,
      isCoursePurchased: isCoursePurchased ?? this.isCoursePurchased,
    );
  }
}

class TeacherError extends TeacherState {
  final String message;

  const TeacherError(this.message);

  @override
  List<Object> get props => [message];
}

class CoursePurchaseSuccess extends TeacherState {
  final String courseId;
  final String transactionHash;

  const CoursePurchaseSuccess({
    required this.courseId,
    required this.transactionHash,
  });

  @override
  List<Object> get props => [courseId, transactionHash];
}

class CoursePurchaseError extends TeacherState {
  final String message;

  const CoursePurchaseError(this.message);

  @override
  List<Object> get props => [message];
}
