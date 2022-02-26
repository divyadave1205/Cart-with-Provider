import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:myprovider/model/item.dart';

class Favourite extends ChangeNotifier {
  final List<Item> _items = [];
  double _price = 0.0;

  void addQty(Item item) {
    if (_items.where((element) {
      return element.id == item.id;
    }).isNotEmpty) {
      item.qty = (item.qty ?? 0) + 1;
    } else {
      _items.add(item);
    }
    _price += item.price ?? 0.toDouble();
    notifyListeners();
  }

  void lessQty(Item item) {
    if (_items.where((element) {
          return element.id == item.id;
        }).isNotEmpty &&
        item.qty! > 1) {
      item.qty = (item.qty ?? 0) - 1;
    } else {
      _items.remove(item);
    }
    _price -= item.price ?? 0.toDouble();
    notifyListeners();
  }

  int get count => _items.length;
  double get totalPrice => _price;
  List<Item> get favouriteItems => _items;
}
