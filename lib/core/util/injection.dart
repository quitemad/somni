import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:somni/features/calendar/domain/usecases/calendar_add_notes_usecase.dart';
import 'package:somni/features/calendar/domain/usecases/calendar_get_day_detalis_usecase.dart';
import 'package:somni/features/calendar/domain/usecases/calendar_get_month_usecase.dart';
import 'package:somni/features/calendar/domain/usecases/calendar_update_task_status_usecase.dart';
import 'package:somni/features/stressdetection/domain/usecases/detect_stress_from_image_usecase.dart';

import '../../features/auth/data/datasources/auth_remote_data_source_impl.dart';
import '../../features/auth/data/datasources/auth_remote_data_source.dart';
import '../../features/auth/data/repository/auth_repository_impl.dart';
import '../../features/auth/domain/repository/auth_repository.dart';
import '../../features/auth/domain/usecases/login_usecase.dart';
import '../../features/auth/domain/usecases/register_usecase.dart';
import '../../features/auth/domain/usecases/get_profile_usecase.dart';
import '../../features/auth/domain/usecases/logout_usecase.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

import '../../features/calendar/data/datasources/calendar_remote_datasource.dart';
import '../../features/calendar/data/datasources/calendar_remote_datasource_impl.dart';
import '../../features/calendar/data/repositories/calendar_repository_impl.dart';
import '../../features/calendar/domain/repositories/calendar_repository.dart';
import '../../features/calendar/presentation/bloc/calendar_bloc.dart';
import '../../features/chatbot/data/datasources/chatbot_remote_datasource.dart';
import '../../features/chatbot/data/datasources/chatbot_remote_datasource_impl.dart';
import '../../features/chatbot/domain/repositories/chatbot_repository.dart';
import '../../features/chatbot/domain/usecases/start_session_usecase.dart';
import '../../features/chatbot/domain/usecases/submit_answe_usecase.dart';
import '../../features/chatbot/presentation/bloc/chatbot_bloc.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source.dart';
import '../../features/dashboard/data/datasources/dashboard_remote_data_source_impl.dart';
import '../../features/dashboard/data/repositories/dashboard_repository_impl.dart';
import '../../features/dashboard/domain/reposiotries/dashboard_repository.dart';
import '../../features/dashboard/domain/usecases/get_daily_metrics_usecase.dart';
import '../../features/dashboard/domain/usecases/get_dashboard_usecase.dart';
import '../../features/dashboard/domain/usecases/get_weekly_scores_usecause.dart';
import '../../features/dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../features/music/data/datasources/music_remote_datasource.dart';
import '../../features/music/data/datasources/music_remote_datasource_impl.dart';
import '../../features/music/data/repositories/music_repository_impl.dart';
import '../../features/music/domain/repositories/music_repository.dart';
import '../../features/music/domain/usecases/predict_music_usecase.dart';
import '../../features/music/presentation/bloc/music_bloc.dart';
import '../../features/sleep/data/datasources/sleep_remote_data_source.dart';
import '../../features/sleep/data/repositories/sleep_repository.dart';
import '../../features/stressdetection/data/datasources/stress_remote_datasource.dart';
import '../../features/stressdetection/data/datasources/stress_remote_datasource_impl.dart';
import '../../features/stressdetection/data/repositories/stress_repository_impl.dart';
import '../../features/stressdetection/domain/repositories/stress_repository.dart';
import '../../features/stressdetection/presentation/bloc/stess_bloc.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // SharedPreferences (async)
  final prefs = await SharedPreferences.getInstance();

  // Register the obtained SharedPreferences instance so sl<SharedPreferences>() works
  sl.registerSingleton<SharedPreferences>(prefs);

  // Core
  sl.registerLazySingleton(() => DioClient()); // assumes your DioClient has default constructor

  // Token storage (depends on DioClient). Passing prefs directly into TokenStorage constructor is OK.
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage(prefs, sl<DioClient>()));
  // initialize token storage (load existing token into Dio headers)
  await sl<TokenStorage>().init();

  // Data sources
  sl.registerLazySingleton<AuthRemoteDataSource>(() => AuthRemoteDataSourceImpl(sl<DioClient>().dio));

  // Repositories (AuthRepositoryImpl now expects TokenStorage)
  sl.registerLazySingleton<AuthRepository>(
        () => AuthRepositoryImpl(sl<AuthRemoteDataSource>(), sl<DioClient>(), sl<TokenStorage>()),
  );

  // Use cases
  sl.registerLazySingleton(() => LoginUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => RegisterUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => GetProfileUseCase(sl<AuthRepository>()));
  sl.registerLazySingleton(() => LogoutUseCase(sl<AuthRepository>()));

  // Auth Bloc
  sl.registerFactory(
        () => AuthBloc(
      loginUseCase: sl<LoginUseCase>(),
      registerUseCase: sl<RegisterUseCase>(),
      getProfileUseCase: sl<GetProfileUseCase>(),
      logoutUseCase: sl<LogoutUseCase>(),
    ),
  );

  // Dashboard registrations
  sl.registerLazySingleton<DashboardRemoteDataSource>(() => DashboardRemoteDataSourceImpl(sl<DioClient>().dio));
  sl.registerLazySingleton<DashboardRepository>(() => DashboardRepositoryImpl(sl<DashboardRemoteDataSource>()));
  sl.registerLazySingleton(() => GetDashboardUseCase(sl<DashboardRepository>()));
  sl.registerLazySingleton(() => GetWeeklyScoresUseCase(sl<DashboardRepository>()));
  sl.registerLazySingleton(() => GetDailyMetricsUseCase(sl<DashboardRepository>()));
  sl.registerFactory(
        () => DashboardBloc(
      getDashboard: sl<GetDashboardUseCase>(),
      getWeeklyScores: sl<GetWeeklyScoresUseCase>(),
      getDailyMetrics: sl<GetDailyMetricsUseCase>(),
    ),
  );

  // Sleep registrations (SharedPreferences is already registered above)
  sl.registerLazySingleton(() => SleepRemoteDataSource(sl<DioClient>().dio));
  sl.registerLazySingleton<SleepRepository>(() => SleepRepository(sl<SleepRemoteDataSource>(), sl<SharedPreferences>()));



  // Data source
  sl.registerLazySingleton<ChatbotRemoteDataSource>(
        () => ChatbotRemoteDataSource(sl<DioClient>().dio),
  );

  // Repository
  sl.registerLazySingleton<ChatbotRepository>(
        () => ChatbotRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => StartSessionUseCase(sl()));
  sl.registerLazySingleton(() => SubmitAnswerUseCase(sl()));

  // Bloc
  sl.registerFactory(
        () => ChatbotBloc(
      startUseCase: sl(),
      submitUseCase: sl(),
    ),
  );


  // =========================
  // Calendar Feature
  // =========================

  // Data source
  sl.registerLazySingleton<CalendarRemoteDataSource>(
        () => CalendarRemoteDataSourceImpl(sl<DioClient>().dio),
  );

  // Repository
  sl.registerLazySingleton<CalendarRepository>(
        () => CalendarRepositoryImpl(sl<CalendarRemoteDataSource>()),
  );

  // Use cases
  sl.registerLazySingleton(() => GetMonthCalendarUseCase(sl<CalendarRepository>()));
  sl.registerLazySingleton(() => GetDayDetailsUseCase(sl<CalendarRepository>()));
  sl.registerLazySingleton(() => AddNoteUseCase(sl<CalendarRepository>()));
  sl.registerLazySingleton(() => UpdateTaskStatusUseCase(sl<CalendarRepository>()));

  // Bloc
  sl.registerFactory(
        () => CalendarBloc(
      getMonthCalendar: sl(),
      getDayDetails: sl(),
      addNote: sl(),
      updateTaskStatus: sl(),
    ),
  );

  // =========================
  // Stress Feature
  // =========================
  sl.registerLazySingleton<StressRemoteDataSource>(
        () => StressRemoteDataSourceImpl(sl<DioClient>().dio),
  );

  sl.registerLazySingleton<StressRepository>(
        () =>StressRepositoryImpl(sl<StressRemoteDataSource>()),
  );
  sl.registerLazySingleton(() => DetectStressFromImageUseCase(sl<StressRepository>()));

  sl.registerFactory(
        () => StressBloc(
      detectStress: sl(),
    ),
  );


  // =========================
// Music Feature
// =========================

  sl.registerLazySingleton<MusicRemoteDataSource>(
        () => MusicRemoteDataSourceImpl(sl<DioClient>().dio),
  );

  sl.registerLazySingleton<MusicRepository>(
        () => MusicRepositoryImpl(sl()),
  );

  sl.registerLazySingleton(
        () => PredictMusicUseCase(sl()),
  );

  sl.registerFactory(
        () => MusicBloc(
      predictMusic: sl(),
    ),
  );


}