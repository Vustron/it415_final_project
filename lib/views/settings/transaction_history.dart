import 'package:flutter/material.dart';

class TransactionHistoryPage extends StatelessWidget {
  TransactionHistoryPage({super.key});

  final List<Map<String, String>> transactions = <Map<String, String>>[
    <String, String>{'date': 'As of Oct 18, 2024', 'amount': '+10,000'},
    <String, String>{'date': 'As of Nov 18, 2024', 'amount': '+10,000'},
    <String, String>{'date': 'As of Dec 18, 2024', 'amount': '+10,000'},
    <String, String>{'date': 'As of Jan 18, 2025', 'amount': '+10,000'},
    <String, String>{'date': 'As of Feb 18, 2025', 'amount': '+10,000'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Transaction History',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        elevation: 0,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          }, 
          icon: const Icon(Icons.arrow_back, color: Colors.black),
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: <Widget>[
            const SizedBox(height: 20), 
            
            const Text(
              'OVERVIEW',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
                fontWeight: FontWeight.bold

              ),
            ),

            Expanded(
              child: ListView.builder(
                itemCount: transactions.length,
                itemBuilder: (BuildContext context, int index){
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Card(
                      elevation: 2,
                      
                      child: ListTile(
              
                        title: Text(
                          transactions[index]['date'] ?? '',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold
                          ),
                        ),
              
                        subtitle: const Text('10:58 AM'),
              
                        trailing: Text(
                          transactions[index]['amount'] ?? '',
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ],
        ),
      ) ,
    );
  }
}
