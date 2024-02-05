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
          loading: onLoading,
          error: onError,
        );
  }

  Widget onData(T data);

  Widget onLoading() {
    return const Center(child: CircularProgressIndicator());
  }

  Widget onError(Object error, StackTrace stackTrace) {
    return Center(
      child: Text(
        error.toString(),
        style: Theme.of(context).textTheme.titleLarge?.copyWith(color: Colors.red),
      ),
    );
  }

  ProviderListenable<AsyncValue<T>> get provider;

  @override
  bool get wantKeepAlive => false;
}
