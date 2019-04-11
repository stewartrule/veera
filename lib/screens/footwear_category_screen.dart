import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

import '../widgets/cart_button.dart';
import '../widgets/cover_image.dart';

import '../models/brand_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_category_model.dart';
import '../reducers/root_reducer.dart';
import './footwear_screen.dart' show FootwearItem;

class CategoryViewModel {
  final List<FootwearCategoryModel> categories;
  final List<FootwearModel> footwear;

  CategoryViewModel({this.categories, this.footwear});
}

class FootwearCategoryScreen extends StatelessWidget {
  final FootwearCategoryModel category;

  FootwearCategoryScreen({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<RootState, CategoryViewModel>(
        converter: (store) {
          List<FootwearCategoryModel> categories =
              store.state.settings.footwearCategories.values.toList();

          List<FootwearModel> footwear = store.state.footwear.values.toList();

          return CategoryViewModel(categories: categories, footwear: footwear);
        },
        builder: (BuildContext context, CategoryViewModel vm) {
          return CategoryTabs(vm: vm, category: category);
        },
      ),
    );
  }
}

class CategoryTabs extends StatefulWidget {
  final FootwearCategoryModel category;
  final CategoryViewModel vm;

  CategoryTabs({Key key, this.category, this.vm}) : super(key: key);

  CategoryTabsState createState() => CategoryTabsState();
}

class CategoryTabsState extends State<CategoryTabs>
    with SingleTickerProviderStateMixin {
  TabController tabController;

  @override
  void initState() {
    super.initState();

    int index = widget.vm.categories.indexWhere(
      (category) => category.id == widget.category.id,
    );

    tabController = TabController(
      vsync: this,
      length: widget.vm.categories.length,
      initialIndex: index,
    );

    tabController.addListener(() {
      setState(() {
        // fixme
      });
    });
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vm = widget.vm;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'CATEGORIES',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        actions: <Widget>[
          CartButton(),
          SizedBox(width: 16),
        ],
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
          ),
        ),
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: vm.categories
                  .asMap()
                  .map(
                    (i, category) => MapEntry(
                          i,
                          InkWell(
                            onTap: () {
                              setState(() {
                                tabController.animateTo(i);
                              });
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(
                                i == 0 ? 24 : 16,
                                16,
                                i == vm.categories.length - 1 ? 24 : 16,
                                16,
                              ),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    width: 1,
                                    color: Color(0xffeeeeee),
                                  ),
                                ),
                              ),
                              child: Text(
                                category.name.toUpperCase(),
                                style: TextStyle(
                                  color: tabController.index == i
                                      ? Colors.black
                                      : Color(0xffaaaaaa),
                                  fontFamily: 'RobotoCondensed',
                                  fontSize: 16,
                                ),
                              ),
                            ),
                          ),
                        ),
                  )
                  .values
                  .toList(),
            ),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: vm.categories
            .map(
              (category) => Tab(
                    child: CategoryView(
                      footwear: vm.footwear
                          .where((model) => model.categoryId == category.id)
                          .toList(),
                    ),
                  ),
            )
            .toList(),
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  final List<FootwearModel> footwear;

  CategoryView({Key key, this.footwear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  HorizontalList(
                    footwear: footwear.sublist(0, 4).toList(),
                  ),
                ],
              ),
            ),
          ),
          SliverPadding(
            padding: EdgeInsets.all(24),
            sliver: SliverGrid(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.5,
                crossAxisSpacing: 16,
              ),
              delegate: SliverChildListDelegate(
                footwear
                    .sublist(4)
                    .map((product) => FootwearItem(product: product))
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class HorizontalList extends StatelessWidget {
  final List<FootwearModel> footwear;
  final double itemWidth;
  final double itemHeight;
  final double spacing;

  const HorizontalList({
    Key key,
    @required this.footwear,
    this.itemWidth = 256,
    this.itemHeight = 256,
    this.spacing = 16,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: itemHeight,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: footwear
            .asMap()
            .map(
              (index, product) => MapEntry(
                    index,
                    Container(
                      margin: EdgeInsets.only(
                        left: index == 0 ? 24 : spacing,
                        right: index == footwear.length - 1 ? 24 : 0,
                      ),
                      width: itemWidth,
                      height: itemHeight,
                      child: Stack(
                        alignment: Alignment.topRight,
                        children: <Widget>[
                          CoverImage(
                            image: product.image,
                            width: itemWidth,
                            height: itemHeight,
                          ),
                          Positioned(
                            right: 16,
                            left: (itemWidth / 2),
                            bottom: 24,
                            child: Text(
                              product.name.toUpperCase(),
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                  shadows: [
                                    Shadow(
                                      blurRadius: 4.0,
                                      color: Color.fromARGB(85, 0, 0, 0),
                                    ),
                                  ]),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
            )
            .values
            .toList(),
      ),
    );
  }
}
