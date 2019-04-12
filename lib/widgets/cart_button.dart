import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../reducers/root_reducer.dart';

class CartButton extends StatelessWidget {
  const CartButton({
    Key key,
    this.color = const Color(0xffaaaaaa),
  }) : super(key: key);

  final Color color;

  @override
  Widget build(BuildContext context) {
    return StoreConnector<RootState, int>(
      converter: (Store<RootState> store) {
        return store.state.basket.items.length;
      },
      builder: (
        BuildContext context,
        int itemCount,
      ) {
        return Container(
          alignment: Alignment.center,
          child: Stack(
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/basket');
                },
                child: Padding(
                  padding: EdgeInsets.only(right: 4),
                  child: Icon(
                    FontAwesomeIcons.shoppingBag,
                    color: color,
                  ),
                ),
              ),
              itemCount > 0
                  ? Positioned(
                      top: 0,
                      right: 0,
                      child: Container(
                        width: 16,
                        height: 16,
                        decoration: BoxDecoration(
                          color: Color(0xfffc8183),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          itemCount.toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                  : null
            ].where((x) => x != null).toList(),
          ),
        );
      },
    );
  }
}
