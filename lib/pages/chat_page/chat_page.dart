import 'package:base_core/presenter/base/base_screen.dart';
import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/pages/chat_page/chat_screen.dart';
import 'package:chat_app/pages/chat_page/chat_view_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return ChatPageState();
  }
}

class ChatPageState extends BaseCreen<ChatPage, ChatViewModel> {
  @override
  void initViewModel() {
    Get.lazyPut(() => ChatViewModel());
  }

  @override
  Widget initWidget(BuildContext context) {
    return ChatScreen(context, this).screen();
  }

  void sendMessage() {

    if (vm.messageController.value.text.trim().isNotEmpty) {
      FireBases.sendMessage(
          vm.currentUserChat, vm.messageController.value.text);

      vm.messageController.value = TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: ''.length),
      );
    }
  }
}
