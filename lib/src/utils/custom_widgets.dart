import 'package:flutter/material.dart';

// @ TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String?)? validator;
  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final bool obscureText;

  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.validator,
    this.keyboardType,
    this.suffixIcon,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
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
        suffixIcon: suffixIcon,
      ),
    );
  }
}

// @ Button
class MyButton extends StatelessWidget {
  final Widget child;
  final Color? backgroundColor;
  final OutlinedBorder? shape;
  final EdgeInsetsGeometry? padding;
  final void Function()? onPressed;

  const MyButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.backgroundColor,
    this.shape,
    this.padding = const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: padding,
        backgroundColor: backgroundColor ?? Theme.of(context).primaryColor,
        foregroundColor: Colors.white,
        elevation: backgroundColor != null ? 0 : 8,
        shape: shape,
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

  const MyText(
    this.text, {
    super.key,
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
