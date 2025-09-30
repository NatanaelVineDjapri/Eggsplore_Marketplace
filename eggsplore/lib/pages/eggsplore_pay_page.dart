import 'package:eggsplore/model/user.dart';
import 'package:flutter/material.dart';
import 'package:eggsplore/constants/sizes.dart';
import 'package:eggsplore/constants/colors.dart';
import 'package:eggsplore/widget/eggsplore_pay/balance_display.dart';
import 'package:eggsplore/widget/topup_item.dart';
import 'package:eggsplore/service/user_service.dart';
import 'package:eggsplore/widget/eggsplore_header.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/widget/formatter.dart';

class EggsplorePayPage extends StatefulWidget {
  const EggsplorePayPage({super.key});

  @override
  State<EggsplorePayPage> createState() => _EggsplorePayPageState();
}

class _EggsplorePayPageState extends State<EggsplorePayPage> {
  late Future<User?> userFuture;
  double balance = 0;
  String username = "Pengguna";

  @override
  void initState() {
    super.initState();
    // Ambil data user dari API
    userFuture = UserService.getCurrentUser();
    userFuture.then((user) {
      if (user != null) {
        setState(() {
          username = user.name;
          balance = user.balance;
        });
      }
    });
  }

  void _topUp(double amount) async {
    final newBalance = await UserService.topUp(amount);
    if (newBalance != null) {
      setState(() => balance = newBalance);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Top Up berhasil: ${formatRupiah(amount)}")),
      );
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text("Top Up gagal, coba lagi")));
    }
  }

  Widget _buildPromotionalBanner(Appsized sizes) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: sizes.md, vertical: sizes.sm),
      height: sizes.xxl + sizes.md,
      decoration: BoxDecoration(
        color: Colors.lightGreen.shade50,
        borderRadius: BorderRadius.circular(sizes.sm),
        border: Border.all(color: Colors.lightGreen.shade200),
      ),
      alignment: Alignment.center,
      child: const Text(
        "Dapatkan Bonus Top Up 5% Hari Ini!",
        style: TextStyle(
          color: Colors.lightGreen,
          fontWeight: FontWeight.w600,
          fontSize: Appsized.fontMd,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final sizes = Appsized(context);
    final topUpAmounts = [
      10000.0,
      30000.0,
      50000.0,
      70000.0,
      100000.0,
      200000.0,
    ];
    final double spacing = sizes.sm;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: backBar(
        title: "Eggsplore Pay",
        onBack: () => Navigator.pop(context, balance),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Header dengan nama user
            EggsploreHeader(username: username),

            // Balance Card
            Container(
              color: Colors.white,
              padding: EdgeInsets.fromLTRB(
                sizes.md,
                sizes.sm,
                sizes.md,
                sizes.sm,
              ),
              child: Container(
                padding: EdgeInsets.all(sizes.md),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [AppColors.primary, Color(0xFFFFC107)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(sizes.md),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.primary.withOpacity(0.3),
                      offset: Offset(0, sizes.xs),
                      blurRadius: sizes.sm,
                    ),
                  ],
                  border: Border.all(color: Colors.white70, width: 0.5),
                ),
                child: BalanceDisplay(balance: balance, imageSize: sizes.xxl),
              ),
            ),

            // Banner
            _buildPromotionalBanner(sizes),

            // TopUp Section
            SizedBox(height: sizes.lg),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.md),
              child: Text(
                "Pilih Nominal Top Up",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Appsized.fontLg,
                  color: Colors.black,
                ),
              ),
            ),
            SizedBox(height: sizes.sm),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: sizes.md),
              child: GridView.count(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 3,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing,
                childAspectRatio: 0.85,
                children: topUpAmounts.map((amount) {
                  return TopUpItem(amount: amount, onTap: _topUp);
                }).toList(),
              ),
            ),
            SizedBox(height: sizes.lg),
            Divider(
              height: 1,
              thickness: 1,
              color: Colors.grey.shade200,
              indent: sizes.md,
              endIndent: sizes.md,
            ),
            SizedBox(height: sizes.lg),
          ],
        ),
      ),
    );
  }
}
