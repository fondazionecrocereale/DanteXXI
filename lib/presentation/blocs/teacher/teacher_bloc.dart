import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../domain/usecases/teacher_usecases.dart';
import 'teacher_event.dart';
import 'teacher_state.dart';

class TeacherBloc extends Bloc<TeacherEvent, TeacherState> {
  final GetTeachersUseCase _getTeachersUseCase;
  final GetTeacherByIdUseCase _getTeacherByIdUseCase;
  final GetFeaturedTeachersUseCase _getFeaturedTeachersUseCase;
  final SearchTeachersUseCase _searchTeachersUseCase;
  final GetTeacherCoursesUseCase _getTeacherCoursesUseCase;
  final GetFeaturedCoursesUseCase _getFeaturedCoursesUseCase;
  final GetFreeCoursesUseCase _getFreeCoursesUseCase;
  final GetPaidCoursesUseCase _getPaidCoursesUseCase;
  final GetCourseByIdUseCase _getCourseByIdUseCase;
  final SearchCoursesUseCase _searchCoursesUseCase;
  final GetTeacherArticlesUseCase _getTeacherArticlesUseCase;
  final GetFeaturedArticlesUseCase _getFeaturedArticlesUseCase;
  final GetLatestArticlesUseCase _getLatestArticlesUseCase;
  final GetArticleByIdUseCase _getArticleByIdUseCase;
  final SearchArticlesUseCase _searchArticlesUseCase;
  final PurchaseCourseUseCase _purchaseCourseUseCase;
  final GetUserPurchasesUseCase _getUserPurchasesUseCase;
  final IsCoursePurchasedUseCase _isCoursePurchasedUseCase;

  TeacherBloc({
    required GetTeachersUseCase getTeachersUseCase,
    required GetTeacherByIdUseCase getTeacherByIdUseCase,
    required GetFeaturedTeachersUseCase getFeaturedTeachersUseCase,
    required SearchTeachersUseCase searchTeachersUseCase,
    required GetTeacherCoursesUseCase getTeacherCoursesUseCase,
    required GetFeaturedCoursesUseCase getFeaturedCoursesUseCase,
    required GetFreeCoursesUseCase getFreeCoursesUseCase,
    required GetPaidCoursesUseCase getPaidCoursesUseCase,
    required GetCourseByIdUseCase getCourseByIdUseCase,
    required SearchCoursesUseCase searchCoursesUseCase,
    required GetTeacherArticlesUseCase getTeacherArticlesUseCase,
    required GetFeaturedArticlesUseCase getFeaturedArticlesUseCase,
    required GetLatestArticlesUseCase getLatestArticlesUseCase,
    required GetArticleByIdUseCase getArticleByIdUseCase,
    required SearchArticlesUseCase searchArticlesUseCase,
    required PurchaseCourseUseCase purchaseCourseUseCase,
    required GetUserPurchasesUseCase getUserPurchasesUseCase,
    required IsCoursePurchasedUseCase isCoursePurchasedUseCase,
  }) : _getTeachersUseCase = getTeachersUseCase,
       _getTeacherByIdUseCase = getTeacherByIdUseCase,
       _getFeaturedTeachersUseCase = getFeaturedTeachersUseCase,
       _searchTeachersUseCase = searchTeachersUseCase,
       _getTeacherCoursesUseCase = getTeacherCoursesUseCase,
       _getFeaturedCoursesUseCase = getFeaturedCoursesUseCase,
       _getFreeCoursesUseCase = getFreeCoursesUseCase,
       _getPaidCoursesUseCase = getPaidCoursesUseCase,
       _getCourseByIdUseCase = getCourseByIdUseCase,
       _searchCoursesUseCase = searchCoursesUseCase,
       _getTeacherArticlesUseCase = getTeacherArticlesUseCase,
       _getFeaturedArticlesUseCase = getFeaturedArticlesUseCase,
       _getLatestArticlesUseCase = getLatestArticlesUseCase,
       _getArticleByIdUseCase = getArticleByIdUseCase,
       _searchArticlesUseCase = searchArticlesUseCase,
       _purchaseCourseUseCase = purchaseCourseUseCase,
       _getUserPurchasesUseCase = getUserPurchasesUseCase,
       _isCoursePurchasedUseCase = isCoursePurchasedUseCase,
       super(TeacherInitial()) {
    on<LoadTeachers>(_onLoadTeachers);
    on<LoadTeacherById>(_onLoadTeacherById);
    on<LoadFeaturedTeachers>(_onLoadFeaturedTeachers);
    on<SearchTeachers>(_onSearchTeachers);
    on<LoadTeacherCourses>(_onLoadTeacherCourses);
    on<LoadFeaturedCourses>(_onLoadFeaturedCourses);
    on<LoadFreeCourses>(_onLoadFreeCourses);
    on<LoadPaidCourses>(_onLoadPaidCourses);
    on<LoadCourseById>(_onLoadCourseById);
    on<SearchCourses>(_onSearchCourses);
    on<LoadTeacherArticles>(_onLoadTeacherArticles);
    on<LoadFeaturedArticles>(_onLoadFeaturedArticles);
    on<LoadLatestArticles>(_onLoadLatestArticles);
    on<LoadArticleById>(_onLoadArticleById);
    on<SearchArticles>(_onSearchArticles);
    on<PurchaseCourse>(_onPurchaseCourse);
    on<LoadUserPurchases>(_onLoadUserPurchases);
    on<CheckCoursePurchased>(_onCheckCoursePurchased);
  }

  Future<void> _onLoadTeachers(
    LoadTeachers event,
    Emitter<TeacherState> emit,
  ) async {
    emit(TeacherLoading());
    try {
      final teachers = await _getTeachersUseCase();
      emit(TeacherLoaded(teachers: teachers));
    } catch (e) {
      emit(TeacherError('Error al cargar profesores: ${e.toString()}'));
    }
  }

  Future<void> _onLoadTeacherById(
    LoadTeacherById event,
    Emitter<TeacherState> emit,
  ) async {
    emit(TeacherLoading());
    try {
      final teacher = await _getTeacherByIdUseCase(event.teacherId);
      final courses = await _getTeacherCoursesUseCase(event.teacherId);
      final articles = await _getTeacherArticlesUseCase(event.teacherId);
      emit(
        TeacherLoaded(teacher: teacher, courses: courses, articles: articles),
      );
    } catch (e) {
      emit(TeacherError('Error al cargar el profesor: ${e.toString()}'));
    }
  }

  Future<void> _onLoadFeaturedTeachers(
    LoadFeaturedTeachers event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final teachers = await _getFeaturedTeachersUseCase();
      emit(TeacherLoaded(teachers: teachers));
    } catch (e) {
      emit(
        TeacherError('Error al cargar profesores destacados: ${e.toString()}'),
      );
    }
  }

  Future<void> _onSearchTeachers(
    SearchTeachers event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final teachers = await _searchTeachersUseCase(event.query);
      emit(TeacherLoaded(teachers: teachers));
    } catch (e) {
      emit(TeacherError('Error al buscar profesores: ${e.toString()}'));
    }
  }

  Future<void> _onLoadTeacherCourses(
    LoadTeacherCourses event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final courses = await _getTeacherCoursesUseCase(event.teacherId);
      emit(TeacherLoaded(courses: courses));
    } catch (e) {
      emit(TeacherError('Error al cargar cursos: ${e.toString()}'));
    }
  }

  Future<void> _onLoadFeaturedCourses(
    LoadFeaturedCourses event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final courses = await _getFeaturedCoursesUseCase();
      emit(TeacherLoaded(courses: courses));
    } catch (e) {
      emit(TeacherError('Error al cargar cursos destacados: ${e.toString()}'));
    }
  }

  Future<void> _onLoadFreeCourses(
    LoadFreeCourses event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final courses = await _getFreeCoursesUseCase();
      emit(TeacherLoaded(courses: courses));
    } catch (e) {
      emit(TeacherError('Error al cargar cursos gratuitos: ${e.toString()}'));
    }
  }

  Future<void> _onLoadPaidCourses(
    LoadPaidCourses event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final courses = await _getPaidCoursesUseCase();
      emit(TeacherLoaded(courses: courses));
    } catch (e) {
      emit(TeacherError('Error al cargar cursos de pago: ${e.toString()}'));
    }
  }

  Future<void> _onLoadCourseById(
    LoadCourseById event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final course = await _getCourseByIdUseCase(event.courseId);
      emit(TeacherLoaded(courses: [course]));
    } catch (e) {
      emit(TeacherError('Error al cargar el curso: ${e.toString()}'));
    }
  }

  Future<void> _onSearchCourses(
    SearchCourses event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final courses = await _searchCoursesUseCase(event.query);
      emit(TeacherLoaded(courses: courses));
    } catch (e) {
      emit(TeacherError('Error al buscar cursos: ${e.toString()}'));
    }
  }

  Future<void> _onLoadTeacherArticles(
    LoadTeacherArticles event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final articles = await _getTeacherArticlesUseCase(event.teacherId);
      emit(TeacherLoaded(articles: articles));
    } catch (e) {
      emit(TeacherError('Error al cargar artículos: ${e.toString()}'));
    }
  }

  Future<void> _onLoadFeaturedArticles(
    LoadFeaturedArticles event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final articles = await _getFeaturedArticlesUseCase();
      emit(TeacherLoaded(articles: articles));
    } catch (e) {
      emit(
        TeacherError('Error al cargar artículos destacados: ${e.toString()}'),
      );
    }
  }

  Future<void> _onLoadLatestArticles(
    LoadLatestArticles event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final articles = await _getLatestArticlesUseCase();
      emit(TeacherLoaded(articles: articles));
    } catch (e) {
      emit(
        TeacherError('Error al cargar artículos recientes: ${e.toString()}'),
      );
    }
  }

  Future<void> _onLoadArticleById(
    LoadArticleById event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final article = await _getArticleByIdUseCase(event.articleId);
      emit(TeacherLoaded(articles: [article]));
    } catch (e) {
      emit(TeacherError('Error al cargar el artículo: ${e.toString()}'));
    }
  }

  Future<void> _onSearchArticles(
    SearchArticles event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final articles = await _searchArticlesUseCase(event.query);
      emit(TeacherLoaded(articles: articles));
    } catch (e) {
      emit(TeacherError('Error al buscar artículos: ${e.toString()}'));
    }
  }

  Future<void> _onPurchaseCourse(
    PurchaseCourse event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final success = await _purchaseCourseUseCase(
        event.courseId,
        event.amount,
      );
      if (success) {
        emit(
          CoursePurchaseSuccess(
            courseId: event.courseId,
            transactionHash: 'tx_${DateTime.now().millisecondsSinceEpoch}',
          ),
        );
      } else {
        emit(CoursePurchaseError('Error al comprar el curso'));
      }
    } catch (e) {
      emit(CoursePurchaseError('Error al comprar el curso: ${e.toString()}'));
    }
  }

  Future<void> _onLoadUserPurchases(
    LoadUserPurchases event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final purchases = await _getUserPurchasesUseCase();
      emit(TeacherLoaded(purchases: purchases));
    } catch (e) {
      emit(TeacherError('Error al cargar compras: ${e.toString()}'));
    }
  }

  Future<void> _onCheckCoursePurchased(
    CheckCoursePurchased event,
    Emitter<TeacherState> emit,
  ) async {
    try {
      final isPurchased = await _isCoursePurchasedUseCase(event.courseId);
      emit(TeacherLoaded(isCoursePurchased: isPurchased));
    } catch (e) {
      emit(TeacherError('Error al verificar compra: ${e.toString()}'));
    }
  }
}
