import 'package:flutter/material.dart';
import '../../../layout/appbar/appbar.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _HesabimState();
}

class _HesabimState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Center(
        child: Text("accouuunt")
      )
    );
  }
}
