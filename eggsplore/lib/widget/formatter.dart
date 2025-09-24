// lib/widget/formatter.dart
String formatRupiah(double value) {
  int v = value.round();
  String s = v.toString();
  String res = '';
  int cnt = 0;
  for (int i = s.length - 1; i >= 0; i--) {
    res = s[i] + res;
    cnt++;
    if (cnt % 3 == 0 && i != 0) res = '.' + res;
  }
  return 'Rp $res';
}
