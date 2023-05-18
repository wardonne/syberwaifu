import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/form/base_select.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/preset/preset_detail_vm.dart';

class IsDefaultSelect extends StatefulWidget {
  const IsDefaultSelect({super.key});

  @override
  State<StatefulWidget> createState() {
    return IsDefaultSelectState();
  }
}

class IsDefaultSelectState extends State<IsDefaultSelect> {
  @override
  Widget build(BuildContext context) {
    final labelText = S.of(context).columnNamePresetIsDefault;
    return Consumer<PresetDetailVM>(
      builder: (context, detail, child) {
        return BaseSelect<int>.fromMap(
          labelText: labelText,
          items: <int, String>{
            0: S.of(context).columnValueFormatPresetIsDefault(0),
            1: S.of(context).columnValueFormatPresetIsDefault(1)
          },
          selectedItemBuilder: (context) {
            return [
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(S.of(context).columnValueFormatPresetIsDefault(0)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(S.of(context).columnValueFormatPresetIsDefault(1)),
              ),
            ];
          },
          validator: (value) => requiredValidator(value, labelText),
        );
      },
    );
  }
}
