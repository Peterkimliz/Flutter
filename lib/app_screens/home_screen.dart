import 'dart:developer';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text("Flutter App"),
        centerTitle: true,
      ),
      body: getList(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          debugPrint('hello');
        },
        elevation: 2.0,
        child: Icon(Icons.add),
        tooltip: "You long pressed the floating button",
      ),
    );
  }

  List<String> getListItems() {
    var items = List<String>.generate(50, (counter) => "item $counter");
    return items;
  }

  Widget getList() {
    var itemList = getListItems();
    var listview = ListView.builder(itemBuilder: (context, index) {
      return ListTile(
        onTap: () {
          showSnackbar(context, itemList[index]);
        },
        leading: Icon(Icons.arrow_drop_down),
        title: Text(itemList[index]),
      );
    });
    return listview;
  }

  void showSnackbar(BuildContext context, item) {
    var snack = SnackBar(
        backgroundColor: Colors.brown,
        action: SnackBarAction(label: "Undo", onPressed: () {}),
        content: Text("You just clicked $item"));
    Scaffold.of(context).showSnackBar(snack);
  }
}
