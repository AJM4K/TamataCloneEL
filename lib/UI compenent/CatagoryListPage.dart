import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/widget/TopPage.dart';
import 'SettingPage.dart';

class CatagoryPage extends StatefulWidget {
  const CatagoryPage({super.key});

  @override
  State<CatagoryPage> createState() => _CatagoryPageState();
}

class _CatagoryPageState extends State<CatagoryPage> {
  final List<String> items = <String>[
    'Technology',
    'Mobiles',
    'Clothes',
    'Women',
    'Men',
    'Children',
    'Kitchen'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            TopPageWidget(title: "All Catagories"),
            Expanded(
              child: ListView.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => CatagoryListPage(
                              searchString: items[index],
                            ),
                          ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: CupertinoColors.systemGrey6,
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: ListTile(
                          leading: Icon(CupertinoIcons.cart,
                              color: Color.fromARGB(255, 255, 49, 93)),
                          title: Text(' ${items[index]}',
                              style: TextStyle(color: CupertinoColors.black)),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
