import 'package:flutter_riverpod/flutter_riverpod.dart';

extension DelayDispose on AutoDisposeRef {
  void delayDisposeForFuture(Future Function() future) {
    final link = keepAlive();
    // When the future completes, we dispose the provider but only if it is paused currently
    bool isPaused = false;

    onCancel(() {
      isPaused = true;
      future().then((value) {
        if (isPaused) {
          link.close();
        }
      });
    });

    onResume(() {
      isPaused = false;
    });
  }

  void delayDisposeForProviders(
      List<AutoDisposeAsyncNotifierProvider<dynamic, dynamic>> providers) {
    final link = keepAlive();
    bool isPaused = false;

    // Used to track if the providers are loading
    final List<bool> isLoading = List.filled(providers.length, false);

    void checkIfProvidersAreLoading() {
      if (isLoading.any((element) => element)) {
        return;
      }
      if (isPaused) {
        link.close();
      }
    }

    onCancel(() {
      isPaused = true;
      for (final provider in providers) {
        watch(provider).when(
            loading: () => isLoading[providers.indexOf(provider)] = true,
            data: (_) {
              isLoading[providers.indexOf(provider)] = false;
              checkIfProvidersAreLoading();
            },
            error: (_, __) {
              isLoading[providers.indexOf(provider)] = false;
              checkIfProvidersAreLoading();
            });
      }
      checkIfProvidersAreLoading();
    });

    onResume(() {
      isPaused = false;
    });
  }
}
