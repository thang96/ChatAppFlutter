part of resources;

class Gaps {
  static Widget hGap2 = SizedBox(width: 2.dp);
  static Widget hGap5 = SizedBox(width: 5.dp);
  static Widget hGap10 = SizedBox(width: 10.dp);
  static Widget hGap20 = SizedBox(width: 20.dp);

  static Widget vGap2 = SizedBox(
    height: 2.dp,
  );

  static Widget vGap5 = SizedBox(
    height: 5.dp,
  );
  static Widget vGap6 = SizedBox(
    height: 6.dp,
  );
  static Widget vGap7 = SizedBox(
    height: 7.dp,
  );
  static Widget vGap8 = SizedBox(
    height: 8.dp,
  );
  static Widget vGap9 = SizedBox(
    height: 9.dp,
  );
  static Widget vGap10 = SizedBox(
    height: 10.dp,
  );
  static Widget vGap20 = SizedBox(
    height: 20.dp,
  );
  static Widget vGap56 = SizedBox(
    height: 56.dp,
  );
  static Widget vGap100 = SizedBox(
    height: 100.dp,
  );
  // Đường kẻ ngang rgb(151, 161, 167)
  static Widget hLine(
          {double height = 1.00,
          Color color = const Color.fromRGBO(151, 161, 167, 1)}) =>
      Divider(
        height: height,
        color: color,
      );
  // Đường kẻ dọc
  static Widget vLine(
          {double width = 1.00, Color color = const Color(0xFFE4E5E7)}) =>
      VerticalDivider(
        width: width,
        color: color,
      );
  // Hộp box trống
  static Widget empty = const SizedBox.shrink();
}
