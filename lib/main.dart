import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/register_screen.dart';
import 'utils/theme_provider.dart';
import 'widgets/glow_container.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ThemeProvider _themeProvider = ThemeProvider();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _themeProvider,
      builder: (context, child) {
        return MaterialApp(
          title: 'МЧС Тестирование',
          theme: _themeProvider.currentTheme,
          debugShowCheckedModeBanner: false,
          home: const SplashScreen(),
          routes: {
            '/home': (context) => MainScreen(themeProvider: _themeProvider),
            '/register': (context) => MainScreen(
              themeProvider: _themeProvider,
              showRegister: true,
            ),
          },
        );
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  final ThemeProvider themeProvider;
  final bool showRegister;

  const MainScreen({
    super.key, 
    required this.themeProvider,
    this.showRegister = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Stack(
        children: [
          // Фоновый градиент
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDark
                    ? [
                        const Color(0xFF000000),
                        const Color(0xFF1C1C1E),
                      ]
                    : [
                        const Color(0xFFE3F2FD),
                        const Color(0xFFF5F7FA),
                      ],
              ),
            ),
          ),
          showRegister ? const RegisterScreen() : const LoginScreen(),
          // Кнопка переключения темы
          Positioned(
            top: 40,
            right: 20,
            child: GlassContainer(
              opacity: isDark ? 0.1 : 0.2,
              blur: 10,
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () {
                    themeProvider.toggleTheme();
                  },
                  borderRadius: BorderRadius.circular(50),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    child: AnimatedSwitcher(
                      duration: const Duration(milliseconds: 300),
                      transitionBuilder: (child, animation) {
                        return RotationTransition(
                          turns: animation,
                          child: ScaleTransition(
                            scale: animation,
                            child: child,
                          ),
                        );
                      },
                      child: Icon(
                        isDark ? Icons.light_mode : Icons.dark_mode,
                        key: ValueKey(isDark),
                        color: Theme.of(context).colorScheme.primary,
                        size: 28,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
