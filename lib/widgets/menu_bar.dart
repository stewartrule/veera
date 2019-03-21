import 'package:flutter/material.dart';

class MenuButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  MenuButton({
    Key key,
    this.icon,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
      alignment: Alignment.center,
      padding: EdgeInsets.all(0),
      icon: Icon(icon),
      color: Colors.black,
      onPressed: onPressed,
    );
  }
}

class MenuBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Colors.deepOrange),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: MenuButton(
              icon: Icons.menu,
              onPressed: () {},
            ),
          ),
          MenuButton(
            icon: Icons.search,
            onPressed: () {},
          ),
          Stack(
            children: <Widget>[
              IconButton(
                alignment: Alignment.center,
                padding: EdgeInsets.all(0),
                icon: Icon(Icons.shopping_basket),
                color: Colors.black,
                onPressed: () {},
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Text(
                  '4',
                  style: TextStyle(color: Colors.black),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
