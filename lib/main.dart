// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:myprovider/model/favourite.dart';
import 'package:myprovider/home.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<Favourite>(
      create: (BuildContext context) {
        return Favourite();
      },
      builder: (context, child) {
        return MaterialApp(
          home: Home(),
          debugShowCheckedModeBanner: false,
        );
      },
    );
  }
}

class ProviderUse extends StatefulWidget {
  const ProviderUse({Key? key}) : super(key: key);

  @override
  _ProviderUseState createState() => _ProviderUseState();
}

class _ProviderUseState extends State<ProviderUse> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Material App Bar"),
      ),
      body: Consumer<UserDetails>(
        builder: (context, provider, child) {
          return Column(
            children: [
              Text(
                "hi" + " " + provider.userName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'You are ' + provider.userAge + ' years old',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w400,
                ),
              ),
              TextFormField(
                onChanged: provider.updateName,
              ),
              TextFormField(
                onChanged: provider.updateAge,
              ),
            ],
          );
        },
      ),
    );
  }
}

class UserDetails extends ChangeNotifier {
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();

  String _age = "0";
  String _userName = '';
  String get userAge => _age;

  String get userName => _userName;

  void updateAge(String age) {
    _age = age;
    notifyListeners();
  }

  void updateName(String name) {
    _userName = name;
    notifyListeners();
  }
}
