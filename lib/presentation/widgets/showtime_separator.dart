import 'package:flutter/material.dart';

class ShowtimeSeparator extends StatelessWidget {
  final Color color;

  const ShowtimeSeparator({
    super.key,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    // Provides a clean visual separation between horizontal cards.
    return SizedBox(
      width: 18,
      child: Center(
        child: SizedBox(
          height: 120,
          child: VerticalDivider(
            width: 18,
            thickness: 1,
            color: color,
          ),
        ),
      ),
    );
  }
}
