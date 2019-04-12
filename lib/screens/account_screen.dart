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
        elevation: 0,
        iconTheme: IconThemeData(
          color: Color(0xfffc8183),
        ),
        backgroundColor: Colors.white,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        title: Text(
          title,
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
          textAlign: TextAlign.start,
        ),
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
    return Container(
      padding: EdgeInsets.fromLTRB(24, 8, 24, 24),
      color: Colors.white,
      child: Column(
        children: [
          UserListItem(user: user),
          SizedBox(
            height: 16,
          ),
          ListItem(icon: Icons.shopping_cart, label: 'Shopping Cart'),
          ListItem(icon: Icons.favorite, label: 'Wishlist'),
          ListItem(icon: Icons.assessment, label: 'Orders'),
          ListItem(icon: Icons.notifications, label: 'Notifications'),
          ListItem(icon: Icons.lock, label: 'Password'),
          ListItem(icon: Icons.credit_card, label: 'Payment'),
          ListItem(icon: Icons.shopping_cart, label: 'Delivery Address'),
          ListItem(icon: Icons.help, label: 'Need help?'),
          ListItem(icon: Icons.arrow_right, label: 'Log Out'),
          Container(
            child: InkWell(
              child: Container(
                padding: EdgeInsets.all(16),
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xffeeeeee),
                    width: 1,
                  ),
                ),
                child: Text(
                  'LOGOUT',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              onTap: () {},
            ),
          ),
        ],
      ),
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
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1,
              color: Color(0xffeeeeee),
            ),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(children: <Widget>[
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 16, 16),
                child: Icon(
                  icon,
                ),
              ),
              Text(
                label,
                style: TextStyle(fontSize: 16),
              )
            ]),
            Badge(
              count: 3,
              size: 24,
            ),
          ],
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Avatar(
            src: 'https://randomuser.me/api/portraits/women/68.jpg',
            size: 160,
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            "${user.firstname} ${user.lastname}",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          // Text("${user.firstname} ${user.lastname}"),
        ],
      ),
    );
  }
}
