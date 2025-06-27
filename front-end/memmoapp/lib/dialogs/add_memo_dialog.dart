import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memmoapp/utilities/dependencies.dart' as dependencies;

class AddMemoDialog extends StatefulWidget {
  final Function scrollToBottom;
  const AddMemoDialog({super.key, required this.scrollToBottom});

  @override
  State<AddMemoDialog> createState() => _AddMemoDialogState();
}

class _AddMemoDialogState extends State<AddMemoDialog> {
  RxString status = 'type-memo'.obs;
  var memoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => status.value == 'type-memo'
            ? typeMemoWidget()
            : status.value == 'adding-memo'
                ? addingMemoWidget()
                : const SizedBox(),
      ),
    );
  }

  Widget typeMemoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 400,
            child: TextFormField(
              controller: memoController,
              decoration: InputDecoration(
                hintText: 'Type something...',
              ),
              maxLines: null,
            ),
          ),
          SizedBox(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  status.value = 'adding-memo';
                },
                child: Text('Save'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text('Cancel'),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget addingMemoWidget() {
    return FutureBuilder(
      future:
          Get.find<dependencies.AuthController>().addMemo(memoController.text),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Adding memo'),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else if (snapshot.data == 'success') {
          Future.delayed(
            Duration(seconds: 1),
            () {
              widget.scrollToBottom();
              Navigator.pop(context);
            },
          );
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Memo added successfully'),
                SizedBox(height: 20),
                CircularProgressIndicator(),
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data!),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Close'))
              ],
            ),
          );
        }
      },
    );
  }
}
