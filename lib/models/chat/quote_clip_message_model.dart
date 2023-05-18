import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/models/model.dart';

class QuoteClipMessageModel extends Model {
  String? quoteClipId;
  String? chatMessageId;

  @override
  String get tableName => 'QUOTE_CLIP_MESSAGES';

  QuoteClipMessageModel({
    required this.quoteClipId,
    required this.chatMessageId,
  });

  QuoteClipMessageModel.query() : super.query();

  QuoteClipMessageModel.fromJSON(Map<String, Object?> json)
      : quoteClipId = Arr.get<String>(json, 'QUOTE_CLIP_ID'),
        chatMessageId = Arr.get<String>(json, 'CHAT_MESSAGE_ID'),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() {
    return {
      'QUOTE_CLIP_ID': quoteClipId,
      'CHAT_MESSAGE_ID': chatMessageId,
    };
  }

  Future<ChatMessageModel?> get message async {
    return ChatMessageModel.query().find<ChatMessageModel>(pk: chatMessageId);
  }

  whereQuoteId(String value) => where('QUOTE_CLIP_ID', value);
}
