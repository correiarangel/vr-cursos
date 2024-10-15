
import 'package:flutter/material.dart';

class VRAppSearchSelect<T> extends StatefulWidget {
  final List<T> items;
  final T? initialValue;
  final bool Function(T item, String text) filterDelegate;
  final Widget Function(
    BuildContext context,
    int index,
    T item,
  ) buildItemDelegate;

  const VRAppSearchSelect({
    super.key,
    required this.items,
    required this.filterDelegate,
    required this.buildItemDelegate,
    this.initialValue,
  });

  @override
  State<VRAppSearchSelect<T>> createState() => _VRAppSearchSelectState<T>();
}

class _VRAppSearchSelectState<T> extends State<VRAppSearchSelect<T>> {
  final TextEditingController searchTextFieldController =
      TextEditingController();

  T? itemSelected;
  late List<T> filtredItems;

  @override
  void initState() {
   itemSelected = widget.initialValue;

    filterItems("");
    searchTextFieldController
        .addListener(() => filterItems(searchTextFieldController.text));
    super.initState();
  }

  @override
  void dispose() {
    searchTextFieldController.dispose();
    super.dispose();
  }

  void sortItems() {
    filtredItems.sort((a, b) {
      if (a == itemSelected) {
        return -1;
      } else if (b == itemSelected) {
        return 1;
      } else {
        return 0;
      }
    });
  }

  void filterItems(String search) {
    setState(() {
      if (search.isEmpty) {
        filtredItems = List.from(widget.items);
      } else {
        filtredItems = widget.items
            .where(
              (element) => widget.filterDelegate(element, search),
            )
            .toList();
      }
      sortItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = (size.height / 100);
    final width = (size.width / 100);

    // ignore: use_colored_box
    return SizedBox(
      width: width * 95,
      height: height * 90,
      key: const Key("vr_search_select"),
      child: Padding(
        padding: MediaQuery.of(context).viewInsets,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Align(
                alignment: Alignment.topRight,
                child: ClipOval(
                  child: Material(
                    color: Colors.transparent,
                    child: IconButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(Icons.close),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: _SearchTextField(
                searchTextField: searchTextFieldController,
              ),
            ),
            Expanded(
              child: filtredItems.isEmpty
                  ? const Center(
                      child: Text('Resultado da busca'),
                    )
                  : ListView.builder(
                      itemCount: filtredItems.length,
                      itemBuilder: (context, index) {
                        final T item = filtredItems[index];
                        return RadioListTile<T>(
                          
                          value: item,
                          groupValue: itemSelected,
                          title: widget.buildItemDelegate(context, index, item),
                          onChanged: (value) {
                            setState(() {
                              itemSelected = value;
                            });
                            Navigator.of(context).pop(itemSelected);
                          },
                        );
                      },
                    ),
            )
          ],
        ),
      ),
    );
  }
}

class _SearchTextField extends StatelessWidget {
  const _SearchTextField({
    // ignore: unused_element
    super.key,
    required this.searchTextField,
  });

  final TextEditingController searchTextField;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchTextField,
      decoration: const InputDecoration(
        prefixIcon: Icon(Icons.search_outlined),
        /* enabledBorder:
            Theme.of(context).inputDecorationTheme.enabledBorder!.copyWith(
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ), */
      ),
    );
  }
}
