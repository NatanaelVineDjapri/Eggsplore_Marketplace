import 'package:flutter/material.dart';

class Appsized{
  final BuildContext context;
  Appsized (this.context);

  //Padding and Margin sizes
  double get xss => MediaQuery.of(context).size.height * 0.001; // ~0.5%
  double get xs => MediaQuery.of(context).size.height * 0.005; // ~0.5%
  double get sm => MediaQuery.of(context).size.height * 0.01;  // ~1%
  double get md => MediaQuery.of(context).size.height * 0.02;  // ~2%
  double get lg => MediaQuery.of(context).size.height * 0.03;  // ~3%
  double get xl => MediaQuery.of(context).size.height * 0.04;  // ~4%
  double get xxl => MediaQuery.of(context).size.height * 0.06; // ~6%
  double get xxxl => MediaQuery.of(context).size.height * 0.08; // ~8%
  double get defaultSpace => MediaQuery.of(context).size.height * 0.03;
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