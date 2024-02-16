import 'package:base_core/presenter/base/base_screen.dart';
import 'package:chat_app/apis/FirebaseAPIs.dart';
import 'package:chat_app/pages/app_navigation/app_router.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../widgets/DialogWidget.dart';
import 'login_screen.dart';
import 'login_view_model.dart';

class LoginPage extends StatefulWidget {
  State<StatefulWidget> createState() => LoginState();
}

class LoginState extends BaseCreen<LoginPage, LoginViewModel> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void initViewModel() {
    Get.lazyPut(() => LoginViewModel());
  }

  @override
  Widget initWidget(BuildContext context) {
    return LoginScreen(context, this).screen();
  }

  void loginWithGoogle() {
    Dialogs.showProgressBar(context);
    _signInWithGoogle().then((user) async {
      if (user != null) {
        if (await FireBases.isUserExist()) {
          await FireBases.getSelfInfo().then((value) {
            Navigator.pop(context);
            Get.offAndToNamed(AppRouter.home);
          });
        } else {
          await FireBases.createUser().then((value) {
            Navigator.pop(context);
            Get.offAndToNamed(AppRouter.home);
          });
        }
      }
    });
  }

  void loginAuthentication() {
    if (vm.username.text == 'admin' && vm.password.text == '123456') {
      Get.offAndToNamed(AppRouter.home);
    }
  }

  void onChangedUsername(String str) {
    // String free = numberValidar(str);
    // vm.userName.value = TextEditingValue(
    //   text: formatAmount(free),
    //   selection: TextSelection.collapsed(offset: formatAmount(free).length),
    // );
  }

  Future<UserCredential?> _signInWithGoogle() async {
    try {
      // await InternetAddress.lookup('google.com');
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      if (googleUser == null) {
        return null;
      } else {
        // Obtain the auth details from the request
        final GoogleSignInAuthentication? googleAuth =
            await googleUser?.authentication;

        // Create a new credential
        final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken,
          idToken: googleAuth?.idToken,
        );

        // Once signed in, return the UserCredential
        return await FireBases.auth.signInWithCredential(credential);
      }
    } catch (err) {
      Navigator.of(context).pop();
      Dialogs.showSnackBar(context, 'Tài khoản hoặc mật khẩu không đúng');
    }
  }

  void onChangedPassword(String str) {}

  @override
  void dispose() {
    super.dispose();
    vm.username.dispose();
    vm.password.dispose();
  }
}
