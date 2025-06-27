import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memmoapp/utilities/dependencies.dart' as dependencies;

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({Key? key}) : super(key: key);

  @override
  State<CreateAccountDialog> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  RxString status = 'enter-details'.obs;
  var firstNameController = TextEditingController();
  var lastNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => status.value == 'enter-details'
            ? detailsWidget()
            : status.value == 'creating-account'
                ? creatingAccountWidget()
                : const SizedBox(),
      ),
    );
  }

  Widget detailsWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.topLeft,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: Icon(Icons.arrow_back)),
        ),
        const SizedBox(height: 50),
        Text('Create Memo Account'),
        const SizedBox(height: 30),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'First Name'),
            controller: firstNameController,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Last Name'),
            controller: lastNameController,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Email'),
            controller: emailController,
          ),
        ),
        const SizedBox(height: 20),
        SizedBox(
          width: 300,
          child: TextFormField(
            decoration: const InputDecoration(hintText: 'Password'),
            controller: passwordController,
          ),
        ),
        const SizedBox(height: 40),
        Row(
          children: [
            ElevatedButton(
                onPressed: () {
                  if (firstNameController.text.isNotEmpty &&
                      lastNameController.text.isNotEmpty &&
                      emailController.text.isNotEmpty &&
                      passwordController.text.isNotEmpty) {
                    status.value = 'creating-account';
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          content: Text(
                            'Fill in all the details',
                            textAlign: TextAlign.center,
                          ),
                          actions: [
                            ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: Text('Close'))
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text('Create')),
            SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Close'))
          ],
        )
      ],
    );
  }

  Widget creatingAccountWidget() {
    return FutureBuilder(
      future: Get.find<dependencies.AuthController>().createAccount(
          firstNameController.text,
          lastNameController.text,
          emailController.text,
          passwordController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Creating Account'),
                SizedBox(height: 30),
                CircularProgressIndicator()
              ],
            ),
          );
        } else {
          if (snapshot.data == 'success') {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Account created successfully. You can now sign in.'),
                  const SizedBox(height: 20),
                  ElevatedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: Text('Close'))
                ],
              ),
            );
          } else {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(snapshot.data!),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          status.value = 'enter-details';
                        },
                        child: Text('Try Again'),
                      ),
                      SizedBox(height: 20),
                      ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Close'))
                    ],
                  )
                ],
              ),
            );
          }
        }
      },
    );
  }
}
