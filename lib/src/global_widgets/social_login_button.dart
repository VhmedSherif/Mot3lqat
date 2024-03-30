import 'package:flutter/material.dart';

class SocialLoginButton extends StatelessWidget {
  
  const SocialLoginButton({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 50,
      width: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: const Color.fromARGB(255, 231, 229, 229),
      ),
      child: child,
    );
  }
}
