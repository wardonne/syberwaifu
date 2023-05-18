import 'package:syberwaifu/models/preset/preset_message_model.dart';
import 'package:syberwaifu/services/database_execute_service.dart';

class PresetMessageService extends DatabaseExecuteService {
  Future<PresetMessageModel> create(PresetMessageModel message) async {
    return await message.create<PresetMessageModel>(transaction);
  }

  Future<void> deleteByPresetId(String presetId) async {
    final query = PresetMessageModel.query()..wherePresetId(presetId);
    await query.delete(transaction);
  }
}
