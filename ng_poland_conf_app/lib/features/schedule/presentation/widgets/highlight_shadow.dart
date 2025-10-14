import 'package:flutter/material.dart';

class HighlightShadow extends StatefulWidget {
  final Widget child;
  final bool isDarkMode;
  final bool animate;

  const HighlightShadow({
    super.key,
    required this.child,
    required this.isDarkMode,
    required this.animate,
  });

  @override
  State<HighlightShadow> createState() => _HighlightShadowState();
}

class _HighlightShadowState extends State<HighlightShadow> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<Color?> _shadowColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(
        seconds: 3,
      ),
    );
    if (widget.animate) {
      _controller.repeat(
        reverse: true,
      );
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final theme = Theme.of(context);
    final primary = widget.isDarkMode ? theme.primaryColor.withOpacity(0.8) : theme.primaryColor.withOpacity(0.4);
    final secondary = widget.isDarkMode ? theme.colorScheme.secondary.withOpacity(0.8) : theme.colorScheme.secondary.withOpacity(0.4);
    _shadowColor = ColorTween(begin: primary, end: secondary).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeIn,
      ),
    );
  }

  @override
  void didUpdateWidget(covariant HighlightShadow oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.animate != oldWidget.animate) {
      widget.animate
          ? _controller.repeat(
              reverse: true,
            )
          : _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _shadowColor,
      builder: (_, child) {
        return Container(
          decoration: BoxDecoration(
            boxShadow: [
              BoxShadow(
                color: _shadowColor.value ?? Colors.transparent,
                blurRadius: 50,
                offset: const Offset(0, 0),
              ),
            ],
          ),
          child: child,
        );
      },
      child: widget.child,
    );
  }
}
