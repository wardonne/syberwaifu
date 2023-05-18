import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';

class ChatListConditions extends Object {
  final PresetModel? preset;
  final OpenAITokenModel? openAIToken;
  final AvatarModel? avatar;
  final String? name;
  ChatListConditions({
    this.preset,
    this.openAIToken,
    this.avatar,
    this.name,
  });

  bool get isEmpty =>
      empty(preset) &&
      empty(openAIToken) &&
      empty<String>(name) &&
      empty(avatar);

  @override
  String toString() {
    final conditions = <String>[];
    if (preset != null) {
      conditions.add(preset!.name!);
    }
    if (openAIToken != null) {
      conditions.add(openAIToken!.name!);
    }
    return conditions.join('-');
  }
}
