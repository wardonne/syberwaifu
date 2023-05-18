import 'package:flutter/material.dart';

class SelectWrapper extends StatefulWidget {
  final bool checked;
  final Function(bool? value)? onChanged;
  final Widget child;
  const SelectWrapper({
    super.key,
    required this.checked,
    this.onChanged,
    required this.child,
  });

  @override
  State<StatefulWidget> createState() {
    return SelectWrapperState();
  }
}

class SelectWrapperState extends State<SelectWrapper> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.checked ? Colors.black12 : Colors.transparent,
      child: Row(
        children: [
          const VerticalDivider(width: 10, color: Colors.transparent),
          Checkbox(
            value: widget.checked,
            onChanged: widget.onChanged,
          ),
          const VerticalDivider(width: 10, color: Colors.transparent),
          Expanded(child: widget.child),
          const VerticalDivider(width: 10, color: Colors.transparent),
        ],
      ),
    );
  }
}
