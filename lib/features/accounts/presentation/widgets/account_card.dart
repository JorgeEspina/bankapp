import 'package:flutter/material.dart';
import 'package:bankapp/features/home/config/menu/home_menu_items.dart';
import 'package:bankapp/features/accounts/data/models/account.dart';
import 'package:go_router/go_router.dart';

class AccountCard extends StatelessWidget {
  final Account account;

  const AccountCard({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 45, 45, 83),
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Color.fromARGB(4, 209, 200, 200),
            blurRadius: 10,
            offset: Offset(0, 10),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            account.name,
            style: const TextStyle(color: Colors.white70, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Text(
            '**** ${account.number}',
            style: const TextStyle(color: Colors.white38, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Text(
            '\$${account.balance.toStringAsFixed(2)}',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: accountActions.map((action) {
              return IconButton(
                icon: Icon(action.icon, color: const Color(0xFF0066FF)),
                onPressed: () {
                  if (action.link != null) {
                    context.push(action.link!);
                  } else {
                    context.go('/home');
                  }
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
