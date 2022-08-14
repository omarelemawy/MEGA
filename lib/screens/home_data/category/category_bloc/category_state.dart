

abstract class CategoryState {}

class InitialCategoryState extends CategoryState {}

class GetLoadingCategoryState extends CategoryState {}
class GetSuccessCategoryState extends CategoryState {}
class GetErrorCategoryState extends CategoryState {
  GetErrorCategoryState(this.error);
  String error;
}
class GetLoadingProductCategoryState extends CategoryState {}
class GetSuccessProductCategoryState extends CategoryState {}
class GetErrorProductCategoryState extends CategoryState {
  GetErrorProductCategoryState(this.error);
  String error;
}


