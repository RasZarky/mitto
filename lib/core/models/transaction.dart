import 'package:flutter/material.dart';

class Transaction {
  final String title;
  final DateTime date;
  final String amount;
  final String? imageUrl;
  final IconData? fallbackIcon;

  Transaction({
    required this.title,
    required this.date,
    required this.amount,
    this.imageUrl,
    this.fallbackIcon,
  });
}
