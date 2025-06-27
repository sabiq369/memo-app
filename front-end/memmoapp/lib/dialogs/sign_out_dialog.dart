import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memmoapp/utilities/dependencies.dart' as dependencies;

class SignOutDialog extends StatelessWidget {
  const SignOutDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Text(
        'Sign out?',
        textAlign: TextAlign.center,
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            Get.find<dependencies.AuthController>().signOut();
          },
          child: Text('Yes'),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Cancel'),
        )
      ],
    );
  }
}
