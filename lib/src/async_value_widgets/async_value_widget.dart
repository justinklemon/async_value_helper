import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'async_value_consumer_widget.dart';

class AsyncValueWidget<T> extends AsyncValueConsumerWidget<T> {
  final Widget Function(BuildContext context, WidgetRef ref, T data) _onData;
  final Widget Function(BuildContext context, WidgetRef ref)? _onLoading;
  final Widget Function(BuildContext context, WidgetRef ref, Object error,
      StackTrace stackTrace)? _onError;
  @override
  final ProviderListenable<AsyncValue<T>> provider;
  const AsyncValueWidget({
    required Widget Function(BuildContext context, WidgetRef ref, T data)
        onData,
    Widget Function(BuildContext context, WidgetRef ref)? onLoading,
    Widget Function(BuildContext context, WidgetRef ref, Object error,
            StackTrace stackTrace)?
        onError,
    required this.provider,
    super.key,
  })  : _onData = onData,
        _onLoading = onLoading,
        _onError = onError;

  @override
  Widget onData(BuildContext context, WidgetRef ref, T data) {
    return _onData(context, ref, data);
  }

  @override
  Widget onLoading(BuildContext context, WidgetRef ref) {
    if (_onLoading == null) {
      return super.onLoading(context, ref);
    }
    return _onLoading!(context, ref);
  }

  @override
  Widget onError(BuildContext context, WidgetRef ref, Object error,
      StackTrace stackTrace) {
    if (_onError == null) {
      return super.onError(context, ref, error, stackTrace);
    }
    return _onError!(context, ref, error, stackTrace);
  }
}
