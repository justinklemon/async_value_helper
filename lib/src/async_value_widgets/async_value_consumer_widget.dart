// Generic AsyncValueWidget to work with values of type T
// Inspired by https://codewithandrea.com/articles/async-value-widget-riverpod/
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AsyncValueConsumerWidget<T> extends ConsumerWidget {
  const AsyncValueConsumerWidget({super.key});

  /// Do NOT override this method. Instead, override [onData].
  @override
  @mustCallSuper
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: (data) => onData(context, ref, data),
          loading: () => onLoading(context, ref),
          error: (
            e,
            _,
          ) =>
              onError(context, ref, e, _),
        );
  }

  Widget onData(BuildContext context, WidgetRef ref, T data);

  Widget onLoading(BuildContext context, WidgetRef ref) {
    return const Center(child: CircularProgressIndicator());
  }

  Widget onError(BuildContext context, WidgetRef ref, Object error,
      StackTrace stackTrace) {
    return Center(
      child: Text(
        error.toString(),
        style:
            Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
      ),
    );
  }

  ProviderListenable<AsyncValue<T>> get provider;
}
