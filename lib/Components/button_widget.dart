import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';


class ButtonWidget extends StatelessWidget {
  // const ButtonWidget({Key? key}) : super(key: key);
  final String text;
  final VoidCallback onClicked;

  ButtonWidget({required this.text, required this.onClicked});
  
  @override
  Widget build(BuildContext context) {
    return RaisedButton( 
        child: Text(
          text,
          style: TextStyle(fontSize: 24),

        ),
        // shape:StadiumBorder(),
        color: Colors.black,
        padding:EdgeInsets.symmetric(horizontal: 10, vertical:10),
        textColor:Colors.white,
        onPressed: onClicked,

    );
  }
}
