import 'package:elden_kirala/layout/appbar/appbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:signalr_core/signalr_core.dart';
import '../../../api/api.dart';
import '../../../constanst/colors.dart';
import '../../../constanst/fontSize.dart';
import '../../../models/message-model/message-model.dart';
import '../../../services/fetcher.dart';
final  box = GetStorage();

class ChatBox extends StatefulWidget {
  const ChatBox({super.key});

  @override
  State<ChatBox> createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  List<Message> messageList = [];
  late Fetcher messageFetcher;

  final myUserId = box.read('user')['id'];
  late int receiverUserId = int.parse(Get.parameters['id']!);
  final token = box.read('user')['token'];
  final idController = TextEditingController();
  final descriptionController = TextEditingController();
  List<Map<String, String>> messages = [];
  late HubConnection connection; // Declare connection variable
  late HubConnection hubConnection; // Declare hubConnection variable

  @override
  void initState() {
    super.initState();
    fetchMessages();
    main(); // Initialize connection and hubConnection in initState
  }

  Future<void> fetchMessages() async {
    try {
      messageFetcher = Fetcher(Message.fromJson, _setMessages, () => Api.getMessagesUserToUser(myUserId, receiverUserId));
      await messageFetcher.fetchData(); // Await to ensure data is fetched
    } catch (error) {
      print("Error fetching messages: $error");
    }
  }

  void _setMessages(List<dynamic> data) {
    setState(() {
      messageList = data.cast<Message>(); // Cast to Message type
      for (var message in messageList) {
        messages.add({
          'text': message.messageContent ?? '',
          'sender': message.senderId == myUserId ? 'myself' : 'other',
        });
      }
      print('Messages set: $messages'); // Debug print
    });
  }
  Future<void> main() async {
    connection = HubConnectionBuilder()
        .withUrl(
      'https://10.0.2.2:7117/Chat',
      HttpConnectionOptions(
        accessTokenFactory: () async {
          return 'Bearer $token';
        },
        logging: (level, message) => print(message),
      ),
    )
        .build();

    await connection.start();

    hubConnection = connection; // Assign connection to hubConnection

    connection.on('ReceiveMessage', (message) {
      setState(() {
        print('Received message: $message');
        if (message != null && message.isNotEmpty) {
          if (message[0] is Map) {
            var messageContent = message[0];
            print('Message content: $messageContent');
            messages.add({'text': messageContent['messageContent'].toString(), 'sender': 'other'});
          } else {
            print('The first item in the message array is not a Map.');
          }
        }
      });
    });
  }

  Future<void> sendMessage() async {
    setState(() {
      messages.add({'text': descriptionController.text, 'sender': 'myself'});
    });

    var message = {
      'receiverId': receiverUserId.toString(),
      'messageContent': descriptionController.text,
    };

    if (hubConnection.state == HubConnectionState.connected) {
      try {
        await hubConnection.invoke("SendMessageToUser", args: [message]);
        descriptionController.clear();
      } catch (error) {
        print(error);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBarInPage(title: "Sohbet"),
      body: Column(
        children: [
          SizedBox(height: 20,),
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                return Align(
                  alignment: messages[index]['sender'] == 'other' ? Alignment.centerLeft : Alignment.centerRight,
                  child: Container(
                    constraints: BoxConstraints(
                      maxWidth: MediaQuery.of(context).size.width * 0.7, // Adjust as needed
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: messages[index]['sender'] == 'other' ? MyColors.primary.withOpacity(0.7) : Colors.blue.withOpacity(0.7), // Adjust colors as needed
                    ),
                    margin: EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                    padding: EdgeInsets.all(8),
                    child: Text(
                      messages[index]['text'] ?? '',
                      style: TextStyle(color: Colors.white,fontSize: MyFontSizes.fontSize_1(context)),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: descriptionController,
                    decoration: InputDecoration(
                      hintText: 'Mesaj',
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () => sendMessage(),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
