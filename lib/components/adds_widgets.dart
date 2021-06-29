import 'package:flutter/material.dart';

class AddsWidgets extends StatelessWidget {
  final Widget? myWidget;
  const AddsWidgets({Key? key, this.myWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Container(
        height: 50,
        width: double.infinity,
        child: Center(
          child: myWidget,
        ),
      ),
    );
  }
}
