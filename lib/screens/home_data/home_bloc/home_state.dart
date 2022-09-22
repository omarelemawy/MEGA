

abstract class HomeState {}

class InitialHomeState extends HomeState {}

class GetLoadingHomeState extends HomeState {}
class GetSuccessHomeState extends HomeState {}
class GetErrorHomeState extends HomeState {
  GetErrorHomeState(this.error);
  String error;
}
class GetLoadingProductState extends HomeState {}
class GetSuccessProductState extends HomeState {}
class GetErrorProductState extends HomeState {
  GetErrorProductState(this.error);
  String error;
}



class GetLoadingProductDetailsState extends HomeState {}
class GetSuccessProductDetailsState extends HomeState {}
class GetErrorProductDetailsState extends HomeState {
  GetErrorProductDetailsState(this.error);
  String error;
}

class GetLoadingProductDetailsRelatedDetailsState extends HomeState {}
class GetSuccessProductDetailsRelatedDetailsState extends HomeState {}
class GetErrorProductDetailsRelatedDetailsState extends HomeState {
  GetErrorProductDetailsRelatedDetailsState(this.error);
  String error;
}

class GetLoadingProductReviewDetailsState extends HomeState {}
class GetSuccessProductReviewDetailsState extends HomeState {}
class GetErrorProductReviewDetailsState extends HomeState {
  GetErrorProductReviewDetailsState(this.error);
  String error;
}


class AddToFavProductState extends HomeState {}
class RemoveToFavProductState extends HomeState {}

class AddToCartLoadingProductDetailsState extends HomeState {}
class AddToCartSuccessProductDetailsState extends HomeState {}
class AddToCartErrorProductDetailsState extends HomeState {
  AddToCartErrorProductDetailsState(this.error);
  String error;
}

class GetLoadingProductsOfferHomeState extends HomeState {}
class GetSuccessProductsOfferHomeState extends HomeState {}
class GetErrorProductsOfferHomeState extends HomeState {
  GetErrorProductsOfferHomeState(this.error);
  String error;
}
class GetLoadingYouMayLikeHomeHomeState extends HomeState {}
class GetSuccessYouMayLikeHomeHomeState extends HomeState {}
class GetErrorYouMayLikeHomeHomeState extends HomeState {
  GetErrorYouMayLikeHomeHomeState(this.error);
  String error;
}

class GetDatabaseState extends HomeState {}
class InsertDatabaseState extends HomeState {}
class DeleteDataBaseState extends HomeState {}


class GetLoadingCartDateHomeState extends HomeState {}
class GetSuccessCartDateHomeState extends HomeState {}
class GetErrorCartDateHomeState extends HomeState {
  GetErrorCartDateHomeState(this.error);
  String error;
}