import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter/material.dart';

import '../widgets/cover_image.dart';

import '../models/brand_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_category_model.dart';
import '../reducers/root_reducer.dart';
import './footwear_screen.dart' show FootwearItem;

class CategoryViewModel {
  final List<BrandModel> brands;
  final List<FootwearModel> footwear;

  CategoryViewModel({this.brands, this.footwear});
}

class FootwearCategoryScreen extends StatelessWidget {
  final FootwearCategoryModel category;

  FootwearCategoryScreen({Key key, this.category}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StoreConnector<RootState, CategoryViewModel>(
        converter: (store) {
          List<BrandModel> brands =
              store.state.settings.footwearBrands.values.toList();
          List<FootwearModel> footwear = store.state.footwear.values.toList();
          return CategoryViewModel(brands: brands, footwear: footwear);
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

    tabController = TabController(
      vsync: this,
      length: widget.vm.brands.length,
    );
  }

  @override
  void dispose() {
    tabController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var vm = widget.vm;
    var category = widget.category;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          category.name.toUpperCase(),
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.red),
        backgroundColor: Colors.white,
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(48.0),
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
                children: vm.brands
                    .asMap()
                    .map(
                      (i, brand) => MapEntry(
                            i,
                            InkWell(
                              onTap: () {
                                setState(() {
                                  tabController.animateTo(i);
                                });
                              },
                              child: Container(
                                padding: EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(
                                      width: 1,
                                      color: Color(0xffeeeeee),
                                    ),
                                  ),
                                ),
                                child: Text(
                                  brand.name.toUpperCase(),
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
                    .toList()),
          ),
        ),
      ),
      body: TabBarView(
        controller: tabController,
        children: vm.brands
            .map(
              (brand) => Tab(
                    child: CategoryView(
                      footwear: vm.footwear
                          .where((model) => model.brandId == brand.id)
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
      child: CustomScrollView(
        slivers: <Widget>[
          SliverPadding(
            padding: EdgeInsets.only(top: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  HorizontalList(footwear: footwear),
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
                footwear.reversed
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
