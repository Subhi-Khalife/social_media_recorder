import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowShadow2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.shade100,
            gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [
              Colors.grey.shade100,
              Colors.grey.shade100.withOpacity(0.2),
            ])),
      ),
    );
  }
}
