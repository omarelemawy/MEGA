part of 'review_cubit.dart';

abstract class ReviewState {}

class ReviewInitial extends ReviewState {}

class GetLoadingProductReviewState extends ReviewState {}
class GetSuccessProductReviewState extends ReviewState {}
class GetErrorProductReviewState extends ReviewState {
  GetErrorProductReviewState(this.error);
  String error;
}