import 'package:app/newExpenseScreen.dart';
import 'package:flutter/material.dart';

class TripExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            padding: EdgeInsets.all(16),
            color: Colors.blue[50],
            child: Column(
              children: [
                Text(
                  'Week-end Taghazout',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 8),
                Text('4-6 Mars 2025', style: TextStyle(color: Colors.grey)),
                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      '850 DH',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(width: 16),
                    Stack(
                      children: [
                        CircleAvatar(
                          radius: 15,
                          backgroundColor: Colors.blue[100],
                        ),
                        Positioned(
                          left: 20,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.green[100],
                          ),
                        ),
                        Positioned(
                          left: 40,
                          child: CircleAvatar(
                            radius: 15,
                            backgroundColor: Colors.red[100],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dépenses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {},
                  child: Text(
                    'Voir tout',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),

          ExpenseItemTile(
            icon: Icons.restaurant,
            title: 'Restaurant',
            amount: '200 dh',
            paidBy: 'Payé par Aissam',
          ),
          ExpenseItemTile(
            icon: Icons.local_taxi,
            title: 'Taxi',
            amount: '45 dh',
            paidBy: 'Payé par Badr',
          ),

          Spacer(),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => NewExpenseScreen()),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Ajouter une dépense',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ExpenseItemTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String amount;
  final String paidBy;

  const ExpenseItemTile({
    Key? key,
    required this.icon,
    required this.title,
    required this.amount,
    required this.paidBy,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(paidBy, style: TextStyle(color: Colors.grey)),
      trailing: Text(
        amount,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.blue),
      ),
    );
  }
}
