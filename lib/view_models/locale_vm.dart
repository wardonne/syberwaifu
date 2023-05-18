import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LocaleVM with ChangeNotifier, DiagnosticableTreeMixin {
  Locale _locale;

  LocaleVM(Locale locale) : _locale = locale;

  set locale(Locale value) {
    _locale = value;
    notifyListeners();
  }

  Locale get locale => _locale;

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ObjectFlagProperty('locale', _locale));
  }
}
