import 'package:flutter/material.dart';

// @ TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onTapOutside: (event) {
        FocusScope.of(context).unfocus();
      },
      keyboardType: keyboardType,
      validator: validator ??
          (value) {
            if (value == null || value.isEmpty) {
              return "Masih kosong...";
            }

            return null;
          },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.all(2),
        hintText: hintText,
      ),
    );
  }
}

// @ Button
class MyButton extends StatelessWidget {
  final Widget child;
  final void Function()? onPressed;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
      ),
      child: child,
    );
  }
}

// @ Text
class MyText extends StatelessWidget {
  final String text;
  final double? fontSize;
  final FontWeight? fontWeight;

  const MyText({
    super.key,
    required this.text,
    this.fontSize,
    this.fontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
