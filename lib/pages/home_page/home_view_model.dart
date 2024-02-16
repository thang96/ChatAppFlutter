import 'package:base_core/presenter/base/base_view_model.dart';
import 'package:chat_app/models/chat_user.dart';

class HomeViewModel extends BaseViewModel {
  late bool isSearch = false;
  late List listUser = [];
  late List listSearchUser = [];
}
