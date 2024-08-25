import 'package:bloc/bloc.dart';
import 'package:booktobia/Features/home/data/models/book_model/book_model.dart';
import 'package:booktobia/Features/home/data/repos/home_repo.dart';
import 'package:equatable/equatable.dart';

part 'search_cubit_state.dart';

class SearchCubit extends Cubit<SearchCubitState> {
  SearchCubit(this.homeRepo) : super(SearchCubitInitial());

  final HomeRepo homeRepo;

  
Future<void> searchFeaturedBooks( String query) async {
  emit(SearchCubitInitial());
    var result = await homeRepo.searchBooks(query:query );
    result.fold((failure) {
      emit(FeaturedBooksSearchFailure(failure.errMessage));
    }, (books) {
      emit(FeaturedBooksSearchSuccess(books));
    });
  }

}
