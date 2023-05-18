import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/components/buttons/custom_elevated_button.dart';
import 'package:syberwaifu/components/custom_divider.dart';
import 'package:syberwaifu/components/form/base_input.dart';
import 'package:syberwaifu/components/form/base_select.dart';
import 'package:syberwaifu/components/loading.dart';
import 'package:syberwaifu/components/titled_card.dart';
import 'package:syberwaifu/constants/proxy.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/validators/required.dart';
import 'package:syberwaifu/view_models/admin/dashboard/proxy_vm.dart';

class ProxyBoard extends StatelessWidget {
  const ProxyBoard({super.key});

  @override
  Widget build(BuildContext context) {
    const divider = CustomDivider(size: 10);
    final formKey = GlobalKey<FormState>();
    final hostController = TextEditingController();
    final portController = TextEditingController();
    return ChangeNotifierProvider(
      create: (context) => ProxyVM(),
      child: Consumer<ProxyVM>(
        builder: (context, vm, child) {
          return TitledCard(
            labelText: S.of(context).cardTitleProxyConfig,
            child: vm.loading
                ? const Center(child: Loading())
                : Builder(builder: (context) {
                    hostController.value = TextEditingValue(text: vm.proxyHost);
                    portController.value = TextEditingValue(text: vm.proxyPort);
                    return Form(
                      key: formKey,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        children: [
                          divider,
                          BaseSelect<String>.fromMap(
                            labelText: S.of(context).columnNameProxyStatus,
                            value: vm.proxyEnable,
                            items: <String, String>{
                              ProxyConstants.proxyEnable:
                                  S.of(context).proxyEnableLabel,
                              ProxyConstants.proxyDisable:
                                  S.of(context).proxyDisableLabel,
                            },
                            validator: (value) => requiredValidator(
                              value,
                              S.of(context).columnNameProxyStatus,
                            ),
                            onChanged: (value) {
                              vm.proxyEnable = value;
                            },
                            onSaved: (value) {
                              vm.proxyEnable = value;
                            },
                          ),
                          divider,
                          BaseInput(
                            value: vm.proxyHost,
                            labelText: S.of(context).columnNameProxyHost,
                            validator: (value) {
                              if (vm.proxyEnable ==
                                  ProxyConstants.proxyEnable) {
                                return requiredValidator(
                                    value, S.of(context).columnNameProxyHost);
                              }
                              return null;
                            },
                            onSaved: (value) => vm.proxyHost = value ?? '',
                          ),
                          divider,
                          BaseInput(
                            value: vm.proxyPort,
                            labelText: S.of(context).columnNameProxyPort,
                            validator: (value) {
                              if (vm.proxyEnable ==
                                  ProxyConstants.proxyEnable) {
                                return requiredValidator(
                                    value, S.of(context).columnNameProxyPort);
                              }
                              return null;
                            },
                            onSaved: (value) => vm.proxyPort = value ?? '',
                          ),
                          divider,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              CustomElevatedButton(
                                icon: const Icon(Icons.send),
                                label: Text(S.of(context).btnConfirm),
                                onPressed: vm.saving
                                    ? null
                                    : () {
                                        if (formKey.currentState?.validate() ??
                                            false) {
                                          formKey.currentState?.save();
                                          vm.save();
                                        }
                                      },
                              )
                            ],
                          ),
                        ],
                      ),
                    );
                  }),
          );
        },
      ),
    );
  }
}
