

class Utils {

  static const BASE_URL = "https://megamatgr.com/wp-json";
  static const BASEData_URL = "consumer_key=ck_7b06588bcc97aea8ffd7025d81d468f7abd902a6&consumer_secret=cs_e792875f045471bbcbb999d8d841d37842ef3c5b";

  // ignore: non_constant_identifier_names
  static const GetToken_URL =BASE_URL + "/jwt-auth/v1/token";
  // ignore: non_constant_identifier_names
  static final REGISTER_URL = "$BASE_URL/wp/v2/users";
  static final LOGIN_URL = "$BASE_URL/jwt-auth/v1/token";

  static final GetData_URL = "$BASE_URL/wp/v2/users/me";

  static final GetMOreData_URL = "https://megamatgr.com/api/users/get_userdata";


  static final Forgot_Pass_URL = "https://megamatgr.com/api/forgot_password.php?login=";



  static const Category_URL = "$BASE_URL/wc/v3/products/categories";
  static const CategoryProduct_URL = "$BASE_URL/wc/v3/products";

  static const ProductDetails_URL = "$BASE_URL/wc/v3/products";

  static const ProductReview_URL = "$BASE_URL/wc/v3/products/reviews";

  static final GetPrivacyData_URL = "$BASE_URL/wp/v2/pages";


  static const CreateOrders_URL = "$BASE_URL/user/orders/create";


  static const OrdersList_URL = "$BASE_URL/wc/v3/orders";



  static const SubmitReview_URL = "$BASE_URL/wc/v3/products/reviews";

  static const GETMYPROFILE_URL = "$BASE_URL/user/my-profile";

  static const UPDATEMYPROFILE_URL = "$BASE_URL/wp/v2/users/me";

  static const DeleteMYPROFILE_URL = "$BASE_URL/user/delete";




  static const Settings_URL = "https://megamatgr.xyz/api/settings";
  static const AddToFAv_URL = "$BASE_URL/user/favouritelist/";
  static const GETFAVList_URL = "$BASE_URL/user/favouritelist";
  static const RemoveFAV_URL = "$BASE_URL/user/favouritelist/";
  static const CategoryCountries_URL = "$BASE_URL/countries";

  static const SubmitCheckOut_URL = "$BASE_URL/wc/store/v1/checkout";

  static const UpdateAddress_URL = "$BASE_URL/user/address/";

  static const GetAddressList_URL = "$BASE_URL/user/address";

  static const AddTocart_URL = "$BASE_URL/wc/store/v1/cart/add-item";

  static const Ubdatecart_URL = "$BASE_URL/wc/store/v1/cart/update-item";

  static const DELETEADDREES_URL = "$BASE_URL/user/address/";
  static const CartDetails_URL = "$BASE_URL/wc/store/v1/cart";
  static const ChangeQuantity_URL = "$BASE_URL/user/orders/changeQuantity";

  static const RemoveFromCart_URL = "$BASE_URL/wc/store/v1/cart/items/";

  static const RemoveItemFromCart_URL = "$BASE_URL/wp-json/wc/store/v1";

  static const CheckCupounCart_URL = "$BASE_URL/wc/store/v1/cart/apply-coupon";

  static const Notifications_URL = "$BASE_URL/user/notifications";



  static final Rate_course_URL = Uri.parse(BASE_URL + "/rate_course");
// ignore: non_constant_identifier_names
  static final Checkout_URL = Uri.parse(BASE_URL + "/orders/checkout");
  // ignore: non_constant_identifier_names
  static final QuizAnssers_URL = Uri.parse(BASE_URL + "/tests");
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  static final GITUSERDATA_URL = Uri.parse(BASE_URL + "/clients/profile");
  // ignore: non_constant_identifier_names
  static final UPDATEUSERDATA_URL = Uri.parse(BASE_URL + "/clients/update");
  // ignore: non_constant_identifier_names
  static final HOME_URL = Uri.parse(BASE_URL + "/home");
  // ignore: non_constant_identifier_names
  static final Categories_URL = Uri.parse(BASE_URL + "/categories");
  // ignore: non_constant_identifier_names
  static final GOOGLE_URL = Uri.parse(BASE_URL + "/social/google");
  // ignore: non_constant_identifier_names

  // ignore: non_constant_identifier_names
  static final APPLE_URL = Uri.parse(BASE_URL + "/social/apple");

  // ignore: non_constant_identifier_names
  static final FACEBOOK_URL = Uri.parse(BASE_URL + "/social/facebook");
  // ignore: non_constant_identifier_names
  static final HOMESearch_URL = Uri.parse(BASE_URL + "/search");
  // ignore: non_constant_identifier_names
  static final Instructors_URL = Uri.parse(BASE_URL + "/instructors");
  // ignore: non_constant_identifier_names
  static final MyCourses_URL = Uri.parse(BASE_URL + "/clients/mycourses");
  // ignore: non_constant_identifier_names
  static final MyWishList_URL = Uri.parse(BASE_URL + "/wish_list");
  // ignore: non_constant_identifier_names
  static final SendForgetCode_URL =
      Uri.parse(BASE_URL + "/clients/send_forget_code");
  // ignore: non_constant_identifier_names
  static final CheckForgetCode_URL =
      Uri.parse(BASE_URL + "/clients/check_forget_code");
  // ignore: non_constant_identifier_names
  static final ResetForgetPassword_URL =
      Uri.parse(BASE_URL + "/clients/reset_password_after_forget");
  // ignore: non_constant_identifier_names
  static final AboutUS_URL = Uri.parse(BASE_URL + "/setting/about");
}
