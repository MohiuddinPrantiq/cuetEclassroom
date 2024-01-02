import 'package:flutter/material.dart';
import '../theme/app_color.dart';

class AppIconButton extends StatelessWidget {
  final Widget icon;
  final VoidCallback onTap;

  const AppIconButton({Key? key, required this.icon, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(360),
      splashColor: AppColor.grey.withOpacity(0.25),
      highlightColor: AppColor.grey.withOpacity(0.4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: icon,
      ),
    );
  }
}