
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:start_software_flutter/models/product_model.dart';
import 'package:start_software_flutter/shared/components.dart';

class ItemCard extends StatefulWidget {
  // List<Map> productsMap;
  //
  // // final ProductModel product;
  //
  //
  // ItemCard({required this.productsMap});
  int index;
  ItemCard(this.index);


  @override
  State<ItemCard> createState() => _ItemCardState();

}

class _ItemCardState extends State<ItemCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(30),
            // height: 180,
            // width: 160,
            decoration: BoxDecoration(
                 borderRadius: BorderRadius.circular(16)),
            // child: Image.asset('assets/images/image1.png'),
            child: Image.network(productsMap[widget.index]['image']),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4),
          child: Container(
            height: 17,
            child: Text(
              productsMap[widget.index]['title'],
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ),
        Text(
          productsMap[widget.index]['price'],
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
