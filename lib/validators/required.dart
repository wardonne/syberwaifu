import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/generated/l10n.dart';

String? requiredValidator<T>(T? value, String label) {
  if (empty<T>(value)) {
    return S.current.validateRequired(label);
  }
  return null;
}
