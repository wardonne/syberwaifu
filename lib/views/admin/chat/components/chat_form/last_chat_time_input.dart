import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_detail_vm.dart';

class LastChatTimeInput extends StatelessWidget {
  const LastChatTimeInput({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Consumer<ChatDetailVM>(
      builder: (context, vm, child) {
        controller.value = TextEditingValue(
            text: DateFormat('yyyy-MM-dd HH:mm:ss').format(vm.lastedChatedAt!));
        final labelText = S.of(context).columnNameChatLastChatedAt;
        return BaseInput(
          controller: controller,
          labelText: labelText,
          readOnly: true,
        );
      },
    );
  }
}
