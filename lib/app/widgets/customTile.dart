import 'package:chat_backend/app/widgets/customText.dart';
import 'package:flutter/material.dart';

class CustomTile extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color? iconColor;
  final bool? showSubtitle;
  final VoidCallback ontap;
  final IconData? trailing;
  const CustomTile(
      {super.key,
      required this.icon,
      required this.text,
      required this.ontap,
      this.iconColor,
      this.showSubtitle,
      this.trailing});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: ListTile(
        tileColor: const Color(0xFF24243E),
        contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
        leading: CircleAvatar(
          radius: 27,
          backgroundColor: iconColor ?? Colors.yellow,
          child: Icon(
            icon,
            size: 35,
            color: Colors.black,
          ),
        ),
        title: CustomText(
          text: text,
          color: Colors.white,
          size: 20,
          weight: FontWeight.w400,
        ),
        subtitle: showSubtitle == true
            ? CustomText(
                text: "Last message preview",
                color: Colors.white,
                weight: FontWeight.w400)
            : null,
        trailing: Icon(
          trailing ?? Icons.chevron_right,
          color: Colors.white,
          size: 30,
        ),
      ),
    );
  }
}
