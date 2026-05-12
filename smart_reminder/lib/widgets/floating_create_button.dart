import 'package:flutter/material.dart';

class FloatingCreateButton extends StatelessWidget {
  const FloatingCreateButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add));
  }
}