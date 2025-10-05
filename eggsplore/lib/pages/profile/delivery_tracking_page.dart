import 'package:flutter/material.dart';
import 'package:eggsplore/bar/backBar.dart';
import 'package:eggsplore/constants/images.dart';

class DeliveryTrackingPage extends StatelessWidget {
  const DeliveryTrackingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFAE11),
      appBar: backBar(title: "Delivery Tracking"),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Card(
          color: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const Text(
                  "Delivery Status",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(AppImages.map, height: 180, fit: BoxFit.cover),
                ),
                const SizedBox(height: 16),
                const ListTile(
                  leading: Icon(Icons.local_shipping, color: Colors.orange),
                  title: Text("Package has left the warehouse"),
                  subtitle: Text("10:45 AM"),
                ),
                const ListTile(
                  leading: Icon(Icons.location_on, color: Colors.orange),
                  title: Text("Package is on the way"),
                  subtitle: Text("11:30 AM"),
                ),
                const ListTile(
                  leading: Icon(Icons.home, color: Colors.orange),
                  title: Text("Out for delivery"),
                  subtitle: Text("12:15 PM"),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    child: Text("Back", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
