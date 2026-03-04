import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CustomAppbar extends ConsumerWidget {
  final GlobalKey<ScaffoldState> scaffoldKey;

  const CustomAppbar({super.key, required this.scaffoldKey});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              IconButton(
                icon: Icon(Icons.menu, color: Color(0xFFA2A2A7)),
                onPressed: () {
                  scaffoldKey.currentState?.openDrawer();
                },
              ),

              const SizedBox(width: 10),

              Icon(Icons.account_balance_outlined, color: Color(0xFFA2A2A7)),
              const SizedBox(width: 10),
              Text(
                'BankApp',
                style: titleStyle?.copyWith(color: Color(0xFFA2A2A7)),
              ),

              const Spacer(),

              IconButton(
                onPressed: () {
                  context.push('/');
                },
                icon: Icon(Icons.logout_outlined, color: Color(0xFFA2A2A7)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
