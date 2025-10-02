import 'package:flutter/material.dart';

class ReviewInput extends StatefulWidget {
  final Function(int rating, String comment)? onSubmit;

  const ReviewInput({super.key, this.onSubmit});

  @override
  State<ReviewInput> createState() => _ReviewInputState();
}

class _ReviewInputState extends State<ReviewInput> {
  int _rating = 0;
  final TextEditingController _commentController = TextEditingController();

  void _handleSubmit() {
    if (widget.onSubmit != null) {
      widget.onSubmit!(_rating, _commentController.text);
    }
    _commentController.clear();
    setState(() {
      _rating = 0;
    });
  }

  Widget _buildStar(int index) {
    return IconButton(
      icon: Icon(
        index <= _rating ? Icons.star : Icons.star_border,
        color: Colors.amber,
        size: 30,
      ),
      onPressed: () {
        setState(() {
          _rating = index;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Write a Review",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),

          /// Row of Stars (manual)
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: List.generate(5, (index) => _buildStar(index + 1)),
          ),

          const SizedBox(height: 8),

          TextField(
            controller: _commentController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              hintText: "Tulis komentar...",
            ),
            maxLines: 3,
          ),

          const SizedBox(height: 8),

          ElevatedButton(
            onPressed: _handleSubmit,
            child: const Text("Submit"),
          ),
        ],
      ),
    );
  }
}
