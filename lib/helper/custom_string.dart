// import 'package:intl/intl.dart';

extension PowerString on String {

  String smallSentence() {
    if (length > 170) {
      return substring(0, 170) + '...';
    } else {
      return this;
    }
  }

  String smallFileName() {
    if (length > 13) {
      return substring(0, 13) + '...';
    } else {
      return this;
    }
  }

  String firstFewWords() {
    int startIndex = 0, indexOfSpace = 0;

    for (int i = 0; i < 6; i++) {
      indexOfSpace = indexOf(' ', startIndex);
      if (indexOfSpace == -1) {
        //-1 is when character is not found
        return this;
      }
      startIndex = indexOfSpace + 1;
    }

    return substring(0, indexOfSpace) + '...';
  }

  // String formatCurrency(d) {
  //   final currencyFormatter = NumberFormat('#,##0.00', 'ID');
  //   return currencyFormatter.format(d); // 100.286.020.524,17
  // }
}