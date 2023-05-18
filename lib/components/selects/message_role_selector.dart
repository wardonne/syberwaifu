import 'package:flutter/material.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/form/base_select.dart';
import 'package:syberwaifu/constants/chat_message.dart';
import 'package:syberwaifu/enums/divider_direction.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';

class MessageRoleSelector extends StatelessWidget {
  final String value;
  final void Function(dynamic value)? onChanged;
  const MessageRoleSelector({super.key, required this.value, this.onChanged});

  @override
  Widget build(BuildContext context) {
    final labelText = S.of(context).columnNamePresetMessageRole;
    return BaseSelect<String>(
      value: value,
      items: <DropdownMenuItem<String>>[
        DropdownMenuItem(
          value: ChatMessageConstants.user,
          child: Row(
            children: [
              const Icon(Icons.account_circle),
              const CustomDivider(
                  size: 10, direction: DividerDirection.vertical),
              Text(S.of(context).messageRoleUser),
            ],
          ),
        ),
        DropdownMenuItem(
          value: ChatMessageConstants.assistant,
          child: Row(
            children: [
              const Icon(Icons.token),
              const CustomDivider(
                  size: 10, direction: DividerDirection.vertical),
              Text(S.of(context).messageRoleAssistant),
            ],
          ),
        ),
        DropdownMenuItem(
          value: ChatMessageConstants.system,
          child: Row(
            children: [
              const Icon(Icons.computer),
              const CustomDivider(
                  size: 10, direction: DividerDirection.vertical),
              Text(S.of(context).messageRoleSystem),
            ],
          ),
        ),
      ],
      validator: (value) => requiredValidator(value, labelText),
      onChanged: onChanged,
    );
  }
}
