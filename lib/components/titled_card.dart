import 'package:flutter/material.dart';

class TitledCard extends StatelessWidget {
  final Widget? label;
  final String? labelText;
  final Widget child;
  final List<Widget>? actions;
  const TitledCard({
    super.key,
    this.label,
    this.labelText,
    required this.child,
    this.actions,
  }) : assert(!(label == null && labelText == null),
            'label and labelText can\'t be both null');

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          Container(
            height: 50.0,
            padding: const EdgeInsets.only(left: 20.0),
            decoration: const BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.black26)),
            ),
            child: Row(
              children: [
                Expanded(child: label ?? Text(labelText!)),
                ...?actions,
              ],
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
            child: child,
          ),
        ],
      ),
    );
  }
}
