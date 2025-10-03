import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:eggsplore/widget/proiflebar/process.dart';
import 'dart:convert';

class ProcessedPage extends StatefulWidget {
  const ProcessedPage({super.key});

  @override
  State<ProcessedPage> createState() => _ProcessedPageState();
}

class _ProcessedPageState extends State<ProcessedPage> {
  List<Map<String, dynamic>> items = [
    {
      'title': 'contoh barang',
      'quantity': 1,
      'status': 'DI PROSES',
      'price': 'RP. 100.000',
      'image': '',
    },
  ];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchItems();
  }

  Future<void> fetchItems() async {
    try {
      final response = await http.get(
        Uri.parse(''),//taro url backend
      );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          items = [
            items[0],
            ...data.map((item) => item as Map<String, dynamic>),
          ];
          isLoading = false;
        });
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      print(e);
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error fetching data')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DIPROSES'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : items.isEmpty
          ? Center(child: Text('Tidak ada item'))
          : ListView.builder(
              padding: EdgeInsets.all(8),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ProcessedItemWidget(
                  title: item['title'],
                  quantity: item['quantity'],
                  status: item['status'],
                  price: item['price'],
                  imageUrl: item['image'],
                );
              },
            ),
    );
  }
}