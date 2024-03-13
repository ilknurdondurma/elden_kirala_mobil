import 'package:flutter/material.dart';

import '../../../layout/appbar/appbar.dart';

class Notification extends StatefulWidget {
  const Notification({super.key});

  @override
  State<Notification> createState() => _NotificationState();
}

class _NotificationState extends State<Notification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

        //appBar: CustomAppBar(),
        body:Center(
            child: Text("notification")
        )
    );
  }
}
