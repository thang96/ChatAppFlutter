part of resources;

final ds = _DesignSite();

class _DesignSite {
  final width = ScreenUtil.getInstance().screenWidth;
  final height = ScreenUtil.getInstance().screenHeight;
  final bottomBarHeight = ScreenUtil.getInstance().bottomBarHeight;
  final statusBarHeight = ScreenUtil.getInstance().statusBarHeight;
}

extension IntExtension on int {
  double get dp {
    return ScreenUtil.getInstance().getWidth(toDouble());
  }

  double get sp {
    return ScreenUtil.getInstance().getSp(toDouble());
  }
}

extension DoubleExtension on double {
  double get dp {
    return ScreenUtil.getInstance().getWidth(this);
  }

  double get sp {
    return ScreenUtil.getInstance().getSp(this);
  }
}
