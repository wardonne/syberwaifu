import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_select.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/services/openai_token_service.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_detail_vm.dart';

class OpenAITokenSelect extends StatelessWidget {
  const OpenAITokenSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<OpenAITokenModel>>(
      create: (context) {
        return OpenAITokenService().list();
      },
      initialData: const [],
      child: Consumer2<List<OpenAITokenModel>, ChatDetailVM>(
        builder: (context, models, vm, child) {
          final items = <String, String>{};
          for (var model in models) {
            items[model.uuid] = model.name!;
          }
          var initValue = vm.openAITokenId;
          if (empty<String>(initValue) && models.isNotEmpty) {
            initValue = models.first.uuid;
          }
          return BaseSelect.fromMap(
            labelText: S.of(context).columnNameOpenAIToken,
            items: items,
            value: initValue,
            validator: (value) => requiredValidator<String>(
                value, S.of(context).columnNameOpenAIToken),
            onChanged: vm.editable ? (value) {} : null,
            onSaved: (value) {
              vm.openAITokenId = value ?? '';
            },
          );
        },
      ),
    );
  }
}
