import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../Repo/Databaserepo.dart';
import '../Repo/GeneralModel.dart';
import '../widget/TopPage.dart';
import 'ProductPage.dart';
import 'SettingPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> items = List<String>.generate(10, (i) => "Item $i");
  final List<String> allitems = <String>[
    'Technology',
    'Mobiles',
    'Clothes',
    'Women',
    'Men',
    'Children',
    'Kitchen'
  ];
  late Future<List<Product>> databaseProducts;
  List<Product> _products = [];
  List<Product> _searchResult = [];
  final databaseObject = ProductRepository();
  @override
  void initState() {
    super.initState();
    loadProducts(); // Adjusted here
  }

  Future<void> loadProducts() async {
    // Adjusted here
    _products = await databaseObject.readProducts();

    setState(() {});
  }

  Future<List<Product>> getall() async {
    // Adjusted here
    _products = await databaseObject.readProducts();

    return _products;
  }

  Future<List<Product>> getvalue(String Text) async {
    return _products
        .where(
            (product) => product.catagory.toLowerCase() == Text.toLowerCase())
        .toList();
  }

  Widget _buildCircleIcon(IconData iconData, String text) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CatagoryListPage(
                searchString: text,
              ),
            ));
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.red,
            radius: 30.0,
            child: Icon(iconData, color: Colors.white, size: 30.0),
          ),
          SizedBox(height: 10.0),
          Text(
            text,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: FutureBuilder<List<Product>>(
          future: getall(),
          builder:
              (BuildContext context, AsyncSnapshot<List<Product>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              _products = snapshot.data!;
              return Column(
                children: [
                  TopPageWidget(title: "Homepage"),
                  Expanded(
                    child: ListView(
                      children: <Widget>[
                        CarouselSlider(
                          options:
                              CarouselOptions(height: 150.0, autoPlay: true),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                  width: MediaQuery.of(context).size.width,
                                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                                  decoration:
                                      BoxDecoration(color: Colors.amber),
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                CatagoryListPage(
                                              searchString: allitems[i],
                                            ),
                                          ));
                                    },
                                    child: Image.asset(
                                      // Adjusted here
                                      'assets/images/image$i.jpg',
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                        Padding(padding: EdgeInsets.all(7)),
                        GridView.count(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          crossAxisCount: 3,
                          childAspectRatio: 1.0,
                          mainAxisSpacing: 2.0,
                          crossAxisSpacing: 2.0,
                          children: [
                            _buildCircleIcon(Icons.computer, 'Technology'),
                            _buildCircleIcon(Icons.checkroom, 'Clothes'),
                            _buildCircleIcon(Icons.pregnant_woman, 'Women'),
                            _buildCircleIcon(Icons.male, 'Men'),
                            _buildCircleIcon(Icons.child_care, 'Children'),
                            _buildCircleIcon(Icons.phone_android, 'Mobiles'),
                          ],
                        ),
                        ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    TopPageWidget(title: allitems[index]),
                                    Row(
                                      children: [
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      CatagoryListPage(
                                                    searchString:
                                                        allitems[index],
                                                  ),
                                                ));
                                          },
                                          child: Container(
                                            child: Text("See All"),
                                          ),
                                        ),
                                        Padding(padding: EdgeInsets.all(7)),
                                      ],
                                    ),
                                  ],
                                ),
                                Container(
                                  height: 200,
                                  child: FutureBuilder<List<Product>>(
                                    future: getvalue(allitems[index]),
                                    builder: (BuildContext context,
                                        AsyncSnapshot<List<Product>> snapshot) {
                                      if (snapshot.connectionState ==
                                          ConnectionState.waiting) {
                                        return Center(
                                            child: CircularProgressIndicator());
                                      } else if (snapshot.hasError) {
                                        return Text('Error: ${snapshot.error}');
                                      } else {
                                        List<Product> result = snapshot.data!;

                                        return ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          itemCount: result.length,
                                          itemBuilder: (context, index) {
                                            return GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          ProductDetailPage(
                                                              product: result[
                                                                  index])),
                                                );
                                              },
                                              child: Container(
                                                width: 160.0,
                                                child: Card(
                                                  child: Wrap(
                                                    children: <Widget>[
                                                      Image.asset(
                                                        'assets/images/image${index + 1}.jpg',
                                                        height: 100,
                                                        width: 160,
                                                        fit: BoxFit.cover,
                                                      ),
                                                      ListTile(
                                                          title: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Container(
                                                            decoration:
                                                                BoxDecoration(
                                                              color: Colors.red[
                                                                  50], // This creates a light red rectangular background.
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10), // This makes the border rounded.
                                                            ),
                                                            padding: EdgeInsets.all(
                                                                8), // This adds some padding between the text and the border.
                                                            child: Text(
                                                              "\$${result[index].price.toString()}",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .red,
                                                                  fontSize:
                                                                      12 // This makes the text color red.
                                                                  ),
                                                            ),
                                                          ),
                                                          Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      top: 7)),
                                                          Text(
                                                            result[index]
                                                                        .name
                                                                        .length >
                                                                    20
                                                                ? '${result[index].name.substring(0, 20)}...'
                                                                : result[index]
                                                                    .name,
                                                          )
                                                        ],
                                                      )),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
                                      }
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                        Padding(padding: EdgeInsets.all(16)),
                        CarouselSlider(
                          options:
                              CarouselOptions(height: 150.0, autoPlay: true),
                          items: [1, 2, 3, 4, 5].map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return GestureDetector(
                                  onTap: () {
                                    print("tap on image number $i");
                                  },
                                  child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      margin:
                                          EdgeInsets.symmetric(horizontal: 5.0),
                                      decoration:
                                          BoxDecoration(color: Colors.amber),
                                      child: Text(
                                        'text $i',
                                        style: TextStyle(fontSize: 16.0),
                                      )),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }
          }),
    ));
  }
}

class CatagorySection extends StatelessWidget {
  const CatagorySection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.blue,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.amber,
                                child: Text("text data "),
                              ),
                              Text(" expaned "),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.amber,
                                child: Text("text data "),
                              ),
                              Text(" expaned "),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.amber,
                                child: Text("text data "),
                              ),
                              Text(" expaned "),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.amber,
                                child: Text("text data "),
                              ),
                              Text(" expaned "),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ))),
      ],
    );
  }
}

class MainSection extends StatelessWidget {
  const MainSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.red,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      color: Colors.amber,
                      child: Text("text data "),
                    ),
                    Text("text inside column inisde expaned "),
                    Text("text inside column inisde expaned "),
                  ],
                ))),
      ],
    );
  }
}
