import 'package:app/home.dart';
import 'package:app/services/authService.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final AuthService authService = AuthService();

  login(context) async {
    // AuthService.login(emailController.text, passwordController.text).then((
    //   value,
    // ) {
    //   if (value['success']) {
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(builder: (context) => MainScreen()),
    //     );
    //   } else {
    //     ScaffoldMessenger.of(context).showSnackBar(
    //       SnackBar(
    //         content: Text(value['message']),
    //         backgroundColor: Colors.redAccent,
    //       ),
    //     );
    //   }
    // });
    final result = await AuthService.login(
      emailController.text,
      passwordController.text,
    );
    if (result['success']) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(result['message']),
          backgroundColor: Colors.redAccent,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Connectez-vous à votre compte',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Entrez votre email et votre mot de passe pour vous connecter',
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 20),
            TextField(
              controller: emailController,
              decoration: InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 15),
            TextField(
              obscureText: true,
              controller: passwordController,
              decoration: InputDecoration(
                labelText: 'Mot de passe',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.visibility_off),
              ),
            ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Mot de passe oublié ?',
                style: TextStyle(color: Colors.blue),
              ),
            ),
            SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => login(context),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                child: Text('Log In', style: TextStyle(color: Colors.white)),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Expanded(child: Divider()),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text('Ou'),
                ),
                Expanded(child: Divider()),
              ],
            ),
            SizedBox(height: 20),
            SocialLoginButton(
              icon: Icons.ice_skating_outlined,
              text: 'Continue with Google',
            ),
            SizedBox(height: 10),
            SocialLoginButton(
              icon: Icons.ice_skating_outlined,
              text: 'Continue with Facebook',
            ),
          ],
        ),
      ),
    );
  }
}

class SocialLoginButton extends StatelessWidget {
  final IconData icon;
  final String text;

  SocialLoginButton({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: OutlinedButton.icon(
        onPressed: () {},
        label: Text(text, style: TextStyle(color: Colors.black)),
        style: OutlinedButton.styleFrom(side: BorderSide(color: Colors.grey)),
      ),
    );
  }
}
