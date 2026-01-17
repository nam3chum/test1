import 'package:flutter/material.dart';

class Tags extends StatelessWidget {
  const Tags({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        _Tag(label: 'BTS'),
        _Tag(label: 'Kim Namjoon', highlight: true),
        _Tag(label: 'K-Pop', highlight: true),
        _Tag(label: 'Min Yoongi'),
        _Tag(label: 'Park Jimin'),
      ],
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  final bool highlight;

  const _Tag({required this.label, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final color = highlight ? Colors.deepPurple : Colors.black;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(color: Colors.grey.shade100, borderRadius: BorderRadius.circular(18)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(highlight ? Icons.label : Icons.label_outline, size: 14, color: color),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 8),
            width: 1,
            height: 14,
            color: Colors.grey.withValues(alpha: 0.4),
          ),
          const SizedBox(width: 6),
          Text(label, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: Colors.black)),
        ],
      ),
    );
  }
}

