import 'package:app/models/Depense.dart';
import 'package:app/models/User.dart';
import 'package:app/services/authService.dart';
import 'package:app/services/authService.dart';
import 'package:app/services/httpService.dart';
import 'package:flutter/material.dart';

class ExpenseDistributionScreen extends StatefulWidget {
  const ExpenseDistributionScreen({Key? key}) : super(key: key);
  @override
  State<ExpenseDistributionScreen> createState() =>
      _ExpenseDistributionScreenState();
}

class _ExpenseDistributionScreenState extends State<ExpenseDistributionScreen> {
  HttpService httpService = HttpService();
  AuthService authService = AuthService();
  User? userProfile;
  List<Depense> paidByOthers = [];
  double totalPaidByUser = 0.0;
  double totalPaidByOthers = 0.0;
  @override
  void initState() {
    super.initState();
    userProfile = AuthService.getCurrentUser() as User?;
    httpService
        .getTotalPaidByUser(userProfile!.fName)
        .then((value) => setState(() => totalPaidByUser = value));
    httpService
        .getTotalPaidByOthers(userProfile!.fName)
        .then((value) => setState(() => totalPaidByOthers = value));
    httpService
        .getDepensesPaidByOthers(userProfile!.fName)
        .then((value) => setState(() => paidByOthers = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.2),
                  spreadRadius: 2,
                  blurRadius: 5,
                ),
              ],
            ),
            child: Column(
              children: [
                Text(
                  'Balance Totale',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // To Receive Section
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'À recevoir',
                              style: TextStyle(color: Colors.green),
                            ),
                            Text(
                              '${totalPaidByUser.toStringAsFixed(2)} dh',
                              style: TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: 16),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.red[50],
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'À payer',
                              style: TextStyle(color: Colors.red),
                            ),
                            Text(
                              '${totalPaidByOthers.toStringAsFixed(2)} dh',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Transaction Details Section
          Expanded(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16),
              children: [
                Text(
                  'Détails des Transactions',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),
                Container(
                  child: Column(
                    children:
                        paidByOthers
                            .map(
                              (depense) => _buildTransactionItem(
                                name: depense.paidBy,
                                amount:
                                    '${(double.parse(depense.price) / 4).toStringAsFixed(2)} dh',
                                owedTo: userProfile!.fName,
                              ),
                            )
                            .toList(),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem({
    required String name,
    required String amount,
    required String owedTo,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(
                'https://randomuser.me/api/portraits/men/1.jpg', // Placeholder image
              ),
            ),
            title: Text('$name doit à $owedTo'),
            trailing: Text(
              amount,
              style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Column(
              children: [
                Container(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text('Marquer comme remboursé'),
                  ),
                ),
                SizedBox(height: 8),
                Container(
                  width: 400,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.send, size: 16),
                    label: Text('Envoyer un rappel'),
                    style: OutlinedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
