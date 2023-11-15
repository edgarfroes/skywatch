import 'package:flutter/material.dart';

class ConditionalBuilder extends StatelessWidget {
  const ConditionalBuilder({
    super.key,
    required this.condition,
    required this.child,
    required this.builder,
    this.fallback,
  });

  final bool condition;
  final Widget child;
  final Widget Function(BuildContext context, Widget child) builder;
  final Widget Function(BuildContext context, Widget child)? fallback;

  @override
  Widget build(BuildContext context) {
    return condition
        ? builder(context, child)
        : fallback?.call(context, child) ?? child;
  }
}
