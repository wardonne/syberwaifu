import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datagrid/datagrid.dart';

class TitleHeader {
  final String title;
  final List<Widget> actions;
  final List<String> columns;
  const TitleHeader({
    required this.title,
    required this.actions,
    required this.columns,
  });

  StackedHeaderRow build(BuildContext context) {
    return StackedHeaderRow(cells: [
      StackedHeaderCell(
        columnNames: columns,
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 10,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  textScaleFactor: 1.3,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              ...actions
                  .map((action) => Container(
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        child: action,
                      ))
                  .toList(),
            ],
          ),
        ),
      ),
    ]);
  }
}
