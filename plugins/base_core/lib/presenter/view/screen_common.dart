import 'package:base_core/presenter/base/base_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

abstract class ScreenCommon<T extends StatefulWidget, VM extends BaseViewModel>
    extends State<T> with AutomaticKeepAliveClientMixin {
  late VM vm;
  @override
  @mustCallSuper
  void initState() {
    super.initState();
    initViewModel();
    vm = Get.find<VM>();
  }

  @override
  @mustCallSuper
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<VM>(
        init: vm,
        builder: (controller) {
          return initWidget(context);
        });
  }

  @override
  bool get wantKeepAlive => true;

  void initViewModel();

  Widget initWidget(BuildContext context);
}
