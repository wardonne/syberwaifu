import 'package:flutter/material.dart';

class BaseSelect<T> extends StatefulWidget {
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final String? labelText;
  final String? Function(dynamic value)? validator;
  final void Function(dynamic value)? onChanged;
  final void Function(dynamic value)? onSaved;
  final List<Widget> Function(BuildContext)? selectedItemBuilder;

  const BaseSelect({
    super.key,
    this.value,
    required this.items,
    this.labelText,
    this.validator,
    this.onChanged,
    this.onSaved,
    this.selectedItemBuilder,
  });

  BaseSelect.fromMap(
      {super.key,
      required Map<T, String> items,
      this.value,
      this.labelText,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.selectedItemBuilder})
      : items = items.entries.map<DropdownMenuItem<T>>((item) {
          return DropdownMenuItem<T>(value: item.key, child: Text(item.value));
        }).toList();

  BaseSelect.fromList(
      {super.key,
      required List<T> items,
      this.value,
      this.labelText,
      this.validator,
      this.onChanged,
      this.onSaved,
      this.selectedItemBuilder})
      : items = items.map<DropdownMenuItem<T>>((item) {
          return DropdownMenuItem(value: item, child: Text('$item'));
        }).toList();

  @override
  State<StatefulWidget> createState() {
    return BaseSelectState();
  }
}

class BaseSelectState extends State<BaseSelect> {
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
      ),
      value: widget.value,
      items: widget.items,
      selectedItemBuilder: widget.selectedItemBuilder,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}
