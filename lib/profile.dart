import 'package:app/signin.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profil & Paramètres', style: TextStyle(fontSize: 18)),
      ),
      body: Column(
        children: [
          // User Profile Section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile Picture
                CircleAvatar(
                  radius: 60,
                  backgroundImage: NetworkImage(
                    'https://randomuser.me/api/portraits/men/1.jpg', // Placeholder image
                  ),
                ),
                SizedBox(height: 16),

                // User Name
                Text(
                  'El berhichi Aissam',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                // User Email
                Text(
                  'aissamelberhichi@gmail.com',
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ),

          // Preferences Section
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: [
                Text(
                  'Préférences',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 16),

                // Personal Information
                _buildSettingsRow(
                  context,
                  icon: Icons.person,
                  title: 'Informations personnelles',
                  onTap: () {
                    // TODO: Navigate to personal information screen
                  },
                ),

                // Currency
                _buildSettingsRow(
                  context,
                  icon: Icons.currency_exchange,
                  title: 'Devise',
                  trailing: Text('MAD', style: TextStyle(color: Colors.grey)),
                  onTap: () {
                    // TODO: Open currency selection
                  },
                ),
              ],
            ),
          ),

          Spacer(),

          // Logout Button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // TODO: Implement logout functionality
                _showLogoutConfirmation(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 60),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Déconnexion',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper method to build settings row
  Widget _buildSettingsRow(
    BuildContext context, {
    required IconData icon,
    required String title,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Icon(icon, color: Colors.blue),
      ),
      title: Text(title),
      trailing: trailing ?? Icon(Icons.chevron_right),
      onTap: onTap,
    );
  }

  void _showLogoutConfirmation(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Déconnexion'),
          content: Text('Êtes-vous sûr de vouloir vous déconnecter ?'),
          actions: [
            TextButton(
              child: Text('Annuler'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: Text('Déconnecter'),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
