abstract class FavState {}

class InitialFavState extends FavState {}

class GetLoadingFavoriteProductState extends FavState {}
class GetSuccessFavoriteProductState extends FavState {}
class GetErrorFavoriteProductState extends FavState {
  GetErrorFavoriteProductState(this.error);
  String error;
}

class CreateDatabaseState extends FavState {}

class GetDatabaseState extends FavState {}

class InsertDatabaseState extends FavState {}

class UbDateDataBaseState extends FavState {}

class DeleteDataBaseState extends FavState {}