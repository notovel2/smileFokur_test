import 'package:flutter/widgets.dart';

class CustomColors {
  static final orange = _Colors(color: Color.fromRGBO(250, 153, 23, 1), hex: "#FA9917");
  static final black = _Colors(color: Color.fromRGBO(51, 51, 51, 1), hex: "#333333");
  static final bgBlack = _Colors(color: Color.fromRGBO(10, 15, 20, 1), hex: "#0A0F14");
  static final gray = _Colors(color: Color.fromRGBO(224, 224, 224, 1), hex: "#E0E0E0");
  static final bgGray =  _Colors(color: Color.fromRGBO(242, 242, 242, 1), hex: "#F2F2F2");
  static final orangeOpacity = _Colors(color: Color.fromRGBO(255, 229, 195, 1), hex: "#FFE5C3");
  static final border = _Colors(color: Color.fromRGBO(189, 189, 189, 1), hex: "#BDBDBD");
  static final loadingBG = _Colors(color: Color.fromRGBO(189, 189, 189, 0.8), hex: "#BDBDBD");
}

class _Colors {
  _Colors({
    this.color,
    this.hex
  });
  final Color color;
  final String hex;
}