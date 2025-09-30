import 'package:flutter/material.dart';

class Appsized{
  final BuildContext context;
  Appsized (this.context);

  //Padding and Margin sizes
  double get width => MediaQuery.of(context).size.width;
  double get height => MediaQuery.of(context).size.height;

  // Padding / spacing
  double get xss => height * 0.001; // ~0.1%
  double get xs  => height * 0.005; // ~0.5%
  double get sm  => height * 0.01;  // ~1%
  double get md  => height * 0.02;  // ~2%
  double get lg  => height * 0.03;  // ~3%
  double get xl  => height * 0.04;  // ~4%
  double get xxl => height * 0.06;  // ~6%
  double get xxxl=> height * 0.08;  // ~8%
  double get defaultSpace => height * 0.03;

  double get hsm => width * 0.02;
  double get hmd => width * 0.04;
  double get hlg => width * 0.06;

  //Font sizes
  static const double fontSm = 14.0;
  static const double fontMd = 16.0;
  static const double fontLg = 18.0;
  static const double fontxl= 24.0;
  static const double fontxxl= 30.0;

  //Icon sizes
  static const double iconXs = 12.0;
  static const double iconSm = 16.0;
  static const double iconMd = 24.0;
  static const double iconLg = 32.0;

}