import 'package:old_change_app/data/repositories/accept_request_sell_reponsitory.dart';
import 'package:old_change_app/data/repositories/cancel_order_detail_reponsitory.dart';
import 'package:old_change_app/data/repositories/categories_reponsitory.dart';
import 'package:old_change_app/data/repositories/check_out_reponsitory.dart';
import 'package:old_change_app/data/repositories/confirm_purchase_repository.dart';
import 'package:old_change_app/data/repositories/fetch_user_repository.dart';
import 'package:old_change_app/data/repositories/load_category_reponsitory.dart';
import 'package:old_change_app/data/repositories/load_image_reponsitory.dart';
import 'package:old_change_app/data/repositories/login_reponsitory.dart';
import 'package:old_change_app/data/repositories/post_product_reponsitory.dart';
import 'package:old_change_app/data/repositories/product_list_reponsitory.dart';
import 'package:old_change_app/data/repositories/purchase_order_reponsitory.dart';
import 'package:old_change_app/data/repositories/sign_up_reponsitory.dart';

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
  CategoriesRepository getCategories() => CategoriesRepositoryIml();
  LoadImageRepository getImagePaths() => LoadImageRepositoryIml();
  PostProductRepository postProduct() => PostProductRepositoryIml();
  PurchaseOrderRepository getPurchaseList() => PurchaseOrderRepositoryIml();
  SignUpRepository signUp() => SignUpRepositoryIml();
  AcceptReuqestRepository acceptRequest() => AcceptReuqestRepositoryIml();
  CancelOrderDetailRepository cancelOrderDetail() =>
      CancelOrderDetailRepositoryIml();
  LoadCategoryRepository loadCategory() => LoadCategoryRepositoryIml();
  ConfirmPurchaseRepository confirmPurchase() => ConfirmPurchaseRepositoryIml();
  FetchUserRepositoty fetchUser() => FetchUserRepositotyIml();
}
