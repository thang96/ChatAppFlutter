import 'package:base_core/presenter/base/base_view_model.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatViewModel extends BaseViewModel{
  final ChatUser currentUserChat = Get.arguments['currentUserChat'];
  late List listMsg = [];
  final TextEditingController messageController = TextEditingController();
}