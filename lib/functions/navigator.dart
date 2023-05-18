import 'package:flutter/material.dart';

Future<T?> forward<T extends Object?>(BuildContext context, String routeName,
    {Object? arguments}) {
  return Navigator.of(context).pushNamed<T>(routeName, arguments: arguments);
}

back<T extends Object?>(BuildContext context, {T? result}) {
  Navigator.of(context).pop<T>(result);
}

Future<T?> replace<T extends Object?, R extends Object?>(
    BuildContext context, String routeName,
    {R? result, Object? arguments}) {
  return Navigator.of(context).popAndPushNamed<T, R>(
    routeName,
    result: result,
    arguments: arguments,
  );
}
