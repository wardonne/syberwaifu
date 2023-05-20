import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_detail_vm.dart';

class NameInput extends StatefulWidget {
  const NameInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return NameInputState();
  }
}

class NameInputState extends State<NameInput> {
  @override
  Widget build(BuildContext context) {
    // final controller = TextEditingController();
    final labelText = S.of(context).columnNamePresetName;
    return Consumer<PresetDetailVM>(
      builder: (context, detail, child) {
        // controller.text = detail.name;
        return BaseInput(
          // controller: controller,
          value: detail.name,
          labelText: labelText,
          readOnly: !detail.editable || detail.saving,
          validator: (value) => requiredValidator(value, labelText),
          onSaved: (value) => detail.name = value ?? '',
          onChanged: (value) => detail.name = value,
        );
      },
    );
  }
}
