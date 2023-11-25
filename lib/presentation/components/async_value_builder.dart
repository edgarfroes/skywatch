import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:skywatch/presentation/extensions/build_context_extensions.dart';

class AsyncValueBuilder<T> extends ConsumerWidget {
  const AsyncValueBuilder({
    super.key,
    required this.async,
    required this.builder,
    this.errorBuilder,
    this.loadingBuilder,
    this.onDataCallback,
  });

  final AsyncValue<T> async;
  final Function(T data)? onDataCallback;
  final Widget Function(BuildContext context, T data) builder;
  final WidgetBuilder? errorBuilder;
  final WidgetBuilder? loadingBuilder;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return async.when(
      data: (data) {
        if (onDataCallback != null) {
          WidgetsBinding.instance.addPersistentFrameCallback(
            (timeStamp) {
              onDataCallback!(data);
            },
          );
        }

        return builder(context, data);
      },
      error: (Object error, StackTrace stackTrace) {
        return errorBuilder?.call(context) ?? Text(context.l10n.generic_error);
      },
      loading: () {
        return loadingBuilder?.call(context) ??
            const CircularProgressIndicator();
      },
    );
  }
}
