import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/openai_token/openai_token_detail_vm.dart';

class TokenInput extends StatelessWidget {
  const TokenInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    final labelText = S.of(context).columnNameOpenAIToken;
    return Consumer<OpenAITokenDetailVM>(
      builder: (context, vm, child) {
        controller.value = TextEditingValue(text: vm.token);
        return BaseInput(
          controller: controller,
          labelText: labelText,
          readOnly: !vm.editable,
          validator: (value) => requiredValidator(value, labelText),
          onSaved: (value) => vm.token = value ?? '',
        );
      },
    );
  }
}
