// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myprovider/checkout.dart';
import 'package:myprovider/model/item.dart';
import 'package:provider/provider.dart';
import 'model/favourite.dart';

List<Item> items = [
  Item(
    name: "S20 Ultra",
    price: 25000,
    qty: 1,
    id: 1,
  ),
  Item(
    name: "P30 Pro",
    price: 35000,
    qty: 1,
    id: 2,
  ),
  Item(
    name: "M21 Max",
    price: 15000,
    qty: 1,
    id: 3,
  ),
  Item(
    name: "A21 Ultra",
    price: 20000,
    qty: 1,
    id: 4,
  ),
  Item(
    name: "Iphone13 Pro",
    price: 40000,
    qty: 1,
    id: 5,
  ),
];

class Home extends StatefulWidget {
  final shoppingItems = items;
  List<FavouriteContainer> favouriteProducts = <FavouriteContainer>[];
  final ValueSetter<int>? onProductTAp;
  Home({Key? key, this.onProductTAp}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Favourite _favouriteProvider;
  @override
  Widget build(BuildContext context) {
    _favouriteProvider = Provider.of<Favourite>(context);
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: Text("Home")),
            GestureDetector(
              onTap: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return CheckOut();
                }));
              },
              child: Row(
                children: [
                  Icon(Icons.favorite),
                  Column(
                    children: [
                      Consumer<Favourite>(
                        builder: (context, favourite, child) {
                          return Center(
                            child: Text(
                              "${favourite.totalPrice}",
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemBuilder: (context, index) {
          return GestureDetector(
            child: HomeContainer(
              name: items[index].name,
              price: items[index].price,
            ),
            onTap: () {
              _favouriteProvider.addQty(items[index]);
            },
          );
        },
        itemCount: items.length,
      ),
    );
  }
}

class HomeContainer extends StatelessWidget {
  final String? name;
  final List<Item>? shoppingContainer;
  final int? price;

  const HomeContainer({
    Key? key,
    this.name,
    this.price,
    this.shoppingContainer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name ?? "",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(price.toString()),
          ],
        ),
        trailing: Icon(Icons.add),
      ),
    );
  }
}
