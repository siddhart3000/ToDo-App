import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/auth/auth_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'services/notification_service.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp();
    
    // Initialize notifications but don't let it crash the whole app if it fails
    try {
      await NotificationService().init();
    } catch (e) {
      debugPrint("Notification Init Error: $e");
    }

    runApp(
      const ProviderScope(
        child: ToDoApp(),
      ),
    );
  } catch (e) {
    debugPrint("Main Init Error: $e");
  }
}

class ToDoApp extends ConsumerStatefulWidget {
  const ToDoApp({super.key});

  @override
  ConsumerState<ToDoApp> createState() => _ToDoAppState();
}

class _ToDoAppState extends ConsumerState<ToDoApp> {
  bool _showSplash = true;

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authStateProvider);
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'ToDo App',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeMode,
      home: _showSplash
          ? SplashScreen(
              onFinished: () {
                setState(() {
                  _showSplash = false;
                });
              },
            )
          : authState.when(
              data: (user) => user != null ? const HomeScreen() : const AuthScreen(),
              loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
              error: (err, stack) => Scaffold(body: Center(child: Text('Error: $err'))),
            ),
    );
  }
}
