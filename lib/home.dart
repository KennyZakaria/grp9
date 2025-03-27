import 'package:app/dashboard.dart';
import 'package:app/expenseDistribution.dart';
import 'package:app/profile.dart';
import 'package:app/tripExpenseScreen.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String appBarTitle = 'Tableau de bord';
  int _currentIndex = 0;

  final List<Widget> _screens = [
    DashboardScreen(),
    TripExpensesScreen(),
    ExpenseDistributionScreen(),
    ProfileScreen(),
  ];
  changeAppBbarTitle(int index) {
    setState(() {
      switch (index) {
        case 0:
          appBarTitle = 'Tableau de bord';
          break;
        case 1:
          appBarTitle = 'Détails de Voyage';
          break;
        case 2:
          appBarTitle = 'Répartition des Dépenses';
          break;
        case 3:
          appBarTitle = 'Profil & Paramètres';
          break;
        default:
      }
    });
  }

  void _onTabTapped(int index) {
    setState(() {
      changeAppBbarTitle(index);
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications_outlined),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.person),
            onPressed: () => _onTabTapped(3),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: _screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Accueil'),
          BottomNavigationBarItem(icon: Icon(Icons.receipt), label: 'Dépenses'),
          BottomNavigationBarItem(icon: Icon(Icons.payment), label: 'Paiement'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
      ),
    );
  }
}
