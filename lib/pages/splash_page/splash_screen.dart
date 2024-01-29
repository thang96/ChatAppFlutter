import 'package:chat_app/pages/splash_page/splash_page.dart';
import 'package:flutter/material.dart';

import '../../gen/assets.gen.dart';

class SplashScreen {
  BuildContext _context;
  SplashState _main;
  SplashScreen(this._context, this._main);
  Widget screen() {
    return _mainScreen(_context);
  }

  _mainScreen(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromRGBO(69, 232, 250, 0.7),
        body: Center(
            child: AnimatedBuilder(
          animation: Listenable.merge([
            _main.moveController,
            _main.rotateController,
            _main.scaleRepeatAnimation
          ]),
          builder: (context, child) {
            return Transform.rotate(
                angle: _main.rotateAnimation.value,
                child: Transform.translate(
                  offset: _main.moveAnimation.value,
                  child: Transform.scale(
                    scale: _main.scaleRepeatAnimation.value,
                    child: R.images.icons.icLauncher
                        .image(width: 100, height: 100),
                  ),
                ));
          },
        )));
  }
}
// R.images.icons.icLauncher.image(width: 150, height: 150)
