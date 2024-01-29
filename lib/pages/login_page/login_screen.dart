import 'package:base_core/resources.dart';
import 'package:chat_app/gen/assets.gen.dart';
import 'package:flutter/material.dart';

import '../../widgets/InputSection.dart';
import 'login_page.dart';

class LoginScreen {
  BuildContext _context;
  LoginState _main;
  LoginScreen(this._context, this._main);

  Widget screen() {
    return _mainScreen(_context);
  }

  _mainScreen(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Chat FireBase'),
        ),
        body: Center(
          child: Column(
            children: [
              Gaps.vGap56,
              Text(
                'Đăng nhập',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.lightBlue,
                    fontWeight: FontWeight.bold,
                    fontStyle: FontStyle.italic),
              ),
              Gaps.vGap20,
              InputSection('User Name', _main.vm.username,
                  _main.onChangedUsername, false, false),
              Gaps.vGap10,
              InputSection('Password', _main.vm.password,
                  _main.onChangedPassword, _main.vm.passwordVisible, true),
              Gaps.vGap10,
              ElevatedButton(
                onPressed: _main.loginAuthentication,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
              Gaps.vGap20,
              ElevatedButton.icon(
                  onPressed: () => _main.loginWithGoogle(),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      shape: StadiumBorder(),
                      padding:
                          EdgeInsets.symmetric(horizontal: 50, vertical: 5)),
                  icon: R.images.icons.icGoogle.image(width: 40, height: 40),
                  label: RichText(
                    text: TextSpan(
                        style: TextStyle(fontSize: 16, color: Colors.white),
                        children: [
                          TextSpan(text: 'Sign In with '),
                          TextSpan(
                              text: 'Google',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 18)),
                        ]),
                  )),
            ],
          ),
        ));
  }
}
