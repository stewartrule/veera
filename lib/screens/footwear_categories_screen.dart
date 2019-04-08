import 'package:flutter/material.dart';

import 'package:flutter_redux/flutter_redux.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../reducers/root_reducer.dart';
import './footwear_category_screen.dart';
import '../models/settings_model.dart';
import '../models/footwear_category_model.dart';

import '../widgets/cover_image.dart';

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

              var values = settings.footwearCategories.values.toList();

              var category =
                  values.length > 0 ? (values..shuffle()).first : null;

              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: boxConstraints.maxHeight,
                  ),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: double.infinity,
                        child: Stack(
                          children: <Widget>[
                            Container(
                              color: Color.fromARGB(90, 0, 0, 0),
                            ),
                            category is FootwearCategoryModel
                                ? CoverImage(
                                    width: double.infinity,
                                    height: 280,
                                    image: category.image,
                                  )
                                : null,
                            Positioned(
                              left: (size.width / 2),
                              bottom: 24,
                              right: 16,
                              child: Align(
                                alignment: Alignment.center,
                                child: Text(
                                  'MAN COLLECTION',
                                  style: TextStyle(
                                    fontFamily: 'RobotoCondensed',
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xffffffff),
                                    fontSize: 32,
                                    height: 1,
                                    shadows: [
                                      Shadow(
                                        color: Color.fromARGB(128, 0, 0, 0),
                                        blurRadius: 6,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ].where((x) => x != null).toList(),
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
          FontAwesomeIcons.search,
          color: Color(0xffaaaaaa),
        ),
        SizedBox(width: 8),
        Icon(
          FontAwesomeIcons.shoppingBag,
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
          height: 120,
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              CoverImage(
                width: double.infinity,
                height: 120,
                image: category.image,
              ),
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
