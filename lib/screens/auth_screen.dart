import 'package:flutter/material.dart';
import 'package:papa/widgets/fade_stack.dart';

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  int selectedForm = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            FadeStack(selectedForm: selectedForm),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border(top: BorderSide(color: Colors.grey))),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      if (selectedForm == 0) {
                        selectedForm = 1;
                      } else {
                        selectedForm = 0;
                      }
                    });
                  },
                  child: RichText(
                    text: TextSpan(
                        text: selectedForm == 0
                            ? "Already have an account? "
                            : "Don't have an account? ",
                        style: TextStyle(color: Colors.grey),
                        children: [
                          TextSpan(
                            text: selectedForm == 0 ? "Sign In" : "Sign Up",
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          )
                        ]),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
