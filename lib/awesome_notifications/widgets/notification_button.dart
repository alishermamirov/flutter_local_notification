import 'package:flutter/material.dart';

class NotificationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String buttontext;
  const NotificationButton({
    Key? key,
    required this.onPressed,
    required this.buttontext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(onPressed: onPressed, child: Text(buttontext));
  }
}
