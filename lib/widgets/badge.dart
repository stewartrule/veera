import 'package:flutter/material.dart';

class Badge extends StatelessWidget {
  final int count;
  final double size;

  Badge({
    this.count,
    this.size = 16,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Colors.blue.shade400,
            Colors.blue,
          ],
        ),
      ),
      child: Text(
        count.toString(),
        style: TextStyle(color: Colors.white),
        textAlign: TextAlign.center,
      ),
    );
  }
}
