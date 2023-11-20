import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValuesModalOnLoad<T> extends ConsumerWidget {
  const AsyncValuesModalOnLoad({super.key, required this.providers});
  final List<ProviderListenable<AsyncValue<T>>> providers;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Iterable<AsyncValue<dynamic>> values = providers.map((e) => ref.watch(e));

    if (values.any((element) => element is AsyncLoading)) {
      return const Stack(
        children: [
          Opacity(
            opacity: 0.3,
            child: ModalBarrier(
              dismissible: false,
              color: Colors.grey,
            ),
          ),
          Center(
            child: CircularProgressIndicator(),
          )
        ],
      );
    }
    return const SizedBox.shrink();
  }
}
