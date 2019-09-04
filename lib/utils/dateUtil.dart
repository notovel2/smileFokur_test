import 'package:smile_fokus_test/constant/enums.dart';

class DateUtil {
  static String getPattern(DisplayType displayType) {
    switch (displayType) {
      case DisplayType.month:
        return "MMM yyyy";
      case DisplayType.day:
        return "dd MMM yyyy";
    }
    return "MMM yyyy";
  }
}