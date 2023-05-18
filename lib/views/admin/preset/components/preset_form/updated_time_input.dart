import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_detail_vm.dart';

class UpdatedTimeInput extends StatelessWidget {
  const UpdatedTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<PresetDetailVM>(
      builder: (context, detail, child) {
        final controller = TextEditingController(
          text: DateFormat('yyyy-MM-dd HH:mm:ss').format(detail.updatedAt!),
        );
        return TextFormField(
          controller: controller,
          readOnly: true,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            labelText: S.of(context).columnNameUpdatedAt,
          ),
        );
      },
    );
  }
}
