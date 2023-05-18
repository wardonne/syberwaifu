import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_detail_vm.dart';

class CreatedTimeInput extends StatelessWidget {
  const CreatedTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final labelText = S.of(context).columnNameCreatedAt;
    return Consumer<ChatDetailVM>(
      builder: (context, vm, child) {
        return BaseInput(
          labelText: labelText,
          value: DateFormat('yyyy-MM-dd HH:mm:ss').format(vm.createdAt!),
          readOnly: true,
        );
      },
    );
  }
}
