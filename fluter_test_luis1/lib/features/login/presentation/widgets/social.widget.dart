import 'package:flutter/material.dart';

class SocialWidget extends StatelessWidget {
  const SocialWidget({super.key, required this.color, required this.imageAsset});

  final Color color; 
  final String imageAsset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color,
        shape: BoxShape.circle
      ),
      child: Center(
        child: Image.asset(
          imageAsset,
          width: 12,
          height: 12
        ),
      ),
    );
  }
}