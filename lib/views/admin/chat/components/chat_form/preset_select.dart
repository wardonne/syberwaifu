import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_select.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/services/preset/preset_service.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/chat/chat_detail_vm.dart';

class PresetSelect extends StatelessWidget {
  const PresetSelect({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureProvider<List<PresetModel>>(
      create: (context) {
        final service = PresetService();
        return service.list();
      },
      initialData: const [],
      child: Consumer2<List<PresetModel>, ChatDetailVM>(
        builder: (context, models, vm, child) {
          var initValue = vm.presetId;
          final items = <String, String>{};
          for (var model in models) {
            items[model.uuid!] = model.name!;
            if (model.checkIsDefault() && empty<String>(initValue)) {
              initValue = model.uuid!;
            }
          }
          return BaseSelect<String>.fromMap(
            labelText: S.of(context).columnNameChatPreset,
            value: initValue,
            items: items,
            validator: (value) => requiredValidator<String>(
                value, S.of(context).columnNameChatPreset),
            onChanged: vm.editable ? (value) {} : null,
            onSaved: (value) {
              vm.presetId = value ?? '';
            },
          );
        },
      ),
    );
  }
}
