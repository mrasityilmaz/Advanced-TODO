import 'package:flutter/material.dart';

class MyTextFieldWidget extends StatelessWidget {
  final TextEditingController textEditingController;
  final String? hintText;
  final Color? fillColor;
  final Icon? suffixIcon;
  final Function(String)? onDone;

  const MyTextFieldWidget(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.onDone,
      this.fillColor,
      this.suffixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      onSubmitted: onDone,
      controller: textEditingController,
      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
      decoration: InputDecoration(
          suffixIcon: suffixIcon,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
          contentPadding: const EdgeInsets.symmetric(horizontal: 20),
          hoverColor: Colors.white,
          fillColor: fillColor ?? Colors.white,
          filled: true,
          focusColor: Colors.white,
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30),
              borderSide: BorderSide.none)),
    );
  }
}
