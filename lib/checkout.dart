// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:myprovider/home.dart';
import 'package:provider/provider.dart';
import './model/item.dart';
import './model/favourite.dart';

class CheckOut extends StatelessWidget {
  const CheckOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Checkout"),
        ),
        body: Consumer<Favourite>(
          builder: (context, favourite, child) {
            return ListView.builder(
              itemCount: favourite.favouriteItems.length,
              itemBuilder: (context, index) {
                return FavouriteContainer(
                  name: favourite.favouriteItems[index].name,
                  price: favourite.favouriteItems[index].price,
                  qty: favourite.favouriteItems[index].qty,
                  onTapAdd: () {
                    favourite.addQty(favourite.favouriteItems[index]);
                  },
                  onTapRemove: () {
                    favourite.lessQty(favourite.favouriteItems[index]);
                  },
                );
              },
            );
          },
        ));
  }
}

class FavouriteContainer extends StatelessWidget {
  final List<Item>? favouriteContainer;
  final String? name;
  final int? price;
  final void Function()? onTapAdd;
  final void Function()? onTapRemove;
  final int? qty;

  const FavouriteContainer({
    Key? key,
    this.name,
    this.price,
    this.favouriteContainer,
    this.onTapAdd,
    this.onTapRemove,
    this.qty,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Column(
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
          ),
          Row(
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              Consumer<Favourite>(
                builder: (context, favourite, child) {
                  return GestureDetector(
                    onTap: onTapAdd,
                    child: Icon(Icons.add),
                  );
                },
              ),
              Consumer<Favourite>(builder: (context, favourite, child) {
                return Text(qty.toString());
              }),
              Consumer<Favourite>(
                builder: (context, favourite, child) {
                  return GestureDetector(
                    onTap: onTapRemove,
                    child: Icon(Icons.remove),
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
