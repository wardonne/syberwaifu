import 'package:flutter/foundation.dart';
import 'package:syberwaifu/constants/openai_token.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/services/openai_token_service.dart';

class OpenAITokenDetailVM extends ChangeNotifier {
  final _openAITokenService = OpenAITokenService();
  OpenAITokenDetailVM()
      : _openAIToken = OpenAITokenModel(
          name: '',
          token: '',
          status: OpenAITokenConstants.enable,
        ),
        _editable = true;

  OpenAITokenDetailVM.detail(this._openAIToken, this._editable);

  final bool _loading = false;

  bool get loading => _loading;

  final bool _editable;

  bool get editable => _editable;

  bool _saving = false;

  set saving(bool value) {
    _saving = value;
    notifyListeners();
  }

  bool get saving => _saving;

  final OpenAITokenModel _openAIToken;

  OpenAITokenModel get openAIToken => _openAIToken;

  set name(String value) => _openAIToken.name = value;

  String get name => _openAIToken.name ?? '';

  set token(String value) => _openAIToken.token = value;

  String get token => _openAIToken.token ?? '';

  set status(int value) => _openAIToken.status = value;

  int get status => _openAIToken.status ?? OpenAITokenConstants.enable;

  DateTime? get createdAt => _openAIToken.createdAt;

  DateTime? get updatedAt => _openAIToken.updatedAt;

  Future<void> save() async {
    saving = true;
    if (kDebugMode) {
      await Future.delayed(const Duration(seconds: 5));
    }
    await Model.transaction((txn) async {
      _openAITokenService.beginTransaction(txn);
      if (_openAIToken.isNew) {
        await _openAITokenService.create(_openAIToken);
      } else {
        await _openAITokenService.update(_openAIToken);
      }
      _openAITokenService.endTransaction();
    });
  }
}
