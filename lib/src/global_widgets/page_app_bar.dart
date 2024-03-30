import 'package:flutter/material.dart';
import 'package:mot3lqat/src/config/themes/app_styles.dart';

class PageAppBar extends StatelessWidget {
  const PageAppBar({
    super.key,
    required this.text,
    required this.pageBackArrowPressed,
  });
  final String text;
  final void Function() pageBackArrowPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: pageBackArrowPressed,
          icon: const Icon(Icons.arrow_back_ios_new_outlined),
        ),
        Text('  $text', style: AppStyles.headerStyle),
      ],
    );
  }
}
