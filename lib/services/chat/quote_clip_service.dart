import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/models/chat/quote_clip_message_model.dart';
import 'package:syberwaifu/models/chat/quote_clip_model.dart';
import 'package:syberwaifu/services/database_execute_service.dart';

class QuoteClipService extends DatabaseExecuteService {
  Future<QuoteClipModel> create(List<ChatMessageModel> messages) async {
    final quoteClip = QuoteClipModel()..create<QuoteClipModel>(transaction);
    for (var message in messages) {
      QuoteClipMessageModel(
        quoteClipId: quoteClip.uuid,
        chatMessageId: message.uuid,
      ).create(transaction);
    }
    return quoteClip;
  }

  Future<void> delete(String id) async {
    QuoteClipModel.query()
        .find<QuoteClipModel>(pk: id, txn: transaction)
        .then((QuoteClipModel? model) {
      if (!empty<QuoteClipModel>(model)) {
        model!.messages.then((List<QuoteClipMessageModel> models) {
          for (var model in models) {
            model.delete<QuoteClipMessageModel>(transaction);
          }
        }).then((value) => model.delete<QuoteClipModel>(transaction));
      }
    });
  }
}
