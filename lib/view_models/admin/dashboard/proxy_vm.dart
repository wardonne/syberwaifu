import 'package:flutter/foundation.dart';
import 'package:syberwaifu/constants/proxy.dart';
import 'package:syberwaifu/constants/settings.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/settings_model.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';

class ProxyVM extends ChangeNotifier {
  final _settingsService = SettingsService();

  ProxyVM() {
    Future.wait<SettingsModel?>(<Future<SettingsModel?>>[
      _settingsService.load(SettingsConstants.proxyEnable),
      _settingsService.load(SettingsConstants.proxyHost),
      _settingsService.load(SettingsConstants.proxyPort),
    ]).then((List<SettingsModel?> settings) {
      for (var setting in settings) {
        if (setting?.attribute == SettingsConstants.proxyEnable) {
          proxyEnable = setting?.value ?? ProxyConstants.proxyDisable;
          continue;
        }
        if (setting?.attribute == SettingsConstants.proxyHost) {
          proxyHost = setting?.value ?? '';
          continue;
        }
        if (setting?.attribute == SettingsConstants.proxyPort) {
          proxyPort = setting?.value ?? '';
          continue;
        }
      }
      loading = false;
    });
  }

  late String proxyEnable;

  late String proxyHost;

  late String proxyPort;

  bool _loading = true;

  set loading(bool value) {
    _loading = value;
    notifyListeners();
  }

  bool get loading => _loading;

  bool _saving = false;

  set saving(bool value) {
    _saving = value;
    notifyListeners();
  }

  bool get saving => _saving;

  Future<void> save() async {
    saving = true;
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 5));
    }
    await Model.transaction((txn) async {
      _settingsService.beginTransaction(txn);
      await Future.wait<SettingsModel>([
        _settingsService.save(SettingsConstants.proxyEnable, proxyEnable),
        _settingsService.save(SettingsConstants.proxyHost, proxyHost),
        _settingsService.save(SettingsConstants.proxyPort, proxyPort),
      ]);
      _settingsService.endTransaction();
    });
    saving = false;
  }
}
