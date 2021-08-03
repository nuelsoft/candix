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
  final Function(String)? onChanged;

  Input.multi(this.label,
      {this.controller,
      this.type,
      this.capitalization,
      this.action,
      this.onChanged,
      this.validator})
      : multi = true;

  Input(this.label,
      {this.controller,
      this.type,
      this.onChanged,
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
              ? TextInputType.number
              : type == InputType.multiLine
                  ? TextInputType.multiline
                  : TextInputType.text,
      minLines: multi ? 2 : 1,
      maxLines: multi ? 4 : 1,
      textInputAction: action ?? TextInputAction.next,
      validator: validator,
      textCapitalization: capitalization ?? TextCapitalization.none,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        fillColor: milder,
        filled: true,
        contentPadding: EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }
}
