import 'package:flutter/material.dart';

class ProcessedItemWidget extends StatelessWidget {
  final String title;
  final int quantity;
  final String status;
  final String? price;
  final String imageUrl;

  const ProcessedItemWidget({
    super.key,
    required this.title,
    required this.quantity,
    required this.status,
    required this.imageUrl,
    this.price,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6),
      child: Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: [
            Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  SizedBox(height: 4),
                  Text('Kuantitas : $quantity'),
                  if (price != null) SizedBox(height: 4),
                  if (price != null)
                    Text(price!, style: TextStyle(color: Colors.green)),
                  SizedBox(height: 6),
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Text(
                      status,
                      style: TextStyle(color: Colors.white),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}