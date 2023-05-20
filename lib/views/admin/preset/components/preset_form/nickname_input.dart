import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_detail_vm.dart';

class NicknameInput extends StatefulWidget {
  const NicknameInput({super.key});

  @override
  State<StatefulWidget> createState() {
    return NicknameInputState();
  }
}

class NicknameInputState extends State<NicknameInput> {
  @override
  Widget build(BuildContext context) {
    // final controller = TextEditingController();
    final labelText = S.of(context).columnNamePresetNickname;
    return Consumer<PresetDetailVM>(
      builder: (context, detail, child) {
        // controller.text = detail.nickname;
        return BaseInput(
          // controller: controller,
          value: detail.nickname,
          readOnly: !detail.editable || detail.saving,
          validator: (value) => requiredValidator(value, labelText),
          onSaved: (value) => detail.nickname = value ?? '',
          onChanged: (value) => detail.nickname = value,
        );
      },
    );
  }
}
