import 'dart:async';

import 'package:base_core/presenter/base/base_screen.dart';
import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/pages/splash_page/splash_screen.dart';
import 'package:chat_app/pages/splash_page/splash_view_model.dart';
import 'package:chat_app/widgets/DialogWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import '../app_navigation/app_router.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => SplashState();
}

class SplashState extends BaseCreen<SplashPage, SplashViewModel>
    with TickerProviderStateMixin {
  late AnimationController moveController;
  late AnimationController rotateController;
  late AnimationController scaleRepeatController;
  late Animation<Offset> moveAnimation;
  late Animation<double> rotateAnimation;
  late Animation<double> scaleRepeatAnimation;
  final box = GetStorage();
  StreamSubscription<InternetConnectionStatus>? listener;
  Timer? check;

  @override
  void initViewModel() {
    Get.lazyPut(() => SplashViewModel());
  }

  @override
  Widget initWidget(BuildContext context) {
    return SplashScreen(context, this).screen();
  }

  @override
  void initState() {
    super.initState();
    initAnimation();
    initConnection();
    const duration = const Duration(milliseconds: 200);
    check = Timer.periodic(duration, (time) => initConnection());
  }


  void initConnection() async {
    bool result = await InternetConnectionChecker().hasConnection;
    listener = InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          if (result == true) {
            loginWithUser();
          }
          break;
        case InternetConnectionStatus.disconnected:
          Dialogs.showMessageDialog(context);
          break;
      }
    });
  }

  @override
  void didUpdateWidget(covariant SplashPage oldWidget) {

    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() async {
    check?.cancel();
    moveController.dispose();
    rotateController.dispose();
    scaleRepeatController.dispose();
    super.dispose();
  }



  void loginWithUser() async {
    await Future.delayed(const Duration(seconds: 2));
    if (FireBases.auth.currentUser != null) {
      await FireBases.getSelfInfo().then((value) {
        Get.offAndToNamed(AppRouter.home);
      });
    } else {
      Get.offAndToNamed(AppRouter.login);
    }
  }

  void initAnimation() async {
    moveController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    rotateController = AnimationController(
      vsync: this,
      duration: Duration(microseconds: 500),
    );

    scaleRepeatController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 500),
    );

    moveAnimation = Tween<Offset>(
      begin: Offset(0.0, 0.0),
      end: Offset(0.0, -100.0),
    ).animate(moveController);

    rotateAnimation =
        Tween<double>(begin: 0, end: 360).animate(rotateController);

    scaleRepeatAnimation = Tween<double>(begin: 1, end: 1.2).animate(
        CurvedAnimation(
            parent: scaleRepeatController, curve: Interval(0, 0.5)));

    // Bắt đầu animation
    rotateController.forward();
    moveController.forward();

    rotateController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        rotateController.reverse();
      }
    });
    moveController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        moveController.reverse();
      }
    });
    await Future.delayed(const Duration(seconds: 1)).then((value) {
      scaleRepeatController.forward();
    });
    scaleRepeatController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        scaleRepeatController.reverse();
      } else if (status == AnimationStatus.dismissed) {
        scaleRepeatController.forward();
      }
    });
  }
}
