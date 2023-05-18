import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/admin/openai_token/openai_token_detail_vm.dart';

class UpdatedTimeInput extends StatelessWidget {
  const UpdatedTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final labelText = S.of(context).columnNameUpdatedAt;
    return Consumer<OpenAITokenDetailVM>(
      builder: (context, vm, child) {
        return BaseInput(
          labelText: labelText,
          value: DateFormat('yyyy-MM-dd HH:mm:ss').format(vm.updatedAt!),
          readOnly: true,
        );
      },
    );
  }
}
