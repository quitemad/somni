import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'core/injection.dart' as di;
import 'routes.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init(); // initialize DI, token storage, SharedPreferences
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