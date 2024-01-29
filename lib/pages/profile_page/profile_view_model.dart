
import 'package:base_core/presenter/base/base_view_model.dart';
import 'package:flutter/cupertino.dart';

class ProfileViewModel extends BaseViewModel{
  final TextEditingController usernameController = new TextEditingController();
  late String? userAvatar = '';
}