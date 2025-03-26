import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(home: MainScreen()));
}

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
    HomeScreen(),
    ExpensesScreen(),
    PaymentScreen(),
    ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return NewTripScreen();
  }
}

class ExpensesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Dépenses Screen'));
  }
}

class PaymentScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Paiement Screen'));
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(child: Text('Profil Screen'));
  }
}

class NewTripScreen extends StatefulWidget {
  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  List<String> participants = ['Aissam', 'Badr', 'Zakaria'];

  void _addParticipant() {
    if (_participantController.text.isNotEmpty) {
      setState(() {
        participants.add(_participantController.text);
        _participantController.clear();
      });
    }
  }

  void _removeParticipant(String name) {
    setState(() {
      participants.remove(name);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Nom du voyage', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          TextField(
            controller: _tripNameController,
            decoration: InputDecoration(
              hintText: 'Par ex : Week-end Taghazout',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20),
          Text('Participants', style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(height: 8),
          Column(
            children:
                participants.map((participant) {
                  return Card(
                    child: ListTile(
                      title: Text(participant),
                      trailing: IconButton(
                        icon: Icon(Icons.close, color: Colors.red),
                        onPressed: () => _removeParticipant(participant),
                      ),
                    ),
                  );
                }).toList(),
          ),
          TextField(
            controller: _participantController,
            decoration: InputDecoration(
              hintText: 'Nom du participant',
              border: OutlineInputBorder(),
            ),
          ),
          TextButton(
            onPressed: _addParticipant,
            child: Text(
              'Ajouter un participant',
              style: TextStyle(color: Colors.blue),
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: () {},
              style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              child: Text(
                'Créer le voyage',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
