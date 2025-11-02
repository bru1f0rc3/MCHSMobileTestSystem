import 'package:flutter/material.dart';
import 'dart:async';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late AnimationController _fadeController;
  late AnimationController _scaleController;
  late AnimationController _rotateController;
  late Animation<double> _fadeAnimation;
  late Animation<double> _scaleAnimation;
  late Animation<double> _rotateAnimation;

  @override
  void initState() {
    super.initState();

    // Анимация затухания
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    // Анимация масштабирования
    _scaleController = AnimationController(
      duration: const Duration(milliseconds: 1200),
      vsync: this,
    );

    // Анимация вращения для звезды
    _rotateController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeIn),
    );

    _scaleAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.elasticOut),
    );

    _rotateAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _rotateController, curve: Curves.easeInOut),
    );

    // Запуск анимаций
    _fadeController.forward();
    _scaleController.forward();
    _rotateController.forward();

    // Переход на главный экран через 3 секунды
    Timer(const Duration(seconds: 3), () {
      if (mounted) {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
  }

  @override
  void dispose() {
    _fadeController.dispose();
    _scaleController.dispose();
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: isDark
                ? [
                    const Color(0xFF0D1B2A),
                    const Color(0xFF1B263B),
                    const Color(0xFF415A77),
                  ]
                : [
                    const Color(0xFFE63946),
                    const Color(0xFFF1FAEE),
                    const Color(0xFFA8DADC),
                  ],
          ),
        ),
        child: Stack(
          children: [
            // Декоративные элементы на фоне
            _buildBackgroundElements(isDark),

            // Основной контент
            Center(
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Логотип МЧС с анимацией
                    ScaleTransition(
                      scale: _scaleAnimation,
                      child: _buildMCHSLogo(isDark),
                    ),

                    const SizedBox(height: 40),

                    // Название приложения
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: Column(
                        children: [
                          Text(
                            'Система тестирования',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: isDark ? Colors.white : const Color(0xFF1D3557),
                              letterSpacing: 1.2,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'МЧС России',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: isDark
                                  ? const Color(0xFFE63946)
                                  : const Color(0xFFE63946),
                              letterSpacing: 2,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: isDark
                                  ? Colors.white.withOpacity(0.1)
                                  : Colors.black.withOpacity(0.05),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: isDark
                                    ? Colors.white.withOpacity(0.2)
                                    : Colors.black.withOpacity(0.1),
                              ),
                            ),
                            child: Text(
                              'Профессиональная подготовка',
                              style: TextStyle(
                                fontSize: 14,
                                color: isDark ? Colors.white70 : const Color(0xFF415A77),
                                letterSpacing: 0.5,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 60),

                    // Индикатор загрузки
                    _buildLoadingIndicator(isDark),
                  ],
                ),
              ),
            ),

            // Версия внизу
            Positioned(
              bottom: 40,
              left: 0,
              right: 0,
              child: FadeTransition(
                opacity: _fadeAnimation,
                child: Center(
                  child: Text(
                    'Версия 1.0.0',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark
                          ? Colors.white.withOpacity(0.5)
                          : Colors.black.withOpacity(0.4),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMCHSLogo(bool isDark) {
    return Container(
      width: 160,
      height: 160,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
          colors: [
            const Color(0xFFE63946).withOpacity(0.3),
            const Color(0xFFE63946).withOpacity(0.1),
            Colors.transparent,
          ],
        ),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFE63946).withOpacity(0.3),
            blurRadius: 30,
            spreadRadius: 10,
          ),
        ],
      ),
      child: Container(
        margin: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isDark ? const Color(0xFF1B263B) : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 20,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [
            // Вращающаяся звезда
            RotationTransition(
              turns: _rotateAnimation,
              child: Icon(
                Icons.star,
                size: 80,
                color: const Color(0xFFE63946).withOpacity(0.2),
              ),
            ),
            // Основная иконка МЧС
            Icon(
              Icons.local_fire_department_rounded,
              size: 70,
              color: const Color(0xFFE63946),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLoadingIndicator(bool isDark) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          SizedBox(
            width: 40,
            height: 40,
            child: CircularProgressIndicator(
              strokeWidth: 3,
              valueColor: AlwaysStoppedAnimation<Color>(
                isDark ? const Color(0xFFE63946) : const Color(0xFFE63946),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Загрузка...',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: isDark ? Colors.white70 : const Color(0xFF415A77),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundElements(bool isDark) {
    final color = isDark ? const Color(0xFFE63946) : const Color(0xFF457B9D);

    return Stack(
      children: [
        // Круг сверху слева
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Круг снизу справа
        Positioned(
          bottom: -150,
          right: -100,
          child: Container(
            width: 350,
            height: 350,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color.withOpacity(0.3),
                  color.withOpacity(0.1),
                  Colors.transparent,
                ],
              ),
            ),
          ),
        ),
        // Маленькие иконки-декорации
        Positioned(
          top: 150,
          right: 50,
          child: Icon(
            Icons.shield_outlined,
            size: 60,
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.03),
          ),
        ),
        Positioned(
          bottom: 200,
          left: 40,
          child: Icon(
            Icons.emergency_outlined,
            size: 50,
            color: isDark
                ? Colors.white.withOpacity(0.05)
                : Colors.black.withOpacity(0.03),
          ),
        ),
      ],
    );
  }
}
