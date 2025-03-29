import 'package:app/models/Depense.dart';
import 'package:app/models/Travel.dart';
import 'package:app/newTripScreen.dart';
import 'package:app/profile.dart';
import 'package:app/services/httpService.dart';
import 'package:flutter/material.dart';

class DashboardScreen extends StatefulWidget {
  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  HttpService httpService = HttpService();
  List<Depense> depenses = [];
  List<Travel> travels = [];
  @override
  void initState() {
    super.initState();
    httpService.getTravels().then((value) => setState(() => travels = value));
    httpService.getDepenses().then((value) => setState(() => depenses = value));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Voyages en cours',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => NewTripScreen()),
                    );
                  },
                  child: Text('Ajouter'),
                ),
              ],
            ),
            Container(
              height: 220,
              child: ListView.builder(
                itemCount: travels.length,
                itemBuilder: (context, index) {
                  return TravelCard(
                    travels[index].city,
                    travels[index].date,
                    travels[index].price,
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Dernières Dépenses',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton(onPressed: () {}, child: Text('Voir tout')),
              ],
            ),
            Container(
              height: 220,
              child: ListView.builder(
                itemCount: depenses.length,
                itemBuilder: (context, index) {
                  return ExpenseCard(
                    Icons.person,
                    depenses[index].name,
                    'Payé par ${depenses[index].paidBy}',
                    '${depenses[index].price} dh',
                    Colors.blueAccent,
                  );
                },
              ),
            ),
            // ExpenseCard(
            //   Icons.person,
            //   'Restaurant',
            //   'Payé par Aissam',
            //   '200 dh',
            //   Colors.blueAccent,
            // ),
            // ExpenseCard(
            //   Icons.taxi_alert,
            //   'Taxi',
            //   'Payé par Badr',
            //   '45 dh',
            //   Colors.green,
            // ),
            // ExpenseCard(
            //   Icons.person,
            //   'Hotel',
            //   'Payé par Badr',
            //   '1045 dh',
            //   Colors.purple,
            // ),
          ],
        ),
      ),
    );
  }
}

class TravelCard extends StatelessWidget {
  final String title;
  final String date;
  final String price;

  TravelCard(this.title, this.date, this.price);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(date),
        trailing: Chip(label: Text(price)),
      ),
    );
  }
}

class ExpenseCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final String amount;
  final Color iconColor;

  ExpenseCard(
    this.icon,
    this.title,
    this.subtitle,
    this.amount,
    this.iconColor,
  );

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: ListTile(
        leading: CircleAvatar(backgroundColor: iconColor.withOpacity(0.2)),
        title: Text(title, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Text(subtitle),
        trailing: Text(amount, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}
