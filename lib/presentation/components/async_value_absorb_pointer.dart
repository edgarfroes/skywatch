import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class AsyncValueAbsorbPointer extends StatelessWidget {
  const AsyncValueAbsorbPointer({
    super.key,
    required this.async,
    required this.child,
  });

  final AsyncValue async;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: async.isLoading || async.isRefreshing || async.isReloading,
      child: child,
    );
  }
}
