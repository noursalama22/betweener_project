import 'package:betweener_project/core/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextFormField extends StatefulWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final bool password;
  final TextInputType? keyboardType;
  final String? Function(String?)? validator;
  final Iterable<String>? autofillHints;

  CustomTextFormField(
      {super.key,
      required this.label,
      this.controller,
      this.hint,
      this.password = false,
      this.keyboardType,
      this.validator,
      this.autofillHints});

  @override
  State<CustomTextFormField> createState() => _CustomTextFormFieldState();
}

class _CustomTextFormFieldState extends State<CustomTextFormField> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Styles.textStyle14,
        ),
        const SizedBox(
          height: 12,
        ),
        TextFormField(
          keyboardType: widget.keyboardType,
          controller: widget.controller,
          validator: widget.validator,
          autofillHints: widget.autofillHints,
          obscureText: widget.password? _obscureText : false,
          enableSuggestions: widget.password == true ? false : true,
          autocorrect: widget.password == true ? false : true,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              hintText: widget.hint,
              border: Styles.primaryRoundedOutlineInputBorder,
              focusedBorder: Styles.primaryRoundedOutlineInputBorder,
              errorBorder: Styles.primaryRoundedOutlineInputBorder,
              enabledBorder: Styles.primaryRoundedOutlineInputBorder,
              disabledBorder: Styles.primaryRoundedOutlineInputBorder,
              suffixIcon: widget.password
                  ? _obscureText
                      ? IconButton(
                          icon: const Icon(
                            (Icons.visibility),
                          ),
                          onPressed: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                        )
                      : IconButton(
                          icon: Icon(
                            (Icons.visibility_off),
                          ),
                          onPressed: () {
                            _obscureText = !_obscureText;
                            setState(() {});
                          },
                        )
                  : null),
        ),
      ],
    );
  }
}
