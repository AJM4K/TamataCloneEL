import 'package:flutter/material.dart';

class TopPageWidget extends StatelessWidget {
  const TopPageWidget({super.key, required this.title});

  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: EdgeInsets.only(left: 16, right: 16, top: 10),
      decoration: BoxDecoration(
        color: Colors.transparent,
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(
            "$title",
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 32, 32), fontSize: 24),
          ),
          SizedBox(width: 48), // This is to ensure the title remains centered
        ],
      ),
    );
  }
}
