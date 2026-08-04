import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:bankapp/core/l10n/app_localizations.dart';
import 'package:intl/intl.dart';

import '../../data/models/transaction_model.dart';
import '../state/transactions_providers.dart';
import '../state/transactions_state.dart';

class HistorialScreen extends ConsumerStatefulWidget {
  static const name = 'history-screen';
  const HistorialScreen({super.key});

  @override
  ConsumerState<HistorialScreen> createState() => _HistorialScreenState();
}

class _HistorialScreenState extends ConsumerState<HistorialScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      ref.read(transactionsControllerProvider.notifier).loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(transactionsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: Text(l10n.history),
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(transactionsControllerProvider.notifier).refresh(),
        child: _buildBody(context, state, l10n),
      ),
    );
  }

  Widget _buildBody(
    BuildContext context,
    TransactionsState state,
    AppLocalizations l10n,
  ) {
    if (state.isLoading && state.transactions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (state.error != null && state.transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              state.error!,
              style: const TextStyle(color: Colors.redAccent),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () =>
                  ref.read(transactionsControllerProvider.notifier).refresh(),
              child: const Text('Reintentar'),
            ),
          ],
        ),
      );
    }

    if (state.transactions.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.receipt_long, size: 64, color: Color(0xFFA2A2A7)),
            const SizedBox(height: 16),
            Text(
              'No hay transacciones',
              style: Theme.of(context)
                  .textTheme
                  .titleMedium
                  ?.copyWith(color: const Color(0xFFA2A2A7)),
            ),
          ],
        ),
      );
    }

    // Agrupar transacciones por fecha
    final grouped = _groupByDate(state.transactions);

    return ListView.builder(
      controller: _scrollController,
      physics: const AlwaysScrollableScrollPhysics(),
      padding: const EdgeInsets.all(16),
      itemCount: grouped.length + (state.hasMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index == grouped.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }

        final entry = grouped[index];
        return _buildDateSection(context, entry.date, entry.transactions);
      },
    );
  }

  Widget _buildDateSection(
    BuildContext context,
    String dateLabel,
    List<TransactionModel> transactions,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 12),
          child: Text(
            dateLabel,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.white),
          ),
        ),
        ...transactions.map((tx) => _buildTransactionTile(tx)),
      ],
    );
  }

  Widget _buildTransactionTile(TransactionModel transaction) {
    final isIncome = transaction.isIncome;
    final amount = transaction.amount;
    final timeFormat = DateFormat('hh:mm a');

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: Colors.blue.shade100,
          child: Icon(
            isIncome ? Icons.arrow_left : Icons.arrow_right,
            color: Colors.blue,
          ),
        ),
        title: Text(transaction.description),
        subtitle: Text(timeFormat.format(transaction.date)),
        trailing: Text(
          "${isIncome ? "+" : "-"}Q${amount.abs().toStringAsFixed(2)}",
          style: TextStyle(
            color: isIncome ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  List<_DateGroup> _groupByDate(List<TransactionModel> transactions) {
    final Map<String, List<TransactionModel>> map = {};
    final dateFormat = DateFormat('dd/MM/yyyy');

    for (final tx in transactions) {
      final key = dateFormat.format(tx.date);
      map.putIfAbsent(key, () => []);
      map[key]!.add(tx);
    }

    return map.entries
        .map((e) => _DateGroup(date: e.key, transactions: e.value))
        .toList();
  }
}

class _DateGroup {
  final String date;
  final List<TransactionModel> transactions;

  _DateGroup({required this.date, required this.transactions});
}
