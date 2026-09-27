String formatRupiah(num value) {
  final rounded = value.round();
  final digits = rounded.abs().toString();
  final buffer = StringBuffer();
  var count = 0;
  for (var i = digits.length - 1; i >= 0; i--) {
    buffer.write(digits[i]);
    count++;
    if (count == 3 && i != 0) {
      buffer.write('.');
      count = 0;
    }
  }
  final reversed =
      buffer.toString().split('').reversed.join();
  final sign = rounded < 0 ? '-' : '';
  return '$sign Rp$reversed'.replaceFirst(' ', '');
}
