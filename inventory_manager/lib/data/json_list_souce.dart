// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:inventory_manager/models/item/item.model.dart';

class JsonItemData extends DataTableSource {
  // Generate some made-up data

  BuildContext context;
  List<Item> filteredItemList;
  JsonItemData({required this.context, required this.filteredItemList});

  @override
  bool get isRowCountApproximate => false;
  @override
  int get rowCount => filteredItemList.length;
  @override
  int get selectedRowCount => 0;

  @override
  DataRow getRow(int index) {
    Item _item = filteredItemList[index];

    return DataRow(cells: [
      //Item Id
      buildDataCell(
        context,
        '#${_item.id}',
        width: 50,
        onTap: () {},
      ),
      //Item Name
      buildDataCell(
        context,
        _item.name,
        width: 320,
        onTap: () {},
      ),
      //Item Brand
      buildDataCell(
        context,
        _item.brand,
        width: 320,
        onTap: () {},
      ),
      //Item Price
      buildDataCell(
        context,
        _item.price.toStringAsFixed(2),
        width: 320,
        onTap: () {},
      ),
      //Item Catgorye
      buildDataCell(
        context,
        _item.category,
        width: 320,
        onTap: () {},
      ),
    ]);
  }

  DataCell buildDataCell(BuildContext context, String content,
      {Item? question, Function()? onTap, double? width = 70}) {
    return DataCell(
      SizedBox(
        width: width,
        child: Text(
          content,
        ),
      ),
      onTap: onTap,
    );
  }
}
// //  RequestStatus.values
// //           .firstWhere((e) => e.toString() == map['requestStatus'])
