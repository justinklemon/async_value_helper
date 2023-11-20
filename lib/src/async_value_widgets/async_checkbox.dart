import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'async_value_consumer_widget.dart';


class AsyncCheckbox extends AsyncValueConsumerWidget<bool> {
  final int id;
  final Widget title;
  final void Function(bool, int) onChanged;
  @override
  final ProviderListenable<AsyncValue<bool>> provider;

  const AsyncCheckbox(
      {super.key,
      required this.id,
      required this.provider,
      required this.title,
      required this.onChanged});

  @override
  Widget onData(BuildContext context, WidgetRef ref, bool data) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.zero,
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity:
          const VisualDensity(vertical: VisualDensity.minimumDensity),
      title: title,
      value: data,
      onChanged: (value) {
        if (value == null) return;
        onChanged(value, id);
      },
    );
  }
}
