import 'package:flutter/material.dart';

class Transhistory extends StatelessWidget {
  const Transhistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: const [
          TransactionCard(
            date: 'Sep 22, 2024',
            sitterName: 'Sarah Johnson',
            service: 'Babysitting',
            amount: '\$50.00',
          ),
          TransactionCard(
            date: 'Sep 18, 2024',
            sitterName: 'Emily Brown',
            service: 'Overnight Babysitting',
            amount: '\$120.00',
          ),
          TransactionCard(
            date: 'Sep 14, 2024',
            sitterName: 'Alex Wilson',
            service: 'Evening Babysitting',
            amount: '\$75.00',
          ),
        ],
      ),
    );
  }
}

class TransactionCard extends StatelessWidget {
  final String date;
  final String sitterName;
  final String service;
  final String amount;

  const TransactionCard({
    required this.date,
    required this.sitterName,
    required this.service,
    required this.amount,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Date: $date',
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Sitter: $sitterName',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              'Service: $service',
              style: const TextStyle(fontSize: 14, color: Colors.grey),
            ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.bottomRight,
              child: Text(
                amount,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.green,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
