import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:syberwaifu/generated/l10n.dart';
import 'package:syberwaifu/view_models/app_init_vm.dart';
import 'package:syberwaifu/view_models/locale_vm.dart';
import 'package:syberwaifu/view_models/theme_vm.dart';
import 'package:syberwaifu/services/settings/settings_service.dart';
import 'package:syberwaifu/router/router.dart';
import 'package:syncfusion_localizations/syncfusion_localizations.dart';
import 'package:window_manager/window_manager.dart';

class SyberWaifu extends StatefulWidget {
  final GlobalKey<NavigatorState> navigatorKey;
  const SyberWaifu({super.key, required this.navigatorKey});

  @override
  State<StatefulWidget> createState() {
    return SyberWaifuState();
  }
}

class SyberWaifuState extends State<SyberWaifu> with WindowListener {
  final routes = RouterSettings.routes();
  final settingsService = SettingsService();

  @override
  void initState() {
    windowManager.addListener(this);
    super.initState();
  }

  @override
  void onWindowEvent(String eventName) {}

  @override
  Widget build(BuildContext context) {
    var themeVM = Provider.of<ThemeVM>(context);
    return MaterialApp(
      navigatorKey: widget.navigatorKey,
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => S.of(context).syberwaifu,
      initialRoute: RouterSettings.chat,
      onGenerateRoute: (settings) {
        if (settings.name == RouterSettings.chat) {
          if (Provider.of<AppInitVM>(context, listen: false).value) {
            return MaterialPageRoute(
                builder: routes[RouterSettings.chat]!, settings: settings);
          } else {
            return MaterialPageRoute(
                builder: routes[RouterSettings.init]!, settings: settings);
          }
        }
        return MaterialPageRoute(
          builder: routes[settings.name]!,
          settings: settings,
        );
      },
      locale: Provider.of<LocaleVM>(context).locale,
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        S.delegate,
        SfGlobalLocalizations.delegate,
      ],
      theme: ThemeData(
        brightness: themeVM.darkMode ? Brightness.dark : Brightness.light,
        primarySwatch: Provider.of<ThemeVM>(context).color,
        primaryColorDark: Colors.black54,
        iconTheme: IconThemeData(
            color: themeVM.darkMode ? Colors.white54 : Colors.black54),
      ),
      scrollBehavior: ScrollConfiguration.of(context)
        ..copyWith(
          dragDevices: {
            PointerDeviceKind.touch,
            PointerDeviceKind.mouse,
          },
        ),
    );
  }
}
