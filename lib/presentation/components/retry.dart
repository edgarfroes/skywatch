import 'package:flutter/material.dart';

class Retry extends StatelessWidget {
  const Retry({super.key, required this.onRetry});

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: IconButton(
        onPressed: onRetry,
        icon: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Try again'),
              Icon(Icons.refresh),
            ],
          ),
        ),
      ),
    );
  }
}
