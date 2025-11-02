import 'dart:ui';
import 'package:flutter/material.dart';

class GlassContainer extends StatelessWidget {
  final Widget child;
  final double opacity;
  final double blur;
  final BorderRadius? borderRadius;
  final Border? border;

  const GlassContainer({
    super.key,
    required this.child,
    this.opacity = 0.1,
    this.blur = 10.0,
    this.borderRadius,
    this.border,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(opacity),
            borderRadius: borderRadius ?? BorderRadius.circular(15),
            border: border ??
                Border.all(
                  color: Colors.white.withOpacity(0.2),
                  width: 1.5,
                ),
          ),
          child: child,
        ),
      ),
    );
  }
}

class GlowContainer extends StatelessWidget {
  final Widget child;
  final Color glowColor;
  final double blurRadius;
  final double spreadRadius;
  final BorderRadius? borderRadius;

  const GlowContainer({
    super.key,
    required this.child,
    required this.glowColor,
    this.blurRadius = 20.0,
    this.spreadRadius = 5.0,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: borderRadius ?? BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: glowColor.withOpacity(0.5),
            blurRadius: blurRadius,
            spreadRadius: spreadRadius,
          ),
        ],
      ),
      child: child,
    );
  }
}

class GlassButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;

  const GlassButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(15),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.8),
                color.withOpacity(0.6),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(15),
            border: Border.all(
              color: Colors.white.withOpacity(0.2),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.3),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onPressed,
              borderRadius: BorderRadius.circular(15),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AnimatedGlowButton extends StatefulWidget {
  final String text;
  final VoidCallback onPressed;
  final Color glowColor;

  const AnimatedGlowButton({
    super.key,
    required this.text,
    required this.onPressed,
    required this.glowColor,
  });

  @override
  State<AnimatedGlowButton> createState() => _AnimatedGlowButtonState();
}

class _AnimatedGlowButtonState extends State<AnimatedGlowButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
    _animation = Tween<double>(begin: 10.0, end: 25.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: widget.glowColor.withOpacity(0.6),
                blurRadius: _animation.value,
                spreadRadius: _animation.value / 4,
              ),
            ],
          ),
          child: child,
        );
      },
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton(
          onPressed: widget.onPressed,
          child: Text(
            widget.text,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
