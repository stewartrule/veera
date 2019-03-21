import 'package:redux/redux.dart';

import '../models/footwear_category_model.dart';
import '../reducers/root_reducer.dart';

class SettingsViewModel {
  Store<RootState> store;

  SettingsViewModel(this.store);

  static SettingsViewModel fromStore(Store<RootState> store) {
    return SettingsViewModel(store);
  }

  List<FootwearCategoryModel> get footwearCategories {
    return store.state.settings.footwearCategories.values.toList();
  }
}
