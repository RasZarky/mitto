import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';

import '../../core/models/transaction.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_style.dart';
import '../../core/widgets/app_app_bar.dart';
import '../../core/widgets/app_transaction_tile.dart';
import '../../gen/assets.gen.dart';

class TransactionsPage extends StatelessWidget {
  const TransactionsPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy data - In a real app, this would come from a Bloc, Provider, or API
    final List<Transaction> transactions = [
      Transaction(
        title: 'Money sent to Eddie',
        date: DateTime.now(),
        amount: '-\$ 120.00',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=150',
      ),
      Transaction(
        title: 'Money sent to Akua',
        date: DateTime.now(),
        amount: '-\$ 120.00',
        imageUrl: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQLDflof01UiGhww5AjOb6_6yV9Nd1VtR2IYw&s',
      ),
      Transaction(
        title: 'Money sent to Kofi',
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: '-\$ 120.00',
        imageUrl: 'https://img.freepik.com/free-photo/portrait-person-wearing-graphic-eye-makeup_23-2151120756.jpg?semt=ais_user_personalization&w=740&q=80',
      ),
      Transaction(
        title: 'Shopping at Zara',
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: '-\$ 250.00',
        fallbackIcon: Icons.shopping_bag_outlined,
      ),
      Transaction(
        title: 'Money sent to Kofi',
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: '-\$ 120.00',
        imageUrl: 'https://img.freepik.com/free-photo/portrait-person-wearing-graphic-eye-makeup_23-2151120756.jpg?semt=ais_user_personalization&w=740&q=80',
      ),
      Transaction(
        title: 'Transfer In',
        date: DateTime.now().subtract(const Duration(days: 1)),
        amount: '\$ 3000.00',
        fallbackIcon: Icons.arrow_downward_outlined,
      ),
      Transaction(
        title: 'Netflix Subscription',
        date: DateTime.now().subtract(const Duration(days: 5)),
        amount: '-\$ 15.00',
        fallbackIcon: Icons.subscriptions_outlined,
      ),
    ];

    final groupedTransactions = _groupTransactionsByDate(transactions);
    final sortedDates = groupedTransactions.keys.toList()
      ..sort((a, b) => b.compareTo(a)); // Sort dates descending

    return Scaffold(
      appBar: AppAppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 16.0),
          child: Text(
            'Transactions',
            style: AppTextStyle.lgMedium.copyWith(color: AppColors.gray900),
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(Assets.svgs.filter),
          ),
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: SvgPicture.asset(Assets.svgs.search),
          )
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(24),
        itemCount: sortedDates.length,
        itemBuilder: (context, index) {
          final date = sortedDates[index];
          final dateTransactions = groupedTransactions[date]!;

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _formatDateHeader(date),
                style: AppTextStyle.h5Medium.copyWith(color: AppColors.basicWhite),
              ),
              const SizedBox(height: 16),
              ...dateTransactions.map((tx) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: AppTransactionTile(
                      title: tx.title,
                      subtitle: DateFormat('h:mm a').format(tx.date),
                      amount: tx.amount,
                      imageUrl: tx.imageUrl,
                      fallbackIcon: tx.fallbackIcon,
                    ),
                  )),
            ],
          );
        },
      ),
    );
  }

  Map<DateTime, List<Transaction>> _groupTransactionsByDate(List<Transaction> transactions) {
    final Map<DateTime, List<Transaction>> groups = {};
    for (var tx in transactions) {
      final date = DateTime(tx.date.year, tx.date.month, tx.date.day);
      if (groups[date] == null) {
        groups[date] = [];
      }
      groups[date]!.add(tx);
    }
    return groups;
  }

  String _formatDateHeader(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final yesterday = today.subtract(const Duration(days: 1));

    if (date == today) {
      return 'Today';
    } else if (date == yesterday) {
      return 'Yesterday';
    } else {
      return DateFormat('MMM dd, yyyy').format(date);
    }
  }
}
