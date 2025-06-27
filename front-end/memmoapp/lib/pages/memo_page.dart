import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memmoapp/dialogs/add_memo_dialog.dart';
import 'package:memmoapp/dialogs/delete_memo_dialog.dart';
import 'package:memmoapp/dialogs/sign_out_dialog.dart';
import 'package:memmoapp/utilities/dependencies.dart' as dependencies;

class MemoPage extends StatefulWidget {
  const MemoPage({Key? key}) : super(key: key);

  @override
  State<MemoPage> createState() => _MemoPageState();
}

class _MemoPageState extends State<MemoPage> {
  var memoController = TextEditingController();
  RxString value = 'type-memo'.obs;
  var scrollController = ScrollController();
  void scrollToBottom() {
    scrollController.jumpTo(scrollController.position.maxScrollExtent);
  }

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        if (!Get.find<dependencies.AuthController>().isSignedIn.value) {
          Get.toNamed('/home_page');
        }
        if (!Get.find<dependencies.AuthController>().memos.isNotEmpty) {
          scrollController.jumpTo(scrollController.position.maxScrollExtent);
        }
      },
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        leading: SizedBox.shrink(),
        actions: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              child: Row(
                children: [
                  Text('Sign Out'),
                  SizedBox(width: 10),
                  Icon(Icons.logout)
                ],
              ),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return SignOutDialog();
                  },
                );
              },
            ),
          ),
        ],
        title: Center(
          child:
              Text(Get.find<dependencies.AuthController>().signedInEmail.value),
        ),
      ),
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              gradient: RadialGradient(
                  center: Alignment.topLeft,
                  radius: 1,
                  colors: [Colors.white, Color(0xff5debd7), Colors.white]),
            ),
          ),
          Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Obx(
                () => Get.find<dependencies.AuthController>().memos.isEmpty
                    ? Center(
                        child: Text('No memos yet'),
                      )
                    : ListView.builder(
                        controller: scrollController,
                        padding: EdgeInsets.only(top: 20, bottom: 130),
                        itemCount: Get.find<dependencies.AuthController>()
                            .memos
                            .length,
                        itemBuilder: (context, index) {
                          return MemoCard(
                              timestamp: Get.find<dependencies.AuthController>()
                                  .memos[index]['timeStamp'],
                              content: Get.find<dependencies.AuthController>()
                                  .memos[index]['content'],
                              index: index,
                              scrollToBottom: scrollToBottom);
                        },
                      ),
              ),
            ),
          ),
        ],
      ),
      bottomSheet: Padding(
        padding: EdgeInsets.only(top: 5, right: 5, left: 5, bottom: 20),
        child: IconButton(
          style: ButtonStyle(
              backgroundColor: MaterialStatePropertyAll(Colors.white),
              foregroundColor: MaterialStatePropertyAll(Colors.black)),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AddMemoDialog(scrollToBottom: scrollToBottom);
              },
            );
          },
          icon: Icon(Icons.add, size: 50),
        ),
      ),
    );
  }
}

class MemoCard extends StatelessWidget {
  final String timestamp;
  final String content;
  final int index;
  final Function scrollToBottom;
  const MemoCard(
      {Key? key,
      required this.timestamp,
      required this.content,
      required this.index,
      required this.scrollToBottom})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(20),
      color: Colors.white,
      elevation: 5,
      surfaceTintColor: Colors.transparent,
      child: Padding(
        padding: EdgeInsets.all(30),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DateFormat.yMEd().add_jm().format(
                        DateTime.parse(timestamp).add(
                          const Duration(hours: 3),
                        ),
                      ),
                ),
                SizedBox(width: 30),
                IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return DeleteMemoDialog(
                              index: index, scrollToBottom: scrollToBottom);
                        },
                      );
                    },
                    icon: Icon(Icons.delete))
              ],
            ),
            const Divider(),
            Text(content)
          ],
        ),
      ),
    );
  }
}
