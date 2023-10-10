import 'package:flutter/material.dart';

import '../Repo/GeneralModel.dart';

class HeadingWidget extends StatelessWidget {
  const HeadingWidget({
    super.key,
    required this.product,
  });

  final Product product;

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
          Expanded(
            child: Text(
              product.name,
              style: TextStyle(
                  color: const Color.fromARGB(255, 255, 32, 32), fontSize: 24),
            ),
          ),
          SizedBox(width: 48), // This is to ensure the title remains centered
        ],
      ),
    );
  }
}
