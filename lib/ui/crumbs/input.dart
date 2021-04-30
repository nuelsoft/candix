import 'package:candix/ui/utils.dart';
import 'package:flutter/material.dart';

enum InputType { email, password, number, text, multiLine }

class Input extends StatelessWidget {
  final bool multi;
  final String label;
  final TextEditingController? controller;
  final InputType? type;
  final TextCapitalization? capitalization;
  final String? Function(String?)? validator;
  final TextInputAction? action;

  Input.multi(this.label,
      {this.controller,
      this.type,
      this.capitalization,
      this.action,
      this.validator})
      : multi = true;

  Input(this.label,
      {this.controller,
      this.type,
      this.capitalization,
      this.action,
      this.validator})
      : multi = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: type == InputType.password,
      keyboardType: type == InputType.email
          ? TextInputType.emailAddress
          : type == InputType.number
              ? TextInputType.number:
          type == InputType.multiLine? TextInputType.multiline
              : TextInputType.text,
      minLines: multi ? 2 : 1,
      maxLines: multi ? 4 : 1,
      textInputAction: action ?? TextInputAction.next,
      validator: validator,
      textCapitalization: capitalization ?? TextCapitalization.none,
      decoration: InputDecoration(
        labelText: label,
        fillColor: milder,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
