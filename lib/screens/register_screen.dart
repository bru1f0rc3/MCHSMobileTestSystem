import 'package:flutter/material.dart';
import '../widgets/glow_container.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _emailController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      body: Stack(
        children: [
          // Фоновые декоративные круги
          _buildBackgroundCircles(isDark),
          
          // Основной контент
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 40),
                    
                    // Стеклянная карточка с формой
                    GlassContainer(
                      opacity: isDark ? 0.15 : 0.3,
                      blur: 20,
                      borderRadius: BorderRadius.circular(30),
                      child: Container(
                        padding: const EdgeInsets.all(32.0),
                        child: Form(
                          key: _formKey,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // Иконка с градиентом
                              Container(
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  gradient: LinearGradient(
                                    colors: [
                                      theme.colorScheme.secondary,
                                      theme.colorScheme.secondary.withOpacity(0.6),
                                    ],
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: theme.colorScheme.secondary.withOpacity(0.4),
                                      blurRadius: 20,
                                      spreadRadius: 5,
                                    ),
                                  ],
                                ),
                                child: const Icon(
                                  Icons.person_add_rounded,
                                  size: 48,
                                  color: Colors.white,
                                ),
                              ),
                              
                              const SizedBox(height: 24),
                              
                              // Заголовок с переключением
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  _buildTabButton(
                                    text: 'Авторизация',
                                    isSelected: false,
                                    isDark: isDark,
                                    theme: theme,
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                  ),
                                  const SizedBox(width: 16),
                                  _buildTabButton(
                                    text: 'Регистрация',
                                    isSelected: true,
                                    isDark: isDark,
                                    theme: theme,
                                    onTap: () {},
                                  ),
                                ],
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Поле Имя пользователя
                              _buildTextField(
                                controller: _usernameController,
                                icon: Icons.account_circle_rounded,
                                label: 'Имя пользователя',
                                hint: 'ivanov_ivan',
                                isDark: isDark,
                                theme: theme,
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Поле Email
                              _buildTextField(
                                controller: _emailController,
                                icon: Icons.email_rounded,
                                label: 'Электронная почта',
                                hint: 'ivanov@example.com',
                                isDark: isDark,
                                theme: theme,
                                keyboardType: TextInputType.emailAddress,
                              ),
                              
                              const SizedBox(height: 20),
                              
                              // Поле Пароль
                              _buildPasswordField(
                                controller: _passwordController,
                                isDark: isDark,
                                theme: theme,
                              ),
                              
                              const SizedBox(height: 32),
                              
                              // Кнопка регистрации с свечением
                              AnimatedGlowButton(
                                text: 'Зарегистрироваться',
                                glowColor: theme.colorScheme.secondary,
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    // Логика регистрации
                                    print('Register: ${_usernameController.text}');
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBackgroundCircles(bool isDark) {
    final color1 = isDark ? const Color(0xFF457B9D) : const Color(0xFF457B9D); // Синий
    final color2 = isDark ? const Color(0xFF1D3557) : const Color(0xFF1D3557); // Темно-синий
    final color3 = isDark ? const Color(0xFFE63946) : const Color(0xFFE63946); // Красный МЧС
    
    return Stack(
      children: [
        // Большой круг сверху слева
        Positioned(
          top: -100,
          left: -100,
          child: Container(
            width: 280,
            height: 280,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color1.withOpacity(0.5),
                  color1.withOpacity(0.2),
                  color1.withOpacity(0.05),
                ],
                stops: const [0.3, 0.6, 1.0],
              ),
            ),
          ),
        ),
        // Средний круг сверху справа
        Positioned(
          top: -50,
          right: -80,
          child: Container(
            width: 220,
            height: 220,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color2.withOpacity(0.4),
                  color2.withOpacity(0.2),
                  color2.withOpacity(0.05),
                ],
                stops: const [0.2, 0.6, 1.0],
              ),
            ),
          ),
        ),
        // Маленькие декоративные круги
        Positioned(
          top: 150,
          right: 30,
          child: Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color3.withOpacity(0.3),
                  color3.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),
        // Большой круг снизу слева
        Positioned(
          bottom: -150,
          left: -120,
          child: Container(
            width: 380,
            height: 380,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color1.withOpacity(0.6),
                  color1.withOpacity(0.3),
                  color1.withOpacity(0.1),
                  color1.withOpacity(0.0),
                ],
                stops: const [0.0, 0.4, 0.7, 1.0],
              ),
            ),
          ),
        ),
        // Средний круг снизу справа
        Positioned(
          bottom: -80,
          right: 20,
          child: Container(
            width: 180,
            height: 180,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color2.withOpacity(0.4),
                  color2.withOpacity(0.2),
                  color2.withOpacity(0.05),
                ],
              ),
            ),
          ),
        ),
        // Дополнительные маленькие круги для объема
        Positioned(
          bottom: 200,
          left: 40,
          child: Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: RadialGradient(
                colors: [
                  color3.withOpacity(0.3),
                  color3.withOpacity(0.0),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTabButton({
    required String text,
    required bool isSelected,
    required bool isDark,
    required ThemeData theme,
    required VoidCallback onTap,
  }) {
    final color = isSelected ? theme.colorScheme.secondary : theme.primaryColor;
    
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          gradient: isSelected
              ? LinearGradient(
                  colors: [
                    color,
                    color.withOpacity(0.7),
                  ],
                )
              : null,
          color: isSelected ? null : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: isSelected
                ? Colors.transparent
                : (isDark ? Colors.white24 : Colors.black26),
            width: 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ]
              : null,
        ),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected
                ? Colors.white
                : (isDark ? Colors.white70 : Colors.black54),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required IconData icon,
    required String label,
    required String hint,
    required bool isDark,
    required ThemeData theme,
    TextInputType? keyboardType,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  icon,
                  size: 18,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                label,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                color: isDark 
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.3),
                fontWeight: FontWeight.normal,
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, заполните это поле';
              }
              if (label == 'Электронная почта' && !value.contains('@')) {
                return 'Введите корректный email';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }

  Widget _buildPasswordField({
    required TextEditingController controller,
    required bool isDark,
    required ThemeData theme,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(6),
                decoration: BoxDecoration(
                  color: theme.colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Icon(
                  Icons.lock_rounded,
                  size: 18,
                  color: theme.colorScheme.secondary,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'Пароль',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: theme.colorScheme.secondary.withOpacity(0.1),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: TextFormField(
            controller: controller,
            obscureText: _obscurePassword,
            style: TextStyle(
              color: isDark ? Colors.white : Colors.black87,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
            decoration: InputDecoration(
              hintText: '••••••••••••',
              hintStyle: TextStyle(
                color: isDark 
                    ? Colors.white.withOpacity(0.3)
                    : Colors.black.withOpacity(0.3),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword 
                      ? Icons.visibility_off_rounded 
                      : Icons.visibility_rounded,
                  color: theme.colorScheme.secondary.withOpacity(0.7),
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Пожалуйста, введите пароль';
              }
              if (value.length < 6) {
                return 'Пароль должен быть не менее 6 символов';
              }
              return null;
            },
          ),
        ),
      ],
    );
  }
}
