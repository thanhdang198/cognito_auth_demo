import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../constants/constants.dart';

class CopyableTextWidget extends StatelessWidget {
  const CopyableTextWidget({super.key, required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(text),
        ),
        InkWell(
          child: Icon(
            Icons.copy,
            color: primaryColor,
          ),
          onTap: () {
            Clipboard.setData(ClipboardData(text: text));
          },
        )
      ],
    );
  }
}
