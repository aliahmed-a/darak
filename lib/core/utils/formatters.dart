import 'package:intl/intl.dart';

class Formatters {
  Formatters._();

  static final _currency = NumberFormat.currency(locale: 'en_US', symbol: '', decimalDigits: 0);

  static String currency(num amount) => '${_currency.format(amount)} IQD';

  static String date(DateTime value) => DateFormat.yMMMd(Intl.defaultLocale).format(value);

  static String dateTime(DateTime value) => DateFormat.yMMMd(Intl.defaultLocale).add_jm().format(value);
}
