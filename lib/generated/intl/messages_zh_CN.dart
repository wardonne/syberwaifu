// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh_CN locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh_CN';

  static String m0(section) => "${Intl.plural(section, one: '是', other: '否')}";

  static String m1(section) => "${Intl.plural(section, one: '是', other: '否')}";

  static String m2(name) => "查看会话: ${name}";

  static String m3(name) => "编辑会话: ${name}";

  static String m4(name) => "查看预设: ${name}";

  static String m5(name) => "编辑预设: ${name}";

  static String m6(attribute) => "${attribute}不能为空";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "btnAdd": MessageLookupByLibrary.simpleMessage("添加"),
        "btnAppendQuote": MessageLookupByLibrary.simpleMessage("追加引用"),
        "btnBack": MessageLookupByLibrary.simpleMessage("返回"),
        "btnBack2Chat": MessageLookupByLibrary.simpleMessage("回到聊天页"),
        "btnCancel": MessageLookupByLibrary.simpleMessage("取消"),
        "btnChat": MessageLookupByLibrary.simpleMessage("对话"),
        "btnClickToShowQuote": MessageLookupByLibrary.simpleMessage("点击查看引用"),
        "btnClose": MessageLookupByLibrary.simpleMessage("关闭"),
        "btnConfirm": MessageLookupByLibrary.simpleMessage("确认"),
        "btnCopy": MessageLookupByLibrary.simpleMessage("复制"),
        "btnCreateNewChat": MessageLookupByLibrary.simpleMessage("新建会话"),
        "btnDashboard": MessageLookupByLibrary.simpleMessage("进入控制台"),
        "btnDelete": MessageLookupByLibrary.simpleMessage("删除"),
        "btnEdit": MessageLookupByLibrary.simpleMessage("编辑"),
        "btnLoadFromSystem": MessageLookupByLibrary.simpleMessage("导入系统设置"),
        "btnMaximize": MessageLookupByLibrary.simpleMessage("最大化"),
        "btnMinimize": MessageLookupByLibrary.simpleMessage("最小化"),
        "btnMultipleChoice": MessageLookupByLibrary.simpleMessage("多选"),
        "btnPickAvatarLibrary": MessageLookupByLibrary.simpleMessage("浏览头像库"),
        "btnPickFile": MessageLookupByLibrary.simpleMessage("选择文件"),
        "btnQuit": MessageLookupByLibrary.simpleMessage("退出"),
        "btnQuote": MessageLookupByLibrary.simpleMessage("引用"),
        "btnQuoteWithContext": MessageLookupByLibrary.simpleMessage("引用上下文"),
        "btnRefresh": MessageLookupByLibrary.simpleMessage("刷新"),
        "btnRemove": MessageLookupByLibrary.simpleMessage("移除"),
        "btnRestore": MessageLookupByLibrary.simpleMessage("还原"),
        "btnSelectAvatar": MessageLookupByLibrary.simpleMessage("选择头像"),
        "btnSend": MessageLookupByLibrary.simpleMessage("发送"),
        "btnSettings": MessageLookupByLibrary.simpleMessage("设置"),
        "btnView": MessageLookupByLibrary.simpleMessage("查看"),
        "cardTitleAddPresetMessage":
            MessageLookupByLibrary.simpleMessage("添加预设消息"),
        "cardTitleBasicInfo": MessageLookupByLibrary.simpleMessage("基础信息"),
        "cardTitlePresetMessages": MessageLookupByLibrary.simpleMessage("预设消息"),
        "cardTitleProxyConfig": MessageLookupByLibrary.simpleMessage("代理设置"),
        "cardTitleThemeConfig": MessageLookupByLibrary.simpleMessage("主题设置"),
        "columnNameActions": MessageLookupByLibrary.simpleMessage("操作"),
        "columnNameAvatarChatCount":
            MessageLookupByLibrary.simpleMessage("会话数"),
        "columnNameAvatarImage": MessageLookupByLibrary.simpleMessage("头像"),
        "columnNameAvatarUUID": MessageLookupByLibrary.simpleMessage("ID"),
        "columnNameChatAvatar": MessageLookupByLibrary.simpleMessage("头像"),
        "columnNameChatLastChatedAt":
            MessageLookupByLibrary.simpleMessage("最后会话时间"),
        "columnNameChatMessageContent":
            MessageLookupByLibrary.simpleMessage("消息内容"),
        "columnNameChatMessageCount":
            MessageLookupByLibrary.simpleMessage("消息数"),
        "columnNameChatMessageCreatedAt":
            MessageLookupByLibrary.simpleMessage("发送时间"),
        "columnNameChatMessageQuoteCount":
            MessageLookupByLibrary.simpleMessage("启用消息数"),
        "columnNameChatMessageRole":
            MessageLookupByLibrary.simpleMessage("发送角色"),
        "columnNameChatMessageUUID": MessageLookupByLibrary.simpleMessage("ID"),
        "columnNameChatName": MessageLookupByLibrary.simpleMessage("会话名称"),
        "columnNameChatPreset": MessageLookupByLibrary.simpleMessage("会话预设"),
        "columnNameChatUUID": MessageLookupByLibrary.simpleMessage("ID"),
        "columnNameCreatedAt": MessageLookupByLibrary.simpleMessage("创建时间"),
        "columnNameOpenAIToken":
            MessageLookupByLibrary.simpleMessage("OpenAI秘钥"),
        "columnNameOpenAITokenChatCount":
            MessageLookupByLibrary.simpleMessage("会话数"),
        "columnNameOpenAITokenContent":
            MessageLookupByLibrary.simpleMessage("秘钥内容"),
        "columnNameOpenAITokenName":
            MessageLookupByLibrary.simpleMessage("秘钥名称"),
        "columnNameOpenAITokenStatus":
            MessageLookupByLibrary.simpleMessage("启用状态"),
        "columnNameOpenAITokenUUID": MessageLookupByLibrary.simpleMessage("ID"),
        "columnNamePresetChatCount":
            MessageLookupByLibrary.simpleMessage("会话数"),
        "columnNamePresetIsDefault":
            MessageLookupByLibrary.simpleMessage("默认预设"),
        "columnNamePresetMessageContent":
            MessageLookupByLibrary.simpleMessage("消息内容"),
        "columnNamePresetMessageRole":
            MessageLookupByLibrary.simpleMessage("角色"),
        "columnNamePresetName": MessageLookupByLibrary.simpleMessage("预设名称"),
        "columnNamePresetNickname":
            MessageLookupByLibrary.simpleMessage("AI昵称"),
        "columnNamePresetUUID": MessageLookupByLibrary.simpleMessage("ID"),
        "columnNameProxyHost": MessageLookupByLibrary.simpleMessage("代理主机"),
        "columnNameProxyPort": MessageLookupByLibrary.simpleMessage("代理端口"),
        "columnNameProxyStatus": MessageLookupByLibrary.simpleMessage("启用状态"),
        "columnNameUpdatedAt": MessageLookupByLibrary.simpleMessage("最后更新时间"),
        "columnValueFormatOpenAITokenStatus": m0,
        "columnValueFormatPresetIsDefault": m1,
        "confirmDeleteAvatar": MessageLookupByLibrary.simpleMessage("确认删除该头像?"),
        "confirmDeleteChat": MessageLookupByLibrary.simpleMessage("确认删除该会话?"),
        "confirmDeleteMessage":
            MessageLookupByLibrary.simpleMessage("确认删除该信息?"),
        "confirmDeletePreset": MessageLookupByLibrary.simpleMessage("确认删除该预设?"),
        "confirmResendMessage": MessageLookupByLibrary.simpleMessage("是否重新发送?"),
        "dashboardAvatarCountTooltip":
            MessageLookupByLibrary.simpleMessage("点击进入头像库"),
        "dashboardAvatarLibrary": MessageLookupByLibrary.simpleMessage("头像库"),
        "dashboardChatCount": MessageLookupByLibrary.simpleMessage("会话数"),
        "dashboardChatCountTooltip":
            MessageLookupByLibrary.simpleMessage("点击进入会话管理"),
        "dashboardDataStat": MessageLookupByLibrary.simpleMessage("数据统计"),
        "dashboardOpenAITokenCount":
            MessageLookupByLibrary.simpleMessage("OpenAI秘钥数"),
        "dashboardOpenAITokenCountTooltip":
            MessageLookupByLibrary.simpleMessage("点击进入OpenAI秘钥管理"),
        "dashboardPresetCount": MessageLookupByLibrary.simpleMessage("预设数"),
        "dashboardPresetCountTooltip":
            MessageLookupByLibrary.simpleMessage("点击进入预设管理"),
        "dashboardResourceBoard": MessageLookupByLibrary.simpleMessage("资源看板"),
        "dialogTitleConfirm": MessageLookupByLibrary.simpleMessage("确认?"),
        "dialogTitleCropImage": MessageLookupByLibrary.simpleMessage("图片裁剪"),
        "dialogTitleDeletePreset": MessageLookupByLibrary.simpleMessage("删除预设"),
        "dialogTitleError": MessageLookupByLibrary.simpleMessage("错误"),
        "dialogTitleQuote": MessageLookupByLibrary.simpleMessage("引用消息"),
        "dialogTitleSendFailure": MessageLookupByLibrary.simpleMessage("发送失败"),
        "dialogTitleViewImage": MessageLookupByLibrary.simpleMessage("查看图片"),
        "hintSearchChat": MessageLookupByLibrary.simpleMessage("搜索会话"),
        "messageCopied": MessageLookupByLibrary.simpleMessage("复制成功"),
        "messageDeleteSuccess": MessageLookupByLibrary.simpleMessage("删除成功"),
        "messageRoleAssistant": MessageLookupByLibrary.simpleMessage("AI"),
        "messageRoleSystem": MessageLookupByLibrary.simpleMessage("系统"),
        "messageRoleUser": MessageLookupByLibrary.simpleMessage("用户"),
        "pageTitleAvatarManager": MessageLookupByLibrary.simpleMessage("头像管理"),
        "pageTitleChatCreate": MessageLookupByLibrary.simpleMessage("创建会话"),
        "pageTitleChatDetail": m2,
        "pageTitleChatEdit": m3,
        "pageTitleChatManager": MessageLookupByLibrary.simpleMessage("会话管理"),
        "pageTitleChatMessageManager":
            MessageLookupByLibrary.simpleMessage("消息记录"),
        "pageTitleInit": MessageLookupByLibrary.simpleMessage("初始化设置"),
        "pageTitleOpenAITokenCreate":
            MessageLookupByLibrary.simpleMessage("创建OpenAI秘钥"),
        "pageTitleOpenAITokenDetail":
            MessageLookupByLibrary.simpleMessage("查看OpenAI秘钥"),
        "pageTitleOpenAITokenEdit":
            MessageLookupByLibrary.simpleMessage("编辑OpenAI秘钥"),
        "pageTitleOpenAITokenManager":
            MessageLookupByLibrary.simpleMessage("OpenAI秘钥管理"),
        "pageTitlePresetCreate": MessageLookupByLibrary.simpleMessage("创建预设"),
        "pageTitlePresetDetail": m4,
        "pageTitlePresetEdit": m5,
        "pageTitlePresetManager": MessageLookupByLibrary.simpleMessage("预设管理"),
        "proxyDisableLabel": MessageLookupByLibrary.simpleMessage("禁用"),
        "proxyEnableLabel": MessageLookupByLibrary.simpleMessage("启用"),
        "selectedMessageCount": MessageLookupByLibrary.simpleMessage("已选消息"),
        "syberwaifu": MessageLookupByLibrary.simpleMessage("Syber Waifu"),
        "tableTitleAvatarList": MessageLookupByLibrary.simpleMessage("头像列表"),
        "tableTitleChatList": MessageLookupByLibrary.simpleMessage("会话列表"),
        "tableTitleOpenAITokenList":
            MessageLookupByLibrary.simpleMessage("OpenAI秘钥列表"),
        "tableTitlePresetList": MessageLookupByLibrary.simpleMessage("预设列表"),
        "validateRequired": m6
      };
}
