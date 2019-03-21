import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../selectors/selectors.dart';

import '../reducers/root_reducer.dart';

import '../models/footwear_model.dart';

class FootwearScreen extends StatelessWidget {
  FootwearScreen({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(title),
        backgroundColor: Color(0xff222222),
        actions: <Widget>[
          Icon(Icons.search),
        ],
      ),
      body: StoreConnector<RootState, List<FootwearModel>>(
        converter: (Store<RootState> store) {
          return getFootwear(store.state);
        },
        builder: (BuildContext context, List<FootwearModel> footwear) {
          return GridView.count(
            physics: ScrollPhysics(),
            crossAxisCount: 2,
            mainAxisSpacing: 8,
            childAspectRatio: 0.5,
            crossAxisSpacing: 8,
            padding: EdgeInsets.all(8),
            children: footwear
                .map((product) => FootwearItem(product: product))
                .toList(),
          );
        },
      ),
    );
  }
}

class FootwearItem extends StatelessWidget {
  final FootwearModel product;

  FootwearItem({this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 240,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              alignment: Alignment.topCenter,
              image: AssetImage(
                'assets/images/12213240-1-multi.jpeg',
              ),
            ),
          ),
        ),
        Text(
          product.name.toUpperCase(),
          style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontWeight: FontWeight.w400,
            color: Color(0xff333333),
            fontSize: 16,
            height: 1,
          ),
        ),
        Text(
          "\$${product.price / 100}",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Color(0xff777777),
          ),
        ),
      ],
    );
  }
}
