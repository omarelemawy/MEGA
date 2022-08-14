abstract class OfferState {}

class InitialOfferState extends OfferState {}

class GetLoadingProductsOfferState extends OfferState {}
class GetSuccessProductsOfferState extends OfferState {}
class GetErrorProductsOfferState extends OfferState {
  GetErrorProductsOfferState(this.error);
  String error;
}

