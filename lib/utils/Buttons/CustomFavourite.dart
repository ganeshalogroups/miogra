

// ignore_for_file: file_names

import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';

class FavoriteIcon extends StatefulWidget {
  final bool isFavorite;
  final VoidCallback onTap;
  final Color color;

  const FavoriteIcon({super.key, required this.isFavorite, required this.onTap, this.color =Colors.red});

  @override
  FavoriteIconState createState() => FavoriteIconState();
}

class FavoriteIconState extends State<FavoriteIcon> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    )..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        }
      });
  }

  @override
  void didUpdateWidget(covariant FavoriteIcon oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isFavorite != oldWidget.isFavorite) {
      _controller.forward();
    }
  }

    @override
    void dispose() {
      _controller.dispose();
      super.dispose();
    }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Icon(
          widget.isFavorite ? Icons.favorite : Icons.favorite_border,
          color: widget.isFavorite ? widget.color : Customcolors.DECORATION_GREY,
        ),
      ),
    );
  }
}
