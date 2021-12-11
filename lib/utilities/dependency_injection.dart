import 'package:old_change_app/data/repositories/accept_echange_request.dart';
import 'package:old_change_app/data/repositories/accept_refund_seller_repository.dart';
import 'package:old_change_app/data/repositories/accept_request_sell_reponsitory.dart';
import 'package:old_change_app/data/repositories/cancel_exchange_request_repository.dart';
import 'package:old_change_app/data/repositories/cancel_order_detail_reponsitory.dart';
import 'package:old_change_app/data/repositories/categories_reponsitory.dart';
import 'package:old_change_app/data/repositories/check_out_reponsitory.dart';
import 'package:old_change_app/data/repositories/circle_home_repository.dart';
import 'package:old_change_app/data/repositories/circle_one_repository.dart';
import 'package:old_change_app/data/repositories/complain_refund_repository.dart';
import 'package:old_change_app/data/repositories/confirm_purchase_repository.dart';
import 'package:old_change_app/data/repositories/delivery_buttom_repository.dart';
import 'package:old_change_app/data/repositories/delivery_success_repository.dart';
import 'package:old_change_app/data/repositories/disagree_refund_seller_repository.dart';
import 'package:old_change_app/data/repositories/exchang_product_repository.dart';
import 'package:old_change_app/data/repositories/fetch_user_repository.dart';
import 'package:old_change_app/data/repositories/get_list_exchange_repository.dart';
import 'package:old_change_app/data/repositories/join_exchange_repository.dart';
import 'package:old_change_app/data/repositories/load_category_reponsitory.dart';
import 'package:old_change_app/data/repositories/load_delivery_repository.dart';
import 'package:old_change_app/data/repositories/load_feedback_repository.dart';
import 'package:old_change_app/data/repositories/load_image_reponsitory.dart';
import 'package:old_change_app/data/repositories/load_my_product_repository.dart';
import 'package:old_change_app/data/repositories/load_product_detail_repository.dart';
import 'package:old_change_app/data/repositories/load_refund_purchase_repository.dart';
import 'package:old_change_app/data/repositories/load_refund_sell.dart';
import 'package:old_change_app/data/repositories/load_shop_repository.dart';
import 'package:old_change_app/data/repositories/load_trending_repository.dart';
import 'package:old_change_app/data/repositories/login_reponsitory.dart';
import 'package:old_change_app/data/repositories/post_product_reponsitory.dart';
import 'package:old_change_app/data/repositories/post_review_repository.dart';
import 'package:old_change_app/data/repositories/product_list_reponsitory.dart';
import 'package:old_change_app/data/repositories/purchase_order_reponsitory.dart';
import 'package:old_change_app/data/repositories/reject_exchange_repository.dart';
import 'package:old_change_app/data/repositories/send_refund_repository.dart';
import 'package:old_change_app/data/repositories/sign_up_reponsitory.dart';
import 'package:old_change_app/data/repositories/suggest_price_repository.dart';
import 'package:old_change_app/data/repositories/update_status_repository.dart';

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
  PostReviewRepository postReview() => PostReviewRepositoryIml();
  LoadMyProductRepository loadMyProduct() => LoadMyProductRepositoryIml();
  ExchangeProductRepository exchangeProduct() => ExchangeProductRepositoryIml();
  GetExchangeRequestRepository getList() => GetExchangeRequestRepositoryIml();
  CancelExchangeRepositpry cancelExchange() => CancelExchangeRepositpryIml();
  LoadProductDetailRepository loadDetail() => LoadProductDetailRepositoryIml();
  LoadFeedbackRepository loadFeedback() => LoadFeedbackRepositoryIml();
  SendRefundRequestRepository sendRefund() => SendRefundRequestRepositoryIml();
  AcceptExchangeReuqestRepository acceptExchangRequest() =>
      AcceptExchangeReuqestRepositoryIml();
  CircleHomeRepository getCicleHome() => CircleHomeRepositoryIml();
  CircleOneRepository getCircleOne() => CircleOneRepositoryIml();
  joinExchangeRepository joinExchange() => joinExchangeRepositoryIml();
  RejectCircleRepository rejectCircle() => RejectCircleRepositoryIml();
  LoadDeliveryRepository getDelivery() => LoadDeliveryPositoryIml();
  DeliveryButtomRepository delivery() => DeliveryButtomRepositoryIml();
  DeliverySuccessRepository deliverySuccess() => DeliverySuccessRepositoryIml();
  UpdateStatusRepository updateStatus() => UpdateStatusRepositoryIml();
  RefundPurchaseRepository loadRefundP() => RefundPurchaseRepositoryIml();
  ComplainRefundRepository complainRefund() => ComplainRefundRepositoryIml();
  RefundSellRepository loadRefundS() => RefundSellRepositoryIml();
  AcceptRefundSellerRepository acceptRefundSellerRepository() =>
      AcceptRefundSellerRepositoryIml();
  DisagreeRefundRepository disagreeRefund() => DisagreeRefundRepositoryIml();
  LoadShopRepository loadShopRepository() => LoadShopRepositoryIml();
  SuggestPriceRepository suggestPriceRepository() =>
      SuggestPriceRepositoryIml();
  LoadTrendingRepository loadTrendingRepository() =>
      LoadTrendingRepositoryIml();
}
