import 'package:chat_res/helper/main.color.dart';
import 'package:flutter/material.dart';

class BottomForm extends StatelessWidget {
  const BottomForm({super.key, required this.text, required this.onPress});

  final String text;

  final VoidCallback onPress;

  @override
  Widget build(BuildContext context) {

    return
    
     ElevatedButton(
      autofocus: false,
      style: ElevatedButton.styleFrom(

        backgroundColor: Colors.white.withOpacity(0),
        elevation: 0.0,
        
        foregroundColor: Colors.white.withOpacity(0),
         splashFactory: NoSplash.splashFactory,
      ),

      onPressed: onPress,
      child: Container(
        
        alignment: Alignment.center,
        height: 55,
        decoration: BoxDecoration(
          color: MainColor.mainColor,
          borderRadius: BorderRadius.circular(11),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
            )
          ]
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}