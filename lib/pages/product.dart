import 'package:flutter/material.dart';
import 'dart:async';

import '../widgets/ui_elements/title_default.dart';

class ProductPage extends StatelessWidget {
  final String title;
  final String imageURL;
  final double price;
  final String description;

  ProductPage(this.title, this.imageURL, this.price, this.description);

  // _showWarningDialog(BuildContext context) {
  //   showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Are you sure?'),
  //           content: Text('This action cannot be undone!'),
  //           actions: <Widget>[
  //             FlatButton(
  //               child: Text('DELETE'),
  //               onPressed: () {
  //                 Navigator.pop(context);
  //                 Navigator.pop(context, true);
  //               },
  //             ),
  //             FlatButton(
  //                 child: Text('CANCEL'),
  //                 onPressed: () {
  //                   Navigator.pop(context);
  //                 }),
  //           ],
  //         );
  //       });
  // }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Navigator.pop(context, false);
        return Future.value(false);
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset('assets/food.jpg'),
              Container(
                padding: EdgeInsets.all(10.0),
                child: TitleDefault(title),
              ),
              SizedBox(width: 9.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    '\$ ${price.toString()}',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    ' | ',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                  Text(
                    'Tallinn',
                    style: TextStyle(
                      fontFamily: 'Oswald',
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                padding: EdgeInsets.all(10.0),
                child: Text(
                  description,
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
