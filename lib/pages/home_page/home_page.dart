import 'package:base_core/presenter/base/base_screen.dart';
import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/models/chat_user.dart';
import 'package:chat_app/pages/app_navigation/app_router.dart';
import 'package:chat_app/pages/home_page/home_screen.dart';
import 'package:chat_app/pages/home_page/home_view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatefulWidget {
  State<StatefulWidget> createState() => HomeState();
}

class HomeState extends BaseCreen<HomePage, HomeViewModel> {
  @override
  void initViewModel() {
    Get.lazyPut(() => HomeViewModel());
  }

  @override
  Widget initWidget(BuildContext context) {
      return HomeScreen(context, this).screen();
  }

  @override
  void initState() {
    super.initState();
  }

  void gotoProfile() {
    Get.toNamed(AppRouter.pro_file, arguments: FireBases.me);
  }

  void changeIsSearch() {
    setState(() {
      vm.listSearchUser = vm.listUser;
      vm.isSearch = !vm.isSearch;
    });
  }

  void filterUser(String value) {
    setState(() {
      vm.listSearchUser.clear();
      for (var i in vm.listUser) {
        if ('${i.username.toLowerCase()}'.contains('${value.toLowerCase()}') ||
            '${i.email.toLowerCase()}'.contains('${value.toLowerCase()}')) {
          vm.listSearchUser.add(i);
        }
      }
    });
  }

  void handlerClickUser(ChatUser currentUser) {
    Get.toNamed(AppRouter.chat_page,
        arguments: {'currentUserChat': currentUser});
  }
}
