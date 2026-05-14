import 'package:flutter/material.dart';

class FloatingCreateButton extends StatelessWidget {
  final VoidCallback onPressed;

  const FloatingCreateButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: onPressed,
      icon: const Icon(Icons.add),
      label: const Text('New Note'),
    );
  }
}