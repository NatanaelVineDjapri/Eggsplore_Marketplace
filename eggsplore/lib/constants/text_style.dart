import 'package:eggsplore/constants/sizes.dart';
import 'package:flutter/material.dart';

class AppTextStyle{
  // --- STYLE LAMA ANDA (TETAP ADA) ---
  static const TextStyle bottomBannerTextStyle = TextStyle(
    color: Colors.white,
    fontWeight: FontWeight.bold
  );

static const TextStyle mainTitle = TextStyle(
    fontSize: Appsized.fontxl,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  static const TextStyle mainTitle2 = TextStyle(
    fontSize: Appsized.fontxxl,
    fontWeight: FontWeight.bold,
    color: Colors.black54,
  );

  static const TextStyle accentTitle = TextStyle(
    fontSize: Appsized.fontxxl,
    fontWeight: FontWeight.bold,
    color: Colors.orange,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: Appsized.fontSm,
    color: Colors.black87,
  );

  static const TextStyle footer = TextStyle(
    fontSize: Appsized.fontSm,
    color: Colors.grey,
  );
  
  static const TextStyle footerAccent = TextStyle(
    fontSize: Appsized.fontSm,
    color: Colors.indigo,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle notificationHeader = TextStyle(
    fontSize: Appsized.fontLg,
    fontWeight: FontWeight.bold,
    color: Colors.black,
  );

  // --- STYLE BARU UNTUK SHOP INFO CARD (TAMBAHKAN INI) ---

  static const TextStyle shopTitle = TextStyle(
    fontSize: Appsized.fontLg, // Ukuran untuk judul toko
    fontWeight: FontWeight.bold,
    color: Colors.black87,
  );

  static const TextStyle description = TextStyle(
    fontSize: Appsized.fontSm, // Ukuran untuk deskripsi
    color: Colors.black54,
  );

  static const TextStyle shopStatsValue = TextStyle(
    fontSize: Appsized.fontMd, // Ukuran untuk angka statistik
    fontWeight: FontWeight.w600,
    color: Colors.black,
  );

  static const TextStyle shopStatsLabel = TextStyle(
    fontSize: Appsized.fontXs, // Ukuran untuk label statistik
    color: Colors.grey,
  );
}