import 'package:async_value_helper/async_value_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AsyncCheckboxList<T> extends ConsumerStatefulWidget {
  final ProviderListenable<AsyncValue<List<T>>> provider;
  final void Function(WidgetRef, T, bool) onChanged;
  final String Function(T) titleOf;
  final int Function(T) idOf;
  final ProviderListenable<AsyncValue<bool>> Function(T) isListItemCheckedProvider;
  final ScrollController? scrollController;
  final Widget Function(BuildContext)? onEmptyList; 
  final bool thumbVisibility;

  const AsyncCheckboxList(
      {super.key,
      required this.provider,
      required this.onChanged,
      required this.titleOf,
      required this.idOf,
      required this.isListItemCheckedProvider,
      this.scrollController,
      this.onEmptyList,
      this.thumbVisibility = true
    });

  @override
  ConsumerState createState() => _AsyncCheckboxListState<T>();
}

class _AsyncCheckboxListState<T> extends AsyncValueConsumerState<List<T>, AsyncCheckboxList<T>> {
  late final ScrollController _scrollController;

  @override
  ProviderListenable<AsyncValue<List<T>>> get provider => widget.provider;

  @override
  void initState() {
    super.initState();
    _scrollController = widget.scrollController ?? ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget onLoading() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.5,
      child: const Center(child: CircularProgressIndicator()),
    );
  }

  @override
  Widget onData(List<T> data) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.5,),
        child: Scrollbar(
          controller: _scrollController,
          thumbVisibility: widget.thumbVisibility,
          child: ListView.builder(
            shrinkWrap: true,
            controller: _scrollController,
            itemCount: data.length,
            itemBuilder: (context, index) {
              final item = data[index];
              return AsyncCheckbox(
                provider: widget.isListItemCheckedProvider(item),
                id: widget.idOf(item),
                title: Text(widget.titleOf(item)),
                onChanged: (value, id) => widget.onChanged(ref, item, value),
              );
            },
          ),
        ),
    );
  }

}