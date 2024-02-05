import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncValuesModalOnLoad<dynamic> extends ConsumerWidget {
  const AsyncValuesModalOnLoad({super.key, required this.providers, required this.child});
  // covariant is used to allow the type of the providers to be different, since we don't care about the type
  final List<covariant ProviderListenable<AsyncValue<dynamic>>> providers;
  final Widget child;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    Iterable<AsyncValue<dynamic>> values = providers.map((e) => ref.watch(e));

    if (values.any((element) => element is AsyncLoading)) {
      return Stack(
        children: [
          IgnorePointer(
            child: child,
          ),
          
          Positioned.fill(
            child: Container(
              color: Colors.grey.withOpacity(0.4),
              child: const Center(
                child: CircularProgressIndicator(
                  color: Colors.black
                ),
              ),
            ),
          )
        ],
      );
    }
    return child;
  }
}
