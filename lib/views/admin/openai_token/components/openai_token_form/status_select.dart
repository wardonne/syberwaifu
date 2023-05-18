import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_select.dart';
import 'package:syberwaifu/constants/openai_token.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/openai_token/openai_token_detail_vm.dart';

class StatusSelect extends StatelessWidget {
  const StatusSelect({super.key});

  @override
  Widget build(BuildContext context) {
    final labelText = S.of(context).columnNameOpenAITokenStatus;
    return Consumer<OpenAITokenDetailVM>(
      builder: (context, vm, child) {
        return BaseSelect<int>.fromMap(
          value: vm.status,
          labelText: labelText,
          items: {
            OpenAITokenConstants.enable: S
                .of(context)
                .columnValueFormatOpenAITokenStatus(
                    OpenAITokenConstants.enable),
            OpenAITokenConstants.disable: S
                .of(context)
                .columnValueFormatOpenAITokenStatus(
                    OpenAITokenConstants.disable),
          },
          onChanged: vm.editable ? (value) {} : null,
          validator: (value) => requiredValidator(value, labelText),
          onSaved: (value) => vm.status = value,
        );
      },
    );
  }
}
