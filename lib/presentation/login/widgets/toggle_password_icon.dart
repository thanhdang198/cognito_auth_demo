import 'package:flutter/material.dart';

import '../../../constants/constants.dart';

class TogglePasswordIcon extends StatelessWidget {
  const TogglePasswordIcon(
      {super.key, required this.isShowPassword, required this.onChangeStatus});
  final bool isShowPassword;
  final VoidCallback onChangeStatus;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onChangeStatus,
        child: isShowPassword
            ? Icon(
                Icons.no_encryption_outlined,
                color: primaryColor,
              )
            : Icon(
                Icons.lock_outline,
                color: primaryColor,
              ));
  }
}
