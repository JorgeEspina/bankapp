import 'package:animate_do/animate_do.dart';
import 'package:bankapp/features/accounts/data/models/account.dart';
import 'package:flutter/material.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:bankapp/features/accounts/presentation/widgets/account_card.dart';

class AccountsSlideshow extends StatelessWidget {
  final List<Account> accounts;

  const AccountsSlideshow({
    super.key,
    required this.accounts,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SizedBox(
      height: 220,
      width: double.infinity,
      child: Swiper(
        viewportFraction: 0.85,
        scale: 0.9,
        autoplay: false, // opcional: true si quieres auto-scroll
        pagination: SwiperPagination(
          margin: const EdgeInsets.only(top: 0),
          builder: DotSwiperPaginationBuilder(
            activeColor: colors.primary,
            color: Colors.white38,
          ),
        ),
        itemCount: accounts.length,
        itemBuilder: (context, index) => _Slide(account: accounts[index]),
      ),
    );
  }
}

class _Slide extends StatelessWidget {
  final Account account;

  const _Slide({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
      ],
    );

    return Padding(
      padding: const EdgeInsets.only(bottom: 20),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: FadeIn(
            child: AccountCard(account: account),
          ),
        ),
      ),
    );
  }
}