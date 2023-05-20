import 'package:intl/intl.dart';
import 'package:syberwaifu/constants/openai_token.dart';
import 'package:syberwaifu/enums/database_where_operator.dart';
import 'package:syberwaifu/functions/array.dart';
import 'package:syberwaifu/functions/empty.dart';
import 'package:syberwaifu/functions/time_util.dart';
import 'package:syberwaifu/models/avatar.dart';
import 'package:syberwaifu/models/chat/chat_message_model.dart';
import 'package:syberwaifu/models/model.dart';
import 'package:syberwaifu/models/openai_token_model.dart';
import 'package:syberwaifu/models/preset/preset_model.dart';
import 'package:uuid/uuid.dart';

class ChatModel extends Model {
  String? _uuid;
  String? openAITokenId;
  String? presetId;
  String? name;
  String? avatarId;
  DateTime? lastChatedAt;
  DateTime? createdAt;
  DateTime? updatedAt;

  String? get uuid => _uuid;

  @override
  String get tableName => 'CHATS';

  @override
  String get primaryKey => 'UUID';

  @override
  String? get primaryValue => _uuid;

  ChatModel({
    required this.openAITokenId,
    required this.presetId,
    required this.name,
    this.avatarId,
  })  : _uuid = const Uuid().v4(),
        super();

  ChatModel.query() : super.query();

  ChatModel.fromJSON(Map<String, Object?> json)
      : _uuid = Arr.get<String>(json, 'UUID'),
        openAITokenId = Arr.get<String>(json, 'OPENAI_TOKEN_ID'),
        presetId = Arr.get<String>(json, 'PRESET_ID'),
        name = Arr.get<String>(json, 'NAME'),
        avatarId = Arr.tryGet<String>(json, 'AVATAR_ID'),
        lastChatedAt = Arr.getCast<int, DateTime>(
            json, 'LAST_CHATED_AT', TimeUtil.fromTimestamp),
        createdAt = Arr.getCast<int, DateTime>(
            json, 'CREATED_AT', TimeUtil.fromTimestamp),
        updatedAt = Arr.getCast<int, DateTime>(
            json, 'UPDATED_AT', TimeUtil.fromTimestamp),
        super.fromJSON(json);

  @override
  Map<String, Object?> toJSON() => {
        'UUID': _uuid,
        'PRESET_ID': presetId,
        'OPENAI_TOKEN_ID': openAITokenId,
        'NAME': name,
        'AVATAR_ID': avatarId,
        'LAST_CHATED_AT': TimeUtil.timestamp(lastChatedAt),
        'CREATED_AT': TimeUtil.timestamp(createdAt),
        'UPDATED_AT': TimeUtil.timestamp(updatedAt),
      };

  Future<PresetModel> get preset async =>
      await PresetModel.query().findOrFail<PresetModel>(pk: presetId!);

  Future<OpenAITokenModel> get openAIToken async =>
      await OpenAITokenModel.query()
          .findOrFail<OpenAITokenModel>(pk: openAITokenId!);

  Future<List<ChatMessageModel>> get messages async {
    final queryBuilder = ChatMessageModel.query()
      ..whereChatId(uuid!)
      ..orderBy = 'CREATED_AT ASC';
    return await queryBuilder.findAll<ChatMessageModel>();
  }

  Future<ChatMessageModel?> get latestMessage async {
    final queryBuilder = ChatMessageModel.query()
      ..whereChatId(uuid!)
      ..orderBy = 'CREATED_AT DESC';
    return await queryBuilder.find<ChatMessageModel>();
  }

  Future<int> get messageCount async {
    final query = ChatMessageModel.query();
    query.whereChatId(uuid!);
    return await query.count();
  }

  Future<AvatarModel?> get avatar async {
    if (empty<String>(avatarId)) {
      return null;
    }
    return await AvatarModel.query().find<AvatarModel>(pk: avatarId!);
  }

  String get chatedAt {
    final now = DateTime.now();
    if (lastChatedAt!.year == now.year) {
      if (lastChatedAt!.month == now.month && lastChatedAt!.day == now.day) {
        return DateFormat('HH:mm').format(lastChatedAt!);
      } else {
        return DateFormat('MM/dd').format(lastChatedAt!);
      }
    } else {
      return DateFormat('yyyy/MM/dd').format(lastChatedAt!);
    }
  }

  @override
  bool Function<T extends Model>(T model)? get beforeInsert => _beforeInsert;

  bool _beforeInsert<T extends Model>(T model) {
    (model as ChatModel).createdAt = DateTime.now();
    model.updatedAt = DateTime.now();
    model.lastChatedAt = DateTime.now();
    return true;
  }

  @override
  bool Function<T extends Model>(T model)? get beforeUpdate => _beforeUpdate;

  bool _beforeUpdate<T extends Model>(T model) {
    (model as ChatModel).updatedAt = DateTime.now();
    return true;
  }

  whereNameContains(String value) {
    where('NAME', '%$value%', operator: DatabaseWhereOperator.like);
  }

  wherePresetId(String value) {
    where('PRESET_ID', value);
  }

  whereOpenAITokenId(String value) {
    where('OPENAI_TOKEN_ID', value);
  }

  Future<bool> get avaliable async {
    return (await openAIToken).status == OpenAITokenConstants.enable;
  }
}
