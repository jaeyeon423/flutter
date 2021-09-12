import 'package:intl/intl.dart';

class DataUtils {
  static String numberFormat(double? value){
    return NumberFormat("###,###,###,###").format(value);
  }


}