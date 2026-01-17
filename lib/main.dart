import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'core/injection.dart' as di;
import 'core/storage/token_storage.dart';
import 'features/auth/domain/usecases/get_profile_usecase.dart';
import 'routes.dart';


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
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: AppRoutes.router,
      title: 'Somni',
      theme: FlexThemeData.dark(scheme: FlexScheme.shadViolet, useMaterial3: true),
      darkTheme: FlexThemeData.dark(scheme: FlexScheme.shadViolet, useMaterial3: true),
      themeMode: ThemeMode.system,
    );
  }
}