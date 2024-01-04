import 'package:error_alert_manager/error_alert_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

extension AsyncValueUI on AsyncValue {
  void showSnackBarOnError(BuildContext context) => whenOrNull(
      error: (error, stackTrace) => ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
                content: Text(error.toString()),
                backgroundColor: Colors.red,
                action: SnackBarAction(
                    label: 'Copy Error',
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Theme.of(context).colorScheme.onPrimary,
                    onPressed: () => Clipboard.setData(
                        ClipboardData(text: error.toString())))),
          ));


  /// Shows a dialog with the error message when the AsyncValue is an error.
  /// Will only work if the [ref] has a [ErrorAlertProvider] in its scope and there is a [DisplayDialogOnError] in the widget tree
  void showDialogOnError(WidgetRef ref) {
    whenOrNull(
        error: (error, stackTrace) => ref.read(errorAlertProvider.notifier).onError(error.toString()));
  }
}
