import 'package:flutter/material.dart';

class JoinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: _bodyWidget(),
    );
  }

  Widget _bodyWidget() {
    return SafeArea(
      child: Container(
        child: Column(
          children: <Widget>[
            Text("Enter your hackathon access code:"),
          ],
        ),
      ),
    );
  }
}
