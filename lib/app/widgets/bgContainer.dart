import 'package:flutter/material.dart';

class BgContainer extends StatelessWidget {
  final Widget body;
  const BgContainer({super.key, required this.body});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: SizedBox.expand(
      child: Container(
        decoration: const BoxDecoration(
            gradient: LinearGradient(
          colors: [
            Color.fromRGBO(54, 51, 136, 1),
            Colors.black,
            Color(0xFF24243E),
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: body,
      ),
    ));
  }
}