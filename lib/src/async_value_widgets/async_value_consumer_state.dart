import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class AsyncValueConsumerState<T, W extends ConsumerStatefulWidget>
    extends ConsumerState<W> with AutomaticKeepAliveClientMixin {
  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return ref.watch(provider).when(
          data: (data) => onData(data),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (
            e,
            _,
          ) =>
              Center(
            child: Text(
              e.toString(),
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(color: Colors.red),
            ),
          ),
        );
  }

  Widget onData(T data);

  ProviderListenable<AsyncValue<T>> get provider;

  @override
  bool get wantKeepAlive => false;
}
