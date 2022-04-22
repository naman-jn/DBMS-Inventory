import 'package:flutter/material.dart';
import 'package:inventory_manager/views/items/items_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: Center(child: ItemListPage()));
  }
}
