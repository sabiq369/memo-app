import 'package:flutter/material.dart';
import 'package:memmoapp/dialogs/create_account_dialog.dart';
import 'package:memmoapp/dialogs/sign_in_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.topLeft,
                radius: 1,
                colors: [Colors.white, Color(0xff5dedb7), Colors.white],
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Memo App',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 10),
                Image.asset(
                  'images/favicon.png',
                  height: 70,
                ),
                const SizedBox(height: 50),
                ElevatedButton(
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return SignInDialog();
                      },
                    );
                  },
                  child: Text('Sign In'),
                ),
                const SizedBox(height: 25),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return CreateAccountDialog();
                        },
                      );
                    },
                    child: Text('Create Account'))
              ],
            ),
          )
        ],
      ),
    );
  }
}
