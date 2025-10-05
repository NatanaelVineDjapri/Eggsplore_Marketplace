import 'package:flutter/material.dart';

class ExpandableDescription extends StatefulWidget {
  final String text;
  final int trimLength;
  const ExpandableDescription({
    super.key,
    required this.text,
    this.trimLength = 150,
  });

  @override
  State<ExpandableDescription> createState() => _ExpandableDescriptionState();
}

class _ExpandableDescriptionState extends State<ExpandableDescription> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final bool isLongText = widget.text.length > widget.trimLength;

    final String displayedText = _isExpanded || !isLongText
        ? widget.text
        : '${widget.text.substring(0, widget.trimLength)}...';

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          displayedText,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade700,
            height: 1.5,
          ),
        ),

        if (isLongText) const SizedBox(height: 8),

        if (isLongText)
          InkWell(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _isExpanded ? "Tampilkan lebih sedikit" : "Baca selengkapnya",
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }
}
