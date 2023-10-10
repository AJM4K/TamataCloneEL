import 'package:flutter/material.dart';

class VBottomNAV extends StatelessWidget {
  const VBottomNAV({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.blue,
      child: Expanded(
          child: Row(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, '/second');
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  color: Colors.red,
                  padding: const EdgeInsets.all(8.0),
                  child: Text("nav bar ")),
            ),
          )
        ],
      )),
    );
  }
}
