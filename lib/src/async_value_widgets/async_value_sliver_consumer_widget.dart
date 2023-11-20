import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AsyncValueSliverConsumerWidget<T> extends ConsumerWidget {
  const AsyncValueSliverConsumerWidget({
    super.key,
  });

  @override
  @mustCallSuper
  Widget build(BuildContext context, WidgetRef ref) {
    return ref.watch(provider).when(
          data: (data) => onData(context, ref, data),
          loading: () => const SliverToBoxAdapter(
              child: Center(child: CircularProgressIndicator())),
          error: (
            e,
            _,
          ) =>
              SliverToBoxAdapter(
            child: Center(
              child: Text(
                e.toString(),
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(color: Colors.red),
              ),
            ),
          ),
        );
  }

  Widget onData(BuildContext context, WidgetRef ref, T data);

  ProviderListenable<AsyncValue<T>> get provider;
}
