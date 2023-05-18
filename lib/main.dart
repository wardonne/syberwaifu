import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'package:syberwaifu/components/dialogs/error_dialog.dart';
import 'package:syberwaifu/constants/application.dart';
import 'package:syberwaifu/constants/assets.dart';
import 'package:syberwaifu/constants/locale.dart';
import 'package:syberwaifu/constants/settings.dart';
import 'package:syberwaifu/constants/theme.dart';
import 'package:syberwaifu/functions/forecolor.dart';
import 'package:syberwaifu/global_vars/database.dart';
import 'package:syberwaifu/view_models/app_init_vm.dart';
import 'package:syberwaifu/view_models/locale_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';
import 'package:window_manager/window_manager.dart';
import 'package:syberwaifu/syberwaifu.dart';

final settingsService = SettingsService();
MaterialColor color = ThemeConstants.defaultColor;
Locale locale = LocaleConstants.defaultLocale;
bool darkMode = ThemeConstants.defaultDarkModelSwitch;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isWindows) {
    // await checkUpdate();
    await initWindowManager();
    await windowManager.setTitle('Syber Waifu');
  }

  await initDatabase();

  await initTheme();
  await initLocale();
  final inited = await settingsService.checkApplicationInited();

  final navigatorKey = GlobalKey<NavigatorState>();

  ErrorWidget.builder = (details) {
    return ErrorDialog(
      error: details.exception,
      stackTrace: details.stack,
    );
  };

  runZonedGuarded(
    () => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => LocaleVM(locale)),
        ChangeNotifierProvider(create: (context) => ThemeVM(color, darkMode)),
        ListenableProvider(create: (context) => AppInitVM(inited)),
      ],
      builder: (context, child) {
        final theme = Provider.of<ThemeVM>(context);
        theme.forecolor = forecolorFromColor(
          theme.darkMode ? Theme.of(context).primaryColorDark : theme.color,
        );
        return SyberWaifu(navigatorKey: navigatorKey);
      },
    )),
    (exception, stackTrace) {
      debugPrint('$exception');
      debugPrintStack(stackTrace: stackTrace);
      if (navigatorKey.currentContext != null) {
        SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
          showDialog(
            context: navigatorKey.currentContext!,
            builder: (context) {
              return ErrorDialog(
                error: exception,
                stackTrace: stackTrace,
              );
            },
          );
        });
      }
    },
  );
}

initDatabase() async {
  final documentPath = await getApplicationDocumentsDirectory();
  sqfliteFfiInit();
  db = await databaseFactoryFfi
      .openDatabase('${documentPath.path}/syberwaifu/syberwaifu.db');
  final rows = await db.rawQuery(
      'SELECT * FROM `sqlite_master` WHERE `type` = "table" AND `name` = "SETTINGS"');
  if (rows.isEmpty || !(await settingsService.checkDatabaseInted())) {
    final syberwaifuSQL =
        await rootBundle.loadString(AssetsConstants.sybarWaifuSQL);
    await db.transaction((txn) async {
      await txn.execute(syberwaifuSQL);
      settingsService.beginTransaction(txn);
      await settingsService.save(SettingsConstants.databaseInited,
          ApplicationConstants.databaseInited);
      settingsService.endTransaction();
    });
  }
}

initWindowManager() async {
  await windowManager.ensureInitialized();

  const windowOptions = WindowOptions(
    size: Size(1000, 600),
    minimumSize: Size(1000, 600),
    center: true,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();
    await windowManager.focus();
    await windowManager.setAsFrameless();
  });
}

initTheme() async {
  final themeColorModel =
      await settingsService.load(SettingsConstants.themeColor);
  if (themeColorModel != null && themeColorModel.value != null) {
    color = ThemeConstants.materialColors[themeColorModel.value!] ??
        ThemeConstants.defaultColor;
  }

  final darkModeModel =
      await settingsService.load(SettingsConstants.themeDarkMode);
  if (darkModeModel != null &&
      darkModeModel.value != null &&
      darkModeModel.value!.isNotEmpty) {
    darkMode = darkModeModel.value == ThemeConstants.darkModeEnable;
  }
}

initLocale() async {
  final model = await settingsService.load(SettingsConstants.locale);
  if (model != null && model.value != null && model.value!.isNotEmpty) {
    final parts = model.value!.split('_');
    locale = Locale(parts[0], parts.length >= 2 ? parts[1] : null);
  }
}

// checkUpdate() async {
//   if (kDebugMode) {
//     return;
//   }
//   String feedURL = '';
//   await autoUpdater.setFeedURL(feedURL);
//   await autoUpdater.checkForUpdates(inBackground: true);
//   await autoUpdater.setScheduledCheckInterval(3600);
// }
