import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'core/util/injection.dart' as di;
import 'core/storage/token_storage.dart';
import 'features/auth/domain/usecases/get_profile_usecase.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'core/util/routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  final tokenStorage = sl<TokenStorage>();
  if (tokenStorage.hasToken) {
    try {
      await sl<GetProfileUseCase>()();
    } catch (e) {
      await tokenStorage.clear();
    }
  }

  final authBloc = AuthBloc(
    loginUseCase: sl(),
    registerUseCase: sl(),
    getProfileUseCase: sl(),
    logoutUseCase: sl(),
  );

  runApp(
    BlocProvider<AuthBloc>.value(
      value: authBloc,
      child: const MyApp(),
    ),
  );}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: AppRoutes.router,
      title: 'Somni',
      theme: FlexThemeData.dark(scheme: FlexScheme.shadViolet, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.shadViolet, useMaterial3: true),
      themeMode: ThemeMode.system,
    );
  }
}