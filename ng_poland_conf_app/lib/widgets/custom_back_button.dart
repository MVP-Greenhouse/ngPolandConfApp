import 'package:flutter/material.dart';
import 'package:ng_poland_conf_app/widgets/custom_button.dart';

class CustomBackButton extends StatelessWidget {
  final void Function()? onPressed;

  const CustomBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return CustomButton(
      onPressed: onPressed ??
          () {
            Navigator.pop(context);
          },
      child: const Icon(Icons.arrow_back_ios_sharp),
    );
  }
}
