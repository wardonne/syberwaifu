import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/constants/proxy.dart';
import 'package:syberwaifu/constants/settings.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/settings_model.dart';
import 'package:syberwaifu/services/database_execute_service.dart';

class SettingsService extends DatabaseExecuteService {
  Future<SettingsModel?> load(String attribute) async {
    return await SettingsModel.query().find(pk: attribute);
  }

  Future<SettingsModel> save(String attribute, String value) async {
    var model = await SettingsModel.query()
        .find<SettingsModel>(pk: attribute, txn: transaction);
    if (model != null) {
      model.value = value;
      return await model.update<SettingsModel>(transaction);
    }
    model = SettingsModel(attribute: attribute, value: value);
    return await model.create<SettingsModel>(transaction);
  }

  Future<bool> checkDatabaseInted() async {
    final model = await SettingsModel.query()
        .find<SettingsModel>(pk: SettingsConstants.databaseInited);
    if (model == null) return false;
    return model.value! == ApplicationConstants.databaseInited;
  }

  Future<bool> checkApplicationInited() async {
    final model = await (SettingsModel.query()
          ..whereAttribute(SettingsConstants.applicationInited))
        .find<SettingsModel>(txn: transaction);
    if (model == null) return false;
    return model.value! == ApplicationConstants.appInited;
  }

  Future<bool> checkProxyEnabled() async {
    final model = await (SettingsModel.query()
          ..whereAttribute(SettingsConstants.proxyEnable))
        .find<SettingsModel>(txn: transaction);
    return empty(model) ? false : model!.value == ProxyConstants.proxyEnable;
  }

  Future<String?> proxySettings() async {
    final proxyHost = await (SettingsModel.query()
          ..whereAttribute(SettingsConstants.proxyHost))
        .find<SettingsModel>(txn: transaction);
    final proxyPort = await (SettingsModel.query()
          ..whereAttribute(SettingsConstants.proxyPort))
        .find<SettingsModel>(txn: transaction);
    return empty<String>(proxyHost?.value) || empty<String>(proxyPort?.value)
        ? null
        : '${proxyHost!.value}:${proxyPort!.value}';
  }
}
