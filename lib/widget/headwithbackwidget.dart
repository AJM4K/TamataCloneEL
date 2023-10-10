import 'package:flutter/material.dart';

import '../Repo/GeneralModel.dart';

class Headingwithback extends StatelessWidget {
  const Headingwithback({
    super.key,
    required this.search,
  });

  final String search;

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
          IconButton(
            icon: Icon(Icons.arrow_back,
                color: const Color.fromARGB(255, 255, 60, 60)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          Text(
            search,
            style: TextStyle(
                color: const Color.fromARGB(255, 255, 32, 32), fontSize: 24),
          ),
          SizedBox(width: 48), // This is to ensure the title remains centered
        ],
      ),
    );
  }
}
