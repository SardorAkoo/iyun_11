import 'package:flutter/material.dart';
import 'package:iyun_11/views/login_screen.dart';

class SettingsScreen extends StatelessWidget {
  final VoidCallback toggleTheme;

  SettingsScreen({required this.toggleTheme});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (ctx) {
                      return const LoginScreen();
                    },
                  ),
                  (Route<dynamic> route) => false,
                );
              },
              icon: Icon(
                Icons.exit_to_app,
              )),
          SizedBox(width: 20),
        ],
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: toggleTheme,
          child: Text('Toggle Theme'),
        ),
      ),
    );
  }
}
