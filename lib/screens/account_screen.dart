import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../models/user_model.dart';
import '../reducers/root_reducer.dart';
import '../view_models/account_view_model.dart';

import '../widgets/avatar.dart';
import '../widgets/badge.dart';

class AccountScreen extends StatelessWidget {
  AccountScreen({Key key, this.title}) : super(key: key);

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
      body: StoreConnector<RootState, AccountViewModel>(
        converter: AccountViewModel.fromStore,
        builder: (BuildContext context, AccountViewModel vm) {
          return LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints boxConstraints,
            ) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: boxConstraints.maxHeight,
                  ),
                  child:
                      vm.user is UserModel ? AccountMenu(user: vm.user) : null,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class AccountMenu extends StatelessWidget {
  final UserModel user;

  AccountMenu({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UserListItem(user: user),
        ListItem(icon: Icons.shopping_cart, label: 'Shopping Cart'),
        ListItem(icon: Icons.favorite, label: 'Wishlist'),
        ListItem(icon: Icons.assessment, label: 'Orders'),
        SizedBox(height: 16),
        ListItem(icon: Icons.notifications, label: 'Notifications'),
        ListItem(icon: Icons.lock, label: 'Password'),
        ListItem(icon: Icons.credit_card, label: 'Payment'),
        ListItem(icon: Icons.shopping_cart, label: 'Delivery Address'),
        ListItem(icon: Icons.help, label: 'Need help?'),
        ListItem(icon: Icons.arrow_right, label: 'Log Out'),
        SizedBox(height: 16),
        ListItem(icon: Icons.notifications, label: 'Notifications'),
        ListItem(icon: Icons.lock, label: 'Password'),
        ListItem(icon: Icons.credit_card, label: 'Payment'),
        ListItem(icon: Icons.shopping_cart, label: 'Delivery Address'),
        ListItem(icon: Icons.help, label: 'Need help?'),
        ListItem(icon: Icons.arrow_right, label: 'Log Out'),
      ],
    );
  }
}

class ListItem extends StatelessWidget {
  final String label;
  final IconData icon;

  ListItem({
    this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8),
                  child: Icon(
                    icon,
                  ),
                ),
                Text(label)
              ]),
              Row(
                children: <Widget>[
                  Badge(
                    count: 3,
                    size: 16,
                  ),
                  Icon(
                    Icons.chevron_right,
                    color: Color(0xffaaaaaa),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class UserListItem extends StatelessWidget {
  final UserModel user;

  UserListItem({Key key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        child: Container(
          decoration: BoxDecoration(
            color: Color(0xffeeeeee),
            borderRadius: BorderRadius.all(
              Radius.circular(8),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.all(8),
            child: Row(
              children: <Widget>[
                Avatar(
                  src: 'https://randomuser.me/api/portraits/women/68.jpg',
                ),
                Column(
                  children: <Widget>[
                    Text(
                      "${user.firstname} ${user.lastname}",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("${user.firstname} ${user.lastname}"),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
