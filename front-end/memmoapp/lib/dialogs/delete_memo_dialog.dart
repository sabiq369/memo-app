import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:memmoapp/utilities/dependencies.dart' as dependencies;

class DeleteMemoDialog extends StatefulWidget {
  final int index;
  final Function scrollToBottom;
  const DeleteMemoDialog({
    Key? key,
    required this.index,
    required this.scrollToBottom,
  }) : super(key: key);

  @override
  State<DeleteMemoDialog> createState() => _DeleteMemoDialogState();
}

class _DeleteMemoDialogState extends State<DeleteMemoDialog> {
  RxString status = 'delete-memo'.obs;
  var memoController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => status.value == 'delete-memo'
            ? deleteMemoWidget()
            : status.value == 'deleting-memo'
                ? deletingMemoWidget()
                : const SizedBox(),
      ),
    );
  }

  Widget deleteMemoWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Delete this memo?'),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  status.value = 'deleting-memo';
                },
                child: Text('Delete'),
              ),
              SizedBox(width: 20),
              ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('Cancel'))
            ],
          )
        ],
      ),
    );
  }

  Widget deletingMemoWidget() {
    return FutureBuilder(
      future: Get.find<dependencies.AuthController>().deleteMemo(widget.index),
      builder: (context, snapshot) {
        if (snapshot.connectionState != ConnectionState.done) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Deleting memo'),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else if (snapshot.data == 'success') {
          Future.delayed(
            Duration(seconds: 1),
            () {
              if (Get.find<dependencies.AuthController>().memos.isNotEmpty) {
                widget.scrollToBottom;
              }
              Navigator.pop(context);
            },
          );
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Memo deleted successfully'),
                SizedBox(height: 20),
                CircularProgressIndicator()
              ],
            ),
          );
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(snapshot.data!),
                SizedBox(height: 20),
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
