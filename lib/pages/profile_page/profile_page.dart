import 'dart:io';

import 'package:base_core/presenter/base/base_screen.dart';
import 'package:chat_app/pages/app_navigation/app_router.dart';
import 'package:chat_app/pages/profile_page/profile_screen.dart';
import 'package:chat_app/pages/profile_page/profile_view_model.dart';
import 'package:chat_app/widgets/DialogWidget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../apis/FirebaseAPIs.dart';

class ProFilePage extends StatefulWidget {
  const ProFilePage({super.key});

  @override
  State<ProFilePage> createState() => ProFilePageState();
}

class ProFilePageState extends BaseCreen<ProFilePage, ProfileViewModel> {
  final ImagePicker picker = ImagePicker();

  @override
  void initViewModel() {
    Get.lazyPut(() => ProfileViewModel());
  }

  @override
  Widget initWidget(BuildContext context) {
    return ProfileScreen(this, context).screen();
  }

  void updateInformation() {
    Dialogs.showProgressBar(context);
    String userName = vm.usernameController.text;
    FireBases.updateUserInfo(userName).then((value) {
      Navigator.pop(context);
    });
  }

  void logoutAccount() async {
    Dialogs.showProgressBar(context);
    await FireBases.signOutAccount().then((value) {
      Navigator.pop(context);
      Get.offAllNamed(AppRouter.login);
    });
  }

  @override
  void initState() {
    super.initState();
    initValue();
    print('${FireBases.me.avatar}');
  }

  @override
  void dispose() {
    super.dispose();
    vm.usernameController.dispose();
  }

  void initValue() {
    vm.usernameController.value = TextEditingValue(
      text: '${FireBases.me.username}',
      selection: TextSelection.collapsed(offset: FireBases.me.username.length),
    );
  }

  void openCamera() async {
    // XFile? result = captureAPhoto() as XFile;
    // setState(() {
    //   vm.userAvatar = result as File?;
    // });
    final XFile? image = await picker.pickImage(source: ImageSource.camera);
    setState(() {
      // vm.userAvatar = image?.path;
      // FireBases.updateProfile(File('${image?.path}'));
    });
    FireBases.updateProfile(File('${image?.path}'));
  }

  void openGallery() async {
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    setState(() {
      vm.userAvatar = image?.path;
      // FireBases.updateProfile(File('${image?.path}'));
    });
    FireBases.updateProfile(File('${image?.path}'));
    FireBases.getSelfInfo();
  }
}
