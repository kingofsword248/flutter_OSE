import 'package:old_change_app/data/repositories/check_out_reponsitory.dart';
import 'package:old_change_app/data/repositories/login_reponsitory.dart';
import 'package:old_change_app/data/repositories/product_list_reponsitory.dart';

class Injector {
  static final Injector _singleton = new Injector._internal();

  factory Injector() {
    return _singleton;
  }
  Injector._internal();
  LoginRepository signInReponsitory() => LoginRepositoryIml();
  ProductListReponsitory getProductListReponsitory() =>
      ProductListReponsitoryIml();
  CheckOutRepository checkOutRepository() => CheckOutRepositoryIml();
}
