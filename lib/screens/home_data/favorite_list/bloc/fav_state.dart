abstract class FavState {}

class InitialFavState extends FavState {}

class GetLoadingFavState extends FavState {}
class GetSuccessFavState extends FavState {}
class GetErrorFavState extends FavState {
  GetErrorFavState(this.error);
  String error;
}