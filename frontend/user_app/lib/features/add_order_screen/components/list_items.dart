import 'package:flutter/material.dart';
import 'package:user_app/features/add_order_screen/components/components_export.dart';
import 'package:user_app/models/models_export.dart';

class ItemsList extends StatelessWidget {
  const ItemsList({super.key, required this.itemsList});

  final List<ItemModel> itemsList;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: itemsList.length,
        itemBuilder: (context, index) {
          ItemModel item = itemsList[index];
          return ItemOfItemsList(item: item, index: index);
        });
  }
}