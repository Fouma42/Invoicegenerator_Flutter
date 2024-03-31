import 'package:logger/logger.dart';
import 'package:logger/web.dart';

class Calculate {
  Logger logger = Logger();

  String calculateTotalAmount(int amount1, int amount2, int amount3) {
    int total = amount1 + amount2 + amount3;
    String totalString = '$total EUR';
    return totalString;
  }
}
