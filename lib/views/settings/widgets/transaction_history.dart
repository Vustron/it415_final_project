// utils
import 'package:flutter/material.dart';

// widgets
import 'package:babysitterapp/views/home/widgets/transaction_card.dart';

class TransactionHistory extends StatelessWidget {
  const TransactionHistory({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Transaction History'),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[

              PopupMenuButton<String>(
                tooltip: '',
                onSelected: (String result) {
                  if (result == 'Payment') {
                    // Do something for Payment
                  } else if (result == 'Service Profile') {
                    // Do something for Service Profile
                    
                  }
                },
                itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                  const PopupMenuItem<String>(
                    value: 'Payment',
                    child: Text('Payment'),
                  ),

                  const PopupMenuItem<String>(
                    value: 'Service Profile',
                    child: Text('Service Profile'),
                  ),

                ],
                

                child: const Row(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        'Filter Transaction',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                        ),
                      ),
                      SizedBox(width: 2),
                      Icon(Icons.filter_alt_rounded, size: 30.0),

                    ],
                  ),
              ),


              const SizedBox(width: 14),

              
            ],
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: const <Widget>[
                TransactionCard(
                  date: 'Sep 22, 2024',
                  sitterName: 'Sarah Johnson',
                  service: 'Babysitting',
                  amount: r'$50.00',
                ),
                TransactionCard(
                  date: 'Sep 18, 2024',
                  sitterName: 'Emily Brown',
                  service: 'Overnight Babysitting',
                  amount: r'$120.00',
                ),
                TransactionCard(
                  date: 'Sep 14, 2024',
                  sitterName: 'Alex Wilson',
                  service: 'Evening Babysitting',
                  amount: r'$75.00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
