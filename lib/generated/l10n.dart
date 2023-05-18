// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Syber Waifu`
  String get syberwaifu {
    return Intl.message(
      'Syber Waifu',
      name: 'syberwaifu',
      desc: '',
      args: [],
    );
  }

  /// `{attribute}不能为空`
  String validateRequired(Object attribute) {
    return Intl.message(
      '$attribute不能为空',
      name: 'validateRequired',
      desc: '',
      args: [attribute],
    );
  }

  /// `搜索会话`
  String get hintSearchChat {
    return Intl.message(
      '搜索会话',
      name: 'hintSearchChat',
      desc: '',
      args: [],
    );
  }

  /// `确认?`
  String get dialogTitleConfirm {
    return Intl.message(
      '确认?',
      name: 'dialogTitleConfirm',
      desc: '',
      args: [],
    );
  }

  /// `复制成功`
  String get messageCopied {
    return Intl.message(
      '复制成功',
      name: 'messageCopied',
      desc: '',
      args: [],
    );
  }

  /// `确认删除该信息?`
  String get confirmDeleteMessage {
    return Intl.message(
      '确认删除该信息?',
      name: 'confirmDeleteMessage',
      desc: '',
      args: [],
    );
  }

  /// `删除预设`
  String get dialogTitleDeletePreset {
    return Intl.message(
      '删除预设',
      name: 'dialogTitleDeletePreset',
      desc: '',
      args: [],
    );
  }

  /// `确认删除该预设?`
  String get confirmDeletePreset {
    return Intl.message(
      '确认删除该预设?',
      name: 'confirmDeletePreset',
      desc: '',
      args: [],
    );
  }

  /// `删除成功`
  String get messageDeleteSuccess {
    return Intl.message(
      '删除成功',
      name: 'messageDeleteSuccess',
      desc: '',
      args: [],
    );
  }

  /// `确认删除该会话?`
  String get confirmDeleteChat {
    return Intl.message(
      '确认删除该会话?',
      name: 'confirmDeleteChat',
      desc: '',
      args: [],
    );
  }

  /// `已选消息`
  String get selectedMessageCount {
    return Intl.message(
      '已选消息',
      name: 'selectedMessageCount',
      desc: '',
      args: [],
    );
  }

  /// `发送失败`
  String get dialogTitleSendFailure {
    return Intl.message(
      '发送失败',
      name: 'dialogTitleSendFailure',
      desc: '',
      args: [],
    );
  }

  /// `是否重新发送?`
  String get confirmResendMessage {
    return Intl.message(
      '是否重新发送?',
      name: 'confirmResendMessage',
      desc: '',
      args: [],
    );
  }

  /// `错误`
  String get dialogTitleError {
    return Intl.message(
      '错误',
      name: 'dialogTitleError',
      desc: '',
      args: [],
    );
  }

  /// `引用消息`
  String get dialogTitleQuote {
    return Intl.message(
      '引用消息',
      name: 'dialogTitleQuote',
      desc: '',
      args: [],
    );
  }

  /// `图片裁剪`
  String get dialogTitleCropImage {
    return Intl.message(
      '图片裁剪',
      name: 'dialogTitleCropImage',
      desc: '',
      args: [],
    );
  }

  /// `查看图片`
  String get dialogTitleViewImage {
    return Intl.message(
      '查看图片',
      name: 'dialogTitleViewImage',
      desc: '',
      args: [],
    );
  }

  /// `数据统计`
  String get dashboardDataStat {
    return Intl.message(
      '数据统计',
      name: 'dashboardDataStat',
      desc: '',
      args: [],
    );
  }

  /// `会话数`
  String get dashboardChatCount {
    return Intl.message(
      '会话数',
      name: 'dashboardChatCount',
      desc: '',
      args: [],
    );
  }

  /// `预设数`
  String get dashboardPresetCount {
    return Intl.message(
      '预设数',
      name: 'dashboardPresetCount',
      desc: '',
      args: [],
    );
  }

  /// `OpenAI秘钥数`
  String get dashboardOpenAITokenCount {
    return Intl.message(
      'OpenAI秘钥数',
      name: 'dashboardOpenAITokenCount',
      desc: '',
      args: [],
    );
  }

  /// `点击进入会话管理`
  String get dashboardChatCountTooltip {
    return Intl.message(
      '点击进入会话管理',
      name: 'dashboardChatCountTooltip',
      desc: '',
      args: [],
    );
  }

  /// `点击进入预设管理`
  String get dashboardPresetCountTooltip {
    return Intl.message(
      '点击进入预设管理',
      name: 'dashboardPresetCountTooltip',
      desc: '',
      args: [],
    );
  }

  /// `点击进入OpenAI秘钥管理`
  String get dashboardOpenAITokenCountTooltip {
    return Intl.message(
      '点击进入OpenAI秘钥管理',
      name: 'dashboardOpenAITokenCountTooltip',
      desc: '',
      args: [],
    );
  }

  /// `资源看板`
  String get dashboardResourceBoard {
    return Intl.message(
      '资源看板',
      name: 'dashboardResourceBoard',
      desc: '',
      args: [],
    );
  }

  /// `头像库`
  String get dashboardAvatarLibrary {
    return Intl.message(
      '头像库',
      name: 'dashboardAvatarLibrary',
      desc: '',
      args: [],
    );
  }

  /// `点击进入头像库`
  String get dashboardAvatarCountTooltip {
    return Intl.message(
      '点击进入头像库',
      name: 'dashboardAvatarCountTooltip',
      desc: '',
      args: [],
    );
  }

  /// `回到聊天页`
  String get btnBack2Chat {
    return Intl.message(
      '回到聊天页',
      name: 'btnBack2Chat',
      desc: '',
      args: [],
    );
  }

  /// `进入控制台`
  String get btnDashboard {
    return Intl.message(
      '进入控制台',
      name: 'btnDashboard',
      desc: '',
      args: [],
    );
  }

  /// `查看`
  String get btnView {
    return Intl.message(
      '查看',
      name: 'btnView',
      desc: '',
      args: [],
    );
  }

  /// `编辑`
  String get btnEdit {
    return Intl.message(
      '编辑',
      name: 'btnEdit',
      desc: '',
      args: [],
    );
  }

  /// `删除`
  String get btnDelete {
    return Intl.message(
      '删除',
      name: 'btnDelete',
      desc: '',
      args: [],
    );
  }

  /// `确认`
  String get btnConfirm {
    return Intl.message(
      '确认',
      name: 'btnConfirm',
      desc: '',
      args: [],
    );
  }

  /// `取消`
  String get btnCancel {
    return Intl.message(
      '取消',
      name: 'btnCancel',
      desc: '',
      args: [],
    );
  }

  /// `添加`
  String get btnAdd {
    return Intl.message(
      '添加',
      name: 'btnAdd',
      desc: '',
      args: [],
    );
  }

  /// `移除`
  String get btnRemove {
    return Intl.message(
      '移除',
      name: 'btnRemove',
      desc: '',
      args: [],
    );
  }

  /// `对话`
  String get btnChat {
    return Intl.message(
      '对话',
      name: 'btnChat',
      desc: '',
      args: [],
    );
  }

  /// `复制`
  String get btnCopy {
    return Intl.message(
      '复制',
      name: 'btnCopy',
      desc: '',
      args: [],
    );
  }

  /// `引用`
  String get btnQuote {
    return Intl.message(
      '引用',
      name: 'btnQuote',
      desc: '',
      args: [],
    );
  }

  /// `引用上下文`
  String get btnQuoteWithContext {
    return Intl.message(
      '引用上下文',
      name: 'btnQuoteWithContext',
      desc: '',
      args: [],
    );
  }

  /// `退出`
  String get btnQuit {
    return Intl.message(
      '退出',
      name: 'btnQuit',
      desc: '',
      args: [],
    );
  }

  /// `发送`
  String get btnSend {
    return Intl.message(
      '发送',
      name: 'btnSend',
      desc: '',
      args: [],
    );
  }

  /// `关闭`
  String get btnClose {
    return Intl.message(
      '关闭',
      name: 'btnClose',
      desc: '',
      args: [],
    );
  }

  /// `设置`
  String get btnSettings {
    return Intl.message(
      '设置',
      name: 'btnSettings',
      desc: '',
      args: [],
    );
  }

  /// `最大化`
  String get btnMaximize {
    return Intl.message(
      '最大化',
      name: 'btnMaximize',
      desc: '',
      args: [],
    );
  }

  /// `最小化`
  String get btnMinimize {
    return Intl.message(
      '最小化',
      name: 'btnMinimize',
      desc: '',
      args: [],
    );
  }

  /// `还原`
  String get btnRestore {
    return Intl.message(
      '还原',
      name: 'btnRestore',
      desc: '',
      args: [],
    );
  }

  /// `刷新`
  String get btnRefresh {
    return Intl.message(
      '刷新',
      name: 'btnRefresh',
      desc: '',
      args: [],
    );
  }

  /// `点击查看引用`
  String get btnClickToShowQuote {
    return Intl.message(
      '点击查看引用',
      name: 'btnClickToShowQuote',
      desc: '',
      args: [],
    );
  }

  /// `导入系统设置`
  String get btnLoadFromSystem {
    return Intl.message(
      '导入系统设置',
      name: 'btnLoadFromSystem',
      desc: '',
      args: [],
    );
  }

  /// `多选`
  String get btnMultipleChoice {
    return Intl.message(
      '多选',
      name: 'btnMultipleChoice',
      desc: '',
      args: [],
    );
  }

  /// `新建会话`
  String get btnCreateNewChat {
    return Intl.message(
      '新建会话',
      name: 'btnCreateNewChat',
      desc: '',
      args: [],
    );
  }

  /// `返回`
  String get btnBack {
    return Intl.message(
      '返回',
      name: 'btnBack',
      desc: '',
      args: [],
    );
  }

  /// `选择头像`
  String get btnSelectAvatar {
    return Intl.message(
      '选择头像',
      name: 'btnSelectAvatar',
      desc: '',
      args: [],
    );
  }

  /// `选择文件`
  String get btnPickFile {
    return Intl.message(
      '选择文件',
      name: 'btnPickFile',
      desc: '',
      args: [],
    );
  }

  /// `浏览头像库`
  String get btnPickAvatarLibrary {
    return Intl.message(
      '浏览头像库',
      name: 'btnPickAvatarLibrary',
      desc: '',
      args: [],
    );
  }

  /// `初始化设置`
  String get pageTitleInit {
    return Intl.message(
      '初始化设置',
      name: 'pageTitleInit',
      desc: '',
      args: [],
    );
  }

  /// `预设管理`
  String get pageTitlePresetManager {
    return Intl.message(
      '预设管理',
      name: 'pageTitlePresetManager',
      desc: '',
      args: [],
    );
  }

  /// `创建预设`
  String get pageTitlePresetCreate {
    return Intl.message(
      '创建预设',
      name: 'pageTitlePresetCreate',
      desc: '',
      args: [],
    );
  }

  /// `编辑预设: {name}`
  String pageTitlePresetEdit(Object name) {
    return Intl.message(
      '编辑预设: $name',
      name: 'pageTitlePresetEdit',
      desc: '',
      args: [name],
    );
  }

  /// `查看预设: {name}`
  String pageTitlePresetDetail(Object name) {
    return Intl.message(
      '查看预设: $name',
      name: 'pageTitlePresetDetail',
      desc: '',
      args: [name],
    );
  }

  /// `会话管理`
  String get pageTitleChatManager {
    return Intl.message(
      '会话管理',
      name: 'pageTitleChatManager',
      desc: '',
      args: [],
    );
  }

  /// `创建会话`
  String get pageTitleChatCreate {
    return Intl.message(
      '创建会话',
      name: 'pageTitleChatCreate',
      desc: '',
      args: [],
    );
  }

  /// `编辑会话: {name}`
  String pageTitleChatEdit(Object name) {
    return Intl.message(
      '编辑会话: $name',
      name: 'pageTitleChatEdit',
      desc: '',
      args: [name],
    );
  }

  /// `查看会话: {name}`
  String pageTitleChatDetail(Object name) {
    return Intl.message(
      '查看会话: $name',
      name: 'pageTitleChatDetail',
      desc: '',
      args: [name],
    );
  }

  /// `OpenAI秘钥管理`
  String get pageTitleOpenAITokenManager {
    return Intl.message(
      'OpenAI秘钥管理',
      name: 'pageTitleOpenAITokenManager',
      desc: '',
      args: [],
    );
  }

  /// `创建OpenAI秘钥`
  String get pageTitleOpenAITokenCreate {
    return Intl.message(
      '创建OpenAI秘钥',
      name: 'pageTitleOpenAITokenCreate',
      desc: '',
      args: [],
    );
  }

  /// `编辑OpenAI秘钥`
  String get pageTitleOpenAITokenEdit {
    return Intl.message(
      '编辑OpenAI秘钥',
      name: 'pageTitleOpenAITokenEdit',
      desc: '',
      args: [],
    );
  }

  /// `查看OpenAI秘钥`
  String get pageTitleOpenAITokenDetail {
    return Intl.message(
      '查看OpenAI秘钥',
      name: 'pageTitleOpenAITokenDetail',
      desc: '',
      args: [],
    );
  }

  /// `消息记录`
  String get pageTitleChatMessageManager {
    return Intl.message(
      '消息记录',
      name: 'pageTitleChatMessageManager',
      desc: '',
      args: [],
    );
  }

  /// `头像管理`
  String get pageTitleAvatarManager {
    return Intl.message(
      '头像管理',
      name: 'pageTitleAvatarManager',
      desc: '',
      args: [],
    );
  }

  /// `创建时间`
  String get columnNameCreatedAt {
    return Intl.message(
      '创建时间',
      name: 'columnNameCreatedAt',
      desc: '',
      args: [],
    );
  }

  /// `最后更新时间`
  String get columnNameUpdatedAt {
    return Intl.message(
      '最后更新时间',
      name: 'columnNameUpdatedAt',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get columnNamePresetUUID {
    return Intl.message(
      'ID',
      name: 'columnNamePresetUUID',
      desc: '',
      args: [],
    );
  }

  /// `预设名称`
  String get columnNamePresetName {
    return Intl.message(
      '预设名称',
      name: 'columnNamePresetName',
      desc: '',
      args: [],
    );
  }

  /// `AI昵称`
  String get columnNamePresetNickname {
    return Intl.message(
      'AI昵称',
      name: 'columnNamePresetNickname',
      desc: '',
      args: [],
    );
  }

  /// `会话数`
  String get columnNamePresetChatCount {
    return Intl.message(
      '会话数',
      name: 'columnNamePresetChatCount',
      desc: '',
      args: [],
    );
  }

  /// `默认预设`
  String get columnNamePresetIsDefault {
    return Intl.message(
      '默认预设',
      name: 'columnNamePresetIsDefault',
      desc: '',
      args: [],
    );
  }

  /// `{section, plural, =1 {是} other {否}}`
  String columnValueFormatPresetIsDefault(int section) {
    return Intl.plural(
      section,
      one: '是',
      other: '否',
      name: 'columnValueFormatPresetIsDefault',
      desc: '',
      args: [section],
    );
  }

  /// `操作`
  String get columnNameActions {
    return Intl.message(
      '操作',
      name: 'columnNameActions',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get columnNameChatUUID {
    return Intl.message(
      'ID',
      name: 'columnNameChatUUID',
      desc: '',
      args: [],
    );
  }

  /// `会话名称`
  String get columnNameChatName {
    return Intl.message(
      '会话名称',
      name: 'columnNameChatName',
      desc: '',
      args: [],
    );
  }

  /// `会话预设`
  String get columnNameChatPreset {
    return Intl.message(
      '会话预设',
      name: 'columnNameChatPreset',
      desc: '',
      args: [],
    );
  }

  /// `OpenAI秘钥`
  String get columnNameOpenAIToken {
    return Intl.message(
      'OpenAI秘钥',
      name: 'columnNameOpenAIToken',
      desc: '',
      args: [],
    );
  }

  /// `最后会话时间`
  String get columnNameChatLastChatedAt {
    return Intl.message(
      '最后会话时间',
      name: 'columnNameChatLastChatedAt',
      desc: '',
      args: [],
    );
  }

  /// `消息数`
  String get columnNameChatMessageCount {
    return Intl.message(
      '消息数',
      name: 'columnNameChatMessageCount',
      desc: '',
      args: [],
    );
  }

  /// `头像`
  String get columnNameChatAvatar {
    return Intl.message(
      '头像',
      name: 'columnNameChatAvatar',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get columnNameOpenAITokenUUID {
    return Intl.message(
      'ID',
      name: 'columnNameOpenAITokenUUID',
      desc: '',
      args: [],
    );
  }

  /// `秘钥名称`
  String get columnNameOpenAITokenName {
    return Intl.message(
      '秘钥名称',
      name: 'columnNameOpenAITokenName',
      desc: '',
      args: [],
    );
  }

  /// `秘钥内容`
  String get columnNameOpenAITokenContent {
    return Intl.message(
      '秘钥内容',
      name: 'columnNameOpenAITokenContent',
      desc: '',
      args: [],
    );
  }

  /// `会话数`
  String get columnNameOpenAITokenChatCount {
    return Intl.message(
      '会话数',
      name: 'columnNameOpenAITokenChatCount',
      desc: '',
      args: [],
    );
  }

  /// `启用状态`
  String get columnNameOpenAITokenStatus {
    return Intl.message(
      '启用状态',
      name: 'columnNameOpenAITokenStatus',
      desc: '',
      args: [],
    );
  }

  /// `{section, plural, =1 {是} other {否}}`
  String columnValueFormatOpenAITokenStatus(int section) {
    return Intl.plural(
      section,
      one: '是',
      other: '否',
      name: 'columnValueFormatOpenAITokenStatus',
      desc: '',
      args: [section],
    );
  }

  /// `角色`
  String get columnNamePresetMessageRole {
    return Intl.message(
      '角色',
      name: 'columnNamePresetMessageRole',
      desc: '',
      args: [],
    );
  }

  /// `消息内容`
  String get columnNamePresetMessageContent {
    return Intl.message(
      '消息内容',
      name: 'columnNamePresetMessageContent',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get columnNameChatMessageUUID {
    return Intl.message(
      'ID',
      name: 'columnNameChatMessageUUID',
      desc: '',
      args: [],
    );
  }

  /// `发送角色`
  String get columnNameChatMessageRole {
    return Intl.message(
      '发送角色',
      name: 'columnNameChatMessageRole',
      desc: '',
      args: [],
    );
  }

  /// `消息内容`
  String get columnNameChatMessageContent {
    return Intl.message(
      '消息内容',
      name: 'columnNameChatMessageContent',
      desc: '',
      args: [],
    );
  }

  /// `发送时间`
  String get columnNameChatMessageCreatedAt {
    return Intl.message(
      '发送时间',
      name: 'columnNameChatMessageCreatedAt',
      desc: '',
      args: [],
    );
  }

  /// `启用消息数`
  String get columnNameChatMessageQuoteCount {
    return Intl.message(
      '启用消息数',
      name: 'columnNameChatMessageQuoteCount',
      desc: '',
      args: [],
    );
  }

  /// `基础信息`
  String get cardTitleBasicInfo {
    return Intl.message(
      '基础信息',
      name: 'cardTitleBasicInfo',
      desc: '',
      args: [],
    );
  }

  /// `预设消息`
  String get cardTitlePresetMessages {
    return Intl.message(
      '预设消息',
      name: 'cardTitlePresetMessages',
      desc: '',
      args: [],
    );
  }

  /// `添加预设消息`
  String get cardTitleAddPresetMessage {
    return Intl.message(
      '添加预设消息',
      name: 'cardTitleAddPresetMessage',
      desc: '',
      args: [],
    );
  }

  /// `主题设置`
  String get cardTitleThemeConfig {
    return Intl.message(
      '主题设置',
      name: 'cardTitleThemeConfig',
      desc: '',
      args: [],
    );
  }

  /// `代理设置`
  String get cardTitleProxyConfig {
    return Intl.message(
      '代理设置',
      name: 'cardTitleProxyConfig',
      desc: '',
      args: [],
    );
  }

  /// `启用状态`
  String get columnNameProxyStatus {
    return Intl.message(
      '启用状态',
      name: 'columnNameProxyStatus',
      desc: '',
      args: [],
    );
  }

  /// `代理主机`
  String get columnNameProxyHost {
    return Intl.message(
      '代理主机',
      name: 'columnNameProxyHost',
      desc: '',
      args: [],
    );
  }

  /// `代理端口`
  String get columnNameProxyPort {
    return Intl.message(
      '代理端口',
      name: 'columnNameProxyPort',
      desc: '',
      args: [],
    );
  }

  /// `ID`
  String get columnNameAvatarUUID {
    return Intl.message(
      'ID',
      name: 'columnNameAvatarUUID',
      desc: '',
      args: [],
    );
  }

  /// `头像`
  String get columnNameAvatarImage {
    return Intl.message(
      '头像',
      name: 'columnNameAvatarImage',
      desc: '',
      args: [],
    );
  }

  /// `会话数`
  String get columnNameAvatarChatCount {
    return Intl.message(
      '会话数',
      name: 'columnNameAvatarChatCount',
      desc: '',
      args: [],
    );
  }

  /// `系统`
  String get messageRoleSystem {
    return Intl.message(
      '系统',
      name: 'messageRoleSystem',
      desc: '',
      args: [],
    );
  }

  /// `用户`
  String get messageRoleUser {
    return Intl.message(
      '用户',
      name: 'messageRoleUser',
      desc: '',
      args: [],
    );
  }

  /// `AI`
  String get messageRoleAssistant {
    return Intl.message(
      'AI',
      name: 'messageRoleAssistant',
      desc: '',
      args: [],
    );
  }

  /// `预设列表`
  String get tableTitlePresetList {
    return Intl.message(
      '预设列表',
      name: 'tableTitlePresetList',
      desc: '',
      args: [],
    );
  }

  /// `会话列表`
  String get tableTitleChatList {
    return Intl.message(
      '会话列表',
      name: 'tableTitleChatList',
      desc: '',
      args: [],
    );
  }

  /// `OpenAI秘钥列表`
  String get tableTitleOpenAITokenList {
    return Intl.message(
      'OpenAI秘钥列表',
      name: 'tableTitleOpenAITokenList',
      desc: '',
      args: [],
    );
  }

  /// `头像列表`
  String get tableTitleAvatarList {
    return Intl.message(
      '头像列表',
      name: 'tableTitleAvatarList',
      desc: '',
      args: [],
    );
  }

  /// `启用`
  String get proxyEnableLabel {
    return Intl.message(
      '启用',
      name: 'proxyEnableLabel',
      desc: '',
      args: [],
    );
  }

  /// `禁用`
  String get proxyDisableLabel {
    return Intl.message(
      '禁用',
      name: 'proxyDisableLabel',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'zh', countryCode: 'CN'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
