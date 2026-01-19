import 'package:flutter/material.dart';

class SeatMapThumbnail extends StatelessWidget {
  final double width;
  final double height;

  const SeatMapThumbnail({
    super.key,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/images/theater.png',
      width: width,
      height: height,
    );
  }
}

