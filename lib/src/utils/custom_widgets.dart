import 'package:flutter/material.dart';

// @ TextFormField
class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final String? Function(String? value)? validator;
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
        foregroundColor: Theme.of(context).textTheme.bodyMedium!.color,
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
  final Color? color;

  const MyText(
    this.text, {
    super.key,
    this.fontSize,
    this.fontWeight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      ),
    );
  }
}

// @ Loading Builder
class MyLoading {
  // @ loading
  static Widget Loading(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: Theme.of(context).canvasColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: const CircularProgressIndicator(),
      ),
    );
  }
}

void showSnackBar(
  BuildContext context, {
  required String content,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: MyText(
        content,
        color: backgroundColor != null
            ? Colors.white
            : Theme.of(context).canvasColor,
      ),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      backgroundColor: backgroundColor,
    ),
  );
}
