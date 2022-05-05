import 'package:flutter/material.dart';
import 'package:spring/spring.dart';

class CardWidget extends StatelessWidget {
  final Widget child;

  const CardWidget({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.only(
            left: 24.0, right: 24.0, bottom: 128.0, top: 32.0),
        child: Spring.fadeIn(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
