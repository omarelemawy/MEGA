abstract class ExploreState {}

class InitialExploreState extends ExploreState {}

class GetLoadingExploreState extends ExploreState {}
class GetSuccessExploreState extends ExploreState {}
class GetErrorExploreState extends ExploreState {
  GetErrorExploreState(this.error);
  String error;
}


