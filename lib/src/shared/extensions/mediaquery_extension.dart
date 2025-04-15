import 'package:flutter/cupertino.dart';

extension MediaQueryExtension on BuildContext {
  MediaQueryData get mediaQueryData => MediaQuery.of(this);

  double get screenWidth => mediaQueryData.size.width;
  double get screenHeight => mediaQueryData.size.height;
}
