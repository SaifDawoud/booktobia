part of 'search_cubit.dart';

sealed class SearchCubitState extends Equatable {
  const SearchCubitState();

  @override
  List<Object> get props => [];
}

final class SearchCubitInitial extends SearchCubitState {}

class FeaturedBooksSearchSuccess extends SearchCubitState {
  final List<BookModel> filterdBooks;

  const FeaturedBooksSearchSuccess(this.filterdBooks);
}

class FeaturedBooksSearchFailure extends SearchCubitState {
  final String errMessage;
  const FeaturedBooksSearchFailure(this.errMessage);
}
