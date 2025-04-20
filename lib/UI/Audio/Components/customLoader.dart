import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  final Color color;
  final double size;
  final double strokeWidth;
  final Duration duration;

  const CustomLoader({
    Key? key,
    this.color = Colors.red,
    this.size = 50.0,
    this.strokeWidth = 4.0,
    this.duration = const Duration(milliseconds: 1200),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: size,
        height: size,
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(color),
          strokeWidth: strokeWidth,
        ),
      ),
    );
  }
}

// You can also create a breathing animation loader if you prefer
class BreathingCustomLoader extends StatefulWidget {
  final Color color;
  final double size;
  final Duration duration;

  const BreathingCustomLoader({
    Key? key,
    this.color = Colors.red,
    this.size = 50.0,
    this.duration = const Duration(milliseconds: 1500),
  }) : super(key: key);

  @override
  State<BreathingCustomLoader> createState() => _BreathingCustomLoaderState();
}

class _BreathingCustomLoaderState extends State<BreathingCustomLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: widget.duration,
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedBuilder(
        animation: _animation,
        builder: (context, child) {
          return Transform.scale(
            scale: _animation.value,
            child: SizedBox(
              width: widget.size,
              height: widget.size,
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(widget.color),
                strokeWidth: 4.0,
              ),
            ),
          );
        },
      ),
    );
  }
}