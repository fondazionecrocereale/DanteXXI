import '../entities/teacher.dart';
import '../entities/course.dart';
import '../entities/article.dart';
import '../repositories/teacher_repository.dart';

class GetTeachersUseCase {
  final TeacherRepository _repository;

  GetTeachersUseCase(this._repository);

  Future<List<Teacher>> call() async {
    return await _repository.getTeachers();
  }
}

class GetTeacherByIdUseCase {
  final TeacherRepository _repository;

  GetTeacherByIdUseCase(this._repository);

  Future<Teacher> call(String id) async {
    return await _repository.getTeacherById(id);
  }
}

class GetFeaturedTeachersUseCase {
  final TeacherRepository _repository;

  GetFeaturedTeachersUseCase(this._repository);

  Future<List<Teacher>> call() async {
    return await _repository.getFeaturedTeachers();
  }
}

class SearchTeachersUseCase {
  final TeacherRepository _repository;

  SearchTeachersUseCase(this._repository);

  Future<List<Teacher>> call(String query) async {
    return await _repository.searchTeachers(query);
  }
}

class GetTeacherCoursesUseCase {
  final TeacherRepository _repository;

  GetTeacherCoursesUseCase(this._repository);

  Future<List<Course>> call(String teacherId) async {
    return await _repository.getTeacherCourses(teacherId);
  }
}

class GetFeaturedCoursesUseCase {
  final TeacherRepository _repository;

  GetFeaturedCoursesUseCase(this._repository);

  Future<List<Course>> call() async {
    return await _repository.getFeaturedCourses();
  }
}

class GetFreeCoursesUseCase {
  final TeacherRepository _repository;

  GetFreeCoursesUseCase(this._repository);

  Future<List<Course>> call() async {
    return await _repository.getFreeCourses();
  }
}

class GetPaidCoursesUseCase {
  final TeacherRepository _repository;

  GetPaidCoursesUseCase(this._repository);

  Future<List<Course>> call() async {
    return await _repository.getPaidCourses();
  }
}

class GetCourseByIdUseCase {
  final TeacherRepository _repository;

  GetCourseByIdUseCase(this._repository);

  Future<Course> call(String id) async {
    return await _repository.getCourseById(id);
  }
}

class SearchCoursesUseCase {
  final TeacherRepository _repository;

  SearchCoursesUseCase(this._repository);

  Future<List<Course>> call(String query) async {
    return await _repository.searchCourses(query);
  }
}

class GetTeacherArticlesUseCase {
  final TeacherRepository _repository;

  GetTeacherArticlesUseCase(this._repository);

  Future<List<Article>> call(String teacherId) async {
    return await _repository.getTeacherArticles(teacherId);
  }
}

class GetFeaturedArticlesUseCase {
  final TeacherRepository _repository;

  GetFeaturedArticlesUseCase(this._repository);

  Future<List<Article>> call() async {
    return await _repository.getFeaturedArticles();
  }
}

class GetLatestArticlesUseCase {
  final TeacherRepository _repository;

  GetLatestArticlesUseCase(this._repository);

  Future<List<Article>> call() async {
    return await _repository.getLatestArticles();
  }
}

class GetArticleByIdUseCase {
  final TeacherRepository _repository;

  GetArticleByIdUseCase(this._repository);

  Future<Article> call(String id) async {
    return await _repository.getArticleById(id);
  }
}

class SearchArticlesUseCase {
  final TeacherRepository _repository;

  SearchArticlesUseCase(this._repository);

  Future<List<Article>> call(String query) async {
    return await _repository.searchArticles(query);
  }
}

class PurchaseCourseUseCase {
  final TeacherRepository _repository;

  PurchaseCourseUseCase(this._repository);

  Future<bool> call(String courseId, double amount) async {
    return await _repository.purchaseCourse(courseId, amount);
  }
}

class GetUserPurchasesUseCase {
  final TeacherRepository _repository;

  GetUserPurchasesUseCase(this._repository);

  Future<List<CoursePurchase>> call() async {
    return await _repository.getUserPurchases();
  }
}

class IsCoursePurchasedUseCase {
  final TeacherRepository _repository;

  IsCoursePurchasedUseCase(this._repository);

  Future<bool> call(String courseId) async {
    return await _repository.isCoursePurchased(courseId);
  }
}
