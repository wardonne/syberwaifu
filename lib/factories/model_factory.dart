import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/models/chat/chat_model.dart';
import 'package:syberwaifu/models/chat/quote_clip_message_model.dart';
import 'package:syberwaifu/models/chat/quote_clip_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:syberwaifu/models/settings_model.dart';

final _constructors = <Type, Function>{
  SettingsModel: SettingsModel.fromJSON,
  OpenAITokenModel: OpenAITokenModel.fromJSON,
  ChatModel: ChatModel.fromJSON,
  ChatMessageModel: ChatMessageModel.fromJSON,
  PresetModel: PresetModel.fromJSON,
  PresetMessageModel: PresetMessageModel.fromJSON,
  QuoteClipModel: QuoteClipModel.fromJSON,
  QuoteClipMessageModel: QuoteClipMessageModel.fromJSON,
  AvatarModel: AvatarModel.fromJSON,
};

T model<T extends Model>(Map<String, Object?> json) {
  return _constructors[T]!(json);
}
