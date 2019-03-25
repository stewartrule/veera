import 'package:flutter/material.dart';
import '../models/brand_model.dart';
import '../models/footwear_model.dart';
import '../models/footwear_category_model.dart';
import 'package:flutter_redux/flutter_redux.dart';

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
          return DefaultTabController(
            length: vm.brands.length,
            child: Scaffold(
              appBar: AppBar(
                elevation: 0,
                iconTheme: IconThemeData(color: Colors.red),
                backgroundColor: Colors.white,
                bottom: TabBar(
                  indicatorColor: Colors.black,
                  indicatorWeight: 1,
                  isScrollable: true,
                  tabs: vm.brands
                      .map(
                        (brand) => Tab(
                              child: Text(
                                brand.name.toUpperCase(),
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                      )
                      .toList(),
                ),
                title: Text(
                  category.name,
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              body: TabBarView(
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
            ),
          );
        },
      ),
    );
  }
}

class CategoryView extends StatelessWidget {
  final List<FootwearModel> footwear;

  CategoryView({Key key, this.footwear}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(8),
      child: GridView.count(
        physics: ScrollPhysics(),
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        childAspectRatio: 0.5,
        crossAxisSpacing: 8,
        padding: EdgeInsets.all(8),
        children:
            footwear.map((product) => FootwearItem(product: product)).toList(),
      ),
    );
  }
}
