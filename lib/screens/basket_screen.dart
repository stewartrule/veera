import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

import '../reducers/root_reducer.dart';
import '../selectors/selectors.dart';
import '../view_models/basket_item_view_model.dart';
import '../widgets/color_checkbox.dart';
import '../widgets/cover_image.dart';
import '../widgets/size_select.dart';

class BasketScreen extends StatelessWidget {
  BasketScreen({Key key, this.title}) : super(key: key);

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
      body: StoreConnector<RootState, List<BasketItemViewModel>>(
        converter: (Store<RootState> store) {
          return store.state.basket.items
              .map(
                (item) => BasketItemViewModel.fromStore(
                    store,
                    getFootwearById(
                      store.state,
                      item.variant.footwearId,
                    )),
              )
              .toList();
        },
        builder: (BuildContext context, List<BasketItemViewModel> vms) {
          return Container(
            color: Colors.white,
            child: CustomScrollView(
              slivers: <Widget>[
                SliverPadding(
                  padding: EdgeInsets.all(16),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate(
                      vms
                          .map(
                            (vm) => Padding(
                                  padding: EdgeInsets.symmetric(vertical: 8),
                                  child: BasketItem(
                                    vm: vm,
                                  ),
                                ),
                          )
                          .toList(),
                    ),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}

class BasketItem extends StatelessWidget {
  final BasketItemViewModel vm;

  const BasketItem({
    Key key,
    this.vm,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Container(
          width: 24,
          height: 24,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: Color(0xffcccccc),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        SizedBox(
          width: 16,
        ),
        CoverImage(
          image: vm.product.image,
          width: 112,
          height: 176,
        ),
        SizedBox(
          width: 16,
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                vm.product.name.toUpperCase(),
                textAlign: TextAlign.left,
              ),
              Padding(
                padding: EdgeInsets.only(top: 16),
                child: Row(
                  children: vm.colors
                      .map(
                        (color) => ColorCheckbox(
                              product: vm.product,
                              color: color,
                              vm: vm,
                            ),
                      )
                      .toList(),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(0, 16, 0, 8),
                child: SizeSelect(
                  product: vm.product,
                  vm: vm,
                ),
              ),
              Text(
                "\$${vm.product.price / 100}",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
