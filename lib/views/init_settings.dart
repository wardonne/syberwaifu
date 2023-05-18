import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/custom_appbar.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/functions/navigator.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/init_settings_vm.dart';
import 'package:syberwaifu/view_models/app_init_vm.dart';

class InitSettings extends StatefulWidget {
  const InitSettings({super.key});

  @override
  State<StatefulWidget> createState() {
    return InitSettingsState();
  }
}

class InitSettingsState extends State<InitSettings> {
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final tokenController = TextEditingController();
    final tokenLabel = S.of(context).columnNameOpenAIToken;
    return Scaffold(
      appBar: CustomAppBar(S.of(context).pageTitleInit,
          leadings: const [], actions: const []),
      body: ChangeNotifierProvider(
        create: (context) => InitSettingsVM(),
        child: Consumer2<InitSettingsVM, AppInitVM>(
          builder: (context, vm, inited, child) {
            tokenController.text = vm.token;
            return Container(
              width: double.infinity,
              height: double.infinity,
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(
                children: [
                  TitledCard(
                    labelText: S.of(context).columnNameOpenAIToken,
                    child: Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          BaseInput(
                            controller: tokenController,
                            labelText: tokenLabel,
                            validator: (value) => requiredValidator(
                                value, S.of(context).columnNameOpenAIToken),
                            onSaved: (value) => vm.token = value ?? '',
                          ),
                          const SizedBox(height: 10.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomElevatedButton(
                                icon: const Icon(Icons.send, size: 20.0),
                                label: Text(S.of(context).btnConfirm),
                                onPressed: () async {
                                  if (formKey.currentState?.validate() ??
                                      false) {
                                    formKey.currentState?.save();
                                    await vm.save();
                                    if (context.mounted) {
                                      inited.value = true;
                                      await replace(
                                          context, RouterSettings.chat);
                                    }
                                  }
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
