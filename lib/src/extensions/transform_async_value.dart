import 'package:flutter_riverpod/flutter_riverpod.dart';

extension Transform<T> on AsyncValue<T> {
  AsyncValue<N> transform<N>(AsyncValue<N> Function(T) transform) {
    return when(
      data: (data) => transform(data),
      loading: () => const AsyncValue.loading(),
      error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
    );
  }
}