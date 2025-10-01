String formatRupiah(double number) {
  return 'Rp${number.toStringAsFixed(0).replaceAllMapped(RegExp(r'\B(?=(\d{3})+(?!\d))'), (match) => '.')}';
}
