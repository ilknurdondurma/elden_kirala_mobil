import 'package:elden_kirala/services/fetcher.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:intl/intl.dart';

import '../../api/api.dart';
import '../../components/progressIndicator/progressIndicator.dart';
import '../../components/text/text.dart';
import '../../constanst/fontSize.dart';
import '../../models/message-model/message-model.dart';

final box = GetStorage();

class MessageBox extends StatefulWidget {
  const MessageBox({super.key,});

  @override
  State<MessageBox> createState() => _MessageBoxState();
}

class _MessageBoxState extends State<MessageBox> {
  List<Message> messageList = [];
  late Fetcher messageFetcher;
  late String myUserId = box.read('user')['id'].toString();

  @override
  void initState() {
    super.initState();
    messageFetcher = Fetcher(Message.fromJson, _setMessages, () => Api.getMessagesByUserId(myUserId));
    messageFetcher.fetchData();
  }

  void _setMessages(List<dynamic> data) {
    setState(() {
      messageList = data.cast<Message>(); // Cast to Message type
    });
  }
  String convertTimestampToDate(int timestamp) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate = DateFormat('d MMMM HH:mm',).format(date);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 20,),
          messageList.isEmpty && messageFetcher.isLoading // Waiting for data from API
              ? IndicatorProgressBar()
              : messageList.isEmpty // No products found
              ? Center(child: MyText(text: "Ürün bulunamadı"),)
              : Expanded(
                  child: ListView.builder(
                    itemCount: messageList.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: GestureDetector(
                          onTap:()=> Get.toNamed('/chat/${messageList[index].receiverId}'),
                          child: ListTile(
                            trailing: Text(convertTimestampToDate(messageList[index].date!) ?? ''),
                            title: Row(
                              children: [
                                Text(messageList[index].userName ?? ''),
                                SizedBox(width: 5,),
                                Text(messageList[index].userSurname ?? ''),
                              ],
                            ),
                            subtitle: Text(messageList[index].messageContent ?? '' ,style: TextStyle(color: Colors.black54),),
                            leading: CircleAvatar(
                              backgroundImage: AssetImage('assets/ic_launcher.png'),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
