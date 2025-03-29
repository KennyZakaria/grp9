import 'package:app/dashboard.dart';
import 'package:app/home.dart';
import 'package:app/models/Depense.dart';
import 'package:app/models/Travel.dart';
import 'package:app/services/httpService.dart';
import 'package:flutter/material.dart';

class NewTripScreen extends StatefulWidget {
  @override
  _NewTripScreenState createState() => _NewTripScreenState();
}

class _NewTripScreenState extends State<NewTripScreen> {
  final TextEditingController _tripNameController = TextEditingController();
  final TextEditingController _participantController = TextEditingController();
  List<String> participants = ['Aissam', 'Badr', 'Zakaria', 'Soufian'];

  HttpService httpService = HttpService();

  void createTravel() {
    Travel newTravel = Travel(
      city: _tripNameController.text,
      date:
          DateTime.now()
              .toString(), // Corrected: Remove the quotes around DateTime
      price: "333",
      participants: participants,
    );

    httpService
        .addTravel(newTravel)
        .then((_) {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => MainScreen()),
          );
        })
        .catchError((error) {
          print("Failed to create travel: $error");
        });
  }

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
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Nom du voyage',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
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
                onPressed: createTravel,
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text(
                  'Créer le voyage',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
