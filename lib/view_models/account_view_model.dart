import 'package:redux/redux.dart';

import '../models/address_model.dart';
import '../models/user_model.dart';
import '../reducers/root_reducer.dart';

class AccountViewModel {
  Store<RootState> store;

  AccountViewModel(this.store);

  static AccountViewModel fromStore(Store<RootState> store) {
    return AccountViewModel(store);
  }

  List<AddressModel> get addresses {
    return this.store.state.account.addresses.values.toList();
  }

  UserModel get user {
    return this.store.state.account.user;
  }
}
