import 'package:flutter/material.dart';

import '../../../layout/appbar/appbar.dart';

class AccountSettings extends StatefulWidget {
  const AccountSettings({super.key});

  @override
  State<AccountSettings> createState() => _AccountSettingsState();
}

class _AccountSettingsState extends State<AccountSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      //appBar: CustomAppBar(),
        body:Center(
            child: Text("account settings")
        )
    );
  }
}
