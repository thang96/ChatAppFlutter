import 'package:base_core/presenter/base/base_view_model.dart';
import 'package:flutter/material.dart';

class LoginViewModel extends BaseViewModel {
  final TextEditingController username = new TextEditingController();
  final TextEditingController password = new TextEditingController();
  bool passwordVisible = true;
}
