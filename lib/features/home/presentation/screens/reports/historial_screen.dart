import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HistorialScreen extends StatelessWidget {
  static const name = 'history-screen';
  const HistorialScreen({super.key});

  // Lista simulada de transacciones del día
  final List<Map<String, dynamic>> transactions = const [
    {
      "name": "Envio de Transferencia por pago de Netflix",
      "amount": -12.99,
      "time": "08:30 AM",
      "icon": Icons.arrow_right
    },
    {
      "name": "Transferencia recibida",
      "amount": 250.00,
      "time": "10:15 AM",
      "icon": Icons.arrow_left
    },
    {
      "name": "Envio de transferencia a Juan Perez.",
      "amount": -45.50,
      "time": "01:20 PM",
      "icon": Icons.arrow_right
    },
    {
      "name": "Envio de pago de Pago Spotify",
      "amount": -100.00,
      "time": "04:45 PM",
      "icon": Icons.arrow_right
    },
  ];

  // Lista simulada de transacciones del día de auer
  final List<Map<String, dynamic>> transactionsYes = const [
    {
      "name": "Pago de Linea de Télefono",
      "amount": -200.99,
      "time": "07:30 AM",
      "icon": Icons.arrow_right
    },
    {
      "name": "Transferencia recibida de Luis",
      "amount": 500.00,
      "time": "08:15 AM",
      "icon": Icons.arrow_left
    },
    {
      "name": "Transferencia recibida de Fernando",
      "amount": 500.00,
      "time": "8:15 PM",
      "icon": Icons.arrow_left
    }
  ];

  @override
  Widget build(BuildContext context) {
    final today = DateTime.now();
    final formattedDate = "${today.day}/${today.month}/${today.year}";
    final formattedDateYes = "${today.day - 1}/${today.month}/${today.year}";
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => context.go('/home'),
        ),
        title: const Text("Historial"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child : Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Transacciones de hoy: $formattedDate',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (context, index) {
                  final transaction = transactions[index];
                  final amount = transaction["amount"] as double;
                  final isPositive = amount > 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(transaction["icon"], color: Colors.blue),
                      ),
                      title: Text(transaction["name"]),
                      subtitle: Text(transaction["time"]),
                      trailing: Text(
                        "${isPositive ? "+" : "-"}Q${isPositive ? amount.toStringAsFixed(2) : (amount * -1).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Text(
              'Transacciones de Ayer: $formattedDateYes',
              style: Theme.of(context)
                  .textTheme
                  .headlineSmall
                  ?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: transactionsYes.length,
                itemBuilder: (context, index) {
                  final transactionsY = transactionsYes[index];
                  final amount = transactionsY["amount"] as double;
                  final isPositive = amount > 0;

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 5),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.blue.shade100,
                        child: Icon(transactionsY["icon"], color: Colors.blue),
                      ),
                      title: Text(transactionsY["name"]),
                      subtitle: Text(transactionsY["time"]),
                      trailing: Text(
                        "${isPositive ? "+" : "-"}Q${isPositive ? amount.toStringAsFixed(2) : (amount * -1).toStringAsFixed(2)}",
                        style: TextStyle(
                          color: isPositive ? Colors.green : Colors.red,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        )
      )
    );
  }
}