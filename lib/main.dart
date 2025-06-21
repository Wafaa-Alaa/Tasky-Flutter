import 'package:flutter/material.dart';
import 'package:tas/core/themes/dark-theme.dart';
import 'package:tas/core/themes/light-theme.dart';
import 'package:tas/start.dart';
import 'package:tas/navigation-page.dart';
import 'package:tas/core/services/auth-service.dart';
import 'package:tas/core/themes/theme-controller.dart';
import 'package:tas/splash-screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final authService = AuthService();
  await ThemeController().loadTheme();
  
  runApp(MyApp(authService: authService));
}

class MyApp extends StatelessWidget {
  final AuthService authService;

  const MyApp({super.key, required this.authService});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController().themeNotifier,
      builder: (context, themeMode, _) {
        return MaterialApp(
          title: 'Your App Name',
          debugShowCheckedModeBanner: false,
          theme: lightTheme,
          darkTheme: darkTheme,
          themeMode: themeMode,
          home: AppLoader(authService: authService),
        );
      },
    );
  }
}

class AppLoader extends StatefulWidget {
  final AuthService authService;

  const AppLoader({super.key, required this.authService});

  @override
  State<AppLoader> createState() => _AppLoaderState();
}

class _AppLoaderState extends State<AppLoader> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _initializeApp();
  }

  Future<void> _initializeApp() async {
    await widget.authService.initialize();
    setState(() => _isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading 
        ? const SplashScreen() 
        : ValueListenableBuilder<String?>(
            valueListenable: widget.authService.authNotifier,
            builder: (context, username, _) {
              return username == null ?Start() : const NavigationPage();
            },
          );
  }
}