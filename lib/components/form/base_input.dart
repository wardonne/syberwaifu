import 'package:flutter/material.dart';

class BaseInput extends StatefulWidget {
  final TextEditingController? controller;
  final String? value;
  final String? labelText;
  final bool? readOnly;
  final int? maxLines;
  final Widget? prefix;
  final Widget? suffix;
  final String? Function(String? value)? validator;
  final void Function(String value)? onChanged;
  final void Function(String?)? onSaved;

  const BaseInput({
    super.key,
    this.controller,
    this.value,
    this.labelText,
    this.readOnly,
    this.maxLines = 1,
    this.prefix,
    this.suffix,
    this.validator,
    this.onChanged,
    this.onSaved,
  });

  @override
  State<BaseInput> createState() => _BaseInputState();
}

class _BaseInputState extends State<BaseInput> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      initialValue: widget.value,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: widget.labelText,
        prefix: widget.prefix,
        suffix: widget.suffix,
      ),
      readOnly: widget.readOnly ?? false,
      maxLines: widget.maxLines,
      validator: widget.validator,
      onChanged: widget.onChanged,
      onSaved: widget.onSaved,
    );
  }
}
