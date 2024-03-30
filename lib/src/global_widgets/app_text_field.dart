import 'package:flutter/material.dart';
import 'package:mot3lqat/src/config/themes/app_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isPasswordVisible,
    required this.label,
  });

  final TextEditingController controller;
  final String hintText, label;
  final bool isPasswordVisible;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool isPasswordVisible;

  @override
  void initState() {
    isPasswordVisible = widget.isPasswordVisible;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12.0),
          child: Text(widget.label, style: AppStyles.subHeaderStyle),
        ),
        TextField(
          controller: widget.controller,
          obscureText:
              widget.isPasswordVisible && widget.hintText == '********',
          decoration: InputDecoration(
            hintText: widget.hintText,
            suffixIcon: widget.hintText == '********'
                ? IconButton(
                    icon: Icon(
                      widget.isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: const Color.fromARGB(255, 5, 56, 97),
                    ),
                    onPressed: () {
                      setState(
                        () {
                          isPasswordVisible = !isPasswordVisible;
                        },
                      );
                    },
                  )
                : null,
            filled: true,
            fillColor: Colors.grey[200],
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide.none),
          ),
        ),
      ],
    );
  }
}
