import 'package:flutter/material.dart';
import '../models/settings_model.dart';
import '../models/footwear_category_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

import '../reducers/root_reducer.dart';
import '../view_models/account_view_model.dart';
import './footwear_category_screen.dart';

import '../util/cdn_image.dart';

class FootwearCategoriesScreen extends StatelessWidget {
  final String title;

  FootwearCategoriesScreen({Key key, this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TopBar(title: title),
      body: StoreConnector<RootState, SettingsModel>(
        converter: (store) {
          return store.state.settings;
        },
        builder: (BuildContext context, SettingsModel settings) {
          return LayoutBuilder(
            builder: (
              BuildContext context,
              BoxConstraints boxConstraints,
            ) {
              final size = MediaQuery.of(context).size;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: boxConstraints.maxHeight,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage(
                              'assets/images/pexels-photo-296881.jpg',
                            ),
                          ),
                        ),
                        height: 200,
                        alignment: Alignment.center,
                        child: Stack(
                          alignment: Alignment.center,
                          children: <Widget>[
                            Container(
                              color: Color.fromARGB(90, 0, 0, 0),
                            ),
                            Positioned(
                              left: (size.width / 3) * 2,
                              top: 0,
                              bottom: 0,
                              right: 16,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'PLAID FLANEL BODY VEST',
                                  style: TextStyle(
                                    fontFamily: 'RobotoCondensed',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffffffff),
                                    fontSize: 24,
                                    height: 1,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Column(
                          children: settings.footwearCategories.values.map(
                            (category) {
                              return _FootwearCategoryItem(category: category);
                            },
                          ).toList(),
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({
    Key key,
    @required this.title,
  }) : super(key: key);

  final String title;

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: true,
      elevation: 0,
      iconTheme: IconThemeData(
        color: Color(0xfffc8183),
      ),
      backgroundColor: Colors.white,
      leading: Icon(Icons.menu),
      title: Text(
        title,
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
        ),
        textAlign: TextAlign.start,
      ),
      actions: <Widget>[
        Icon(
          Icons.search,
          color: Color(0xffaaaaaa),
        ),
        SizedBox(width: 8),
        Icon(
          Icons.shopping_cart,
          color: Color(0xffaaaaaa),
        ),
        SizedBox(width: 16),
      ],
    );
  }
}

class _FootwearCategoryItem extends StatelessWidget {
  final FootwearCategoryModel category;

  const _FootwearCategoryItem({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
        horizontal: 24,
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FootwearCategoryScreen(category: category),
            ),
          );
        },
        child: Container(
          width: double.infinity,
          decoration: BoxDecoration(
            image: DecorationImage(
              fit: BoxFit.cover,
              image: cdnImage(category.image),
            ),
          ),
          height: 120,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              Container(
                color: Color.fromARGB(90, 0, 0, 0),
              ),
              Positioned(
                left: 24,
                child: Text(
                  category.name.toUpperCase(),
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                    fontSize: 16,
                    height: 1,
                  ),
                ),
              ),
              Positioned(
                right: 24,
                child: Text(
                  category.productCount.toString(),
                  style: TextStyle(
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.w600,
                    color: Color(0xffffffff),
                    fontSize: 16,
                    height: 1,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
