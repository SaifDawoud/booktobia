import 'package:booktobia/Features/home/data/models/book_model/book_model.dart';
import 'package:booktobia/Features/home/data/repos/home_repo.dart';
import 'package:booktobia/core/utils/api_service.dart';
import 'package:dartz/dartz.dart';
import 'package:booktobia/core/errors/failures.dart';
import 'package:dio/dio.dart';

class HomeRepoImpl implements HomeRepo {
  final ApiService apiService;
  List<BookModel> newstBooks = [];
  List<BookModel> featuredBooks = [];
  List<BookModel> similrBooks = [];
  List<BookModel> filterdBooks = [];
  HomeRepoImpl(this.apiService);
  @override
  Future<Either<Failure, List<BookModel>>> fetchNewsetBooks() async {
    try {
      var data = await apiService.get(
          endPoint:
              'volumes?Filtering=free-ebooks&Sorting=newest &q=computer science');

      for (var item in data['items']) {
        try {
          newstBooks.add(BookModel.fromJson(item));
        } catch (e) {
          newstBooks.add(BookModel.fromJson(item));
        }
      }

      return right(newstBooks);
    } catch (e) {
      if (e is DioError) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchFeaturedBooks() async {
    try {
      var data = await apiService.get(
          endPoint: 'volumes?Filtering=free-ebooks&q=subject:Programming');

      for (var item in data['items']) {
        featuredBooks.add(BookModel.fromJson(item));
      }

      return right(featuredBooks);
    } catch (e) {
      if (e is DioError) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> fetchSimilarBooks(
      {required String category}) async {
    try {
      var data = await apiService.get(
          endPoint:
              'volumes?Filtering=free-ebooks&Sorting=relevance &q=subject:Programming');

      for (var item in data['items']) {
        similrBooks.add(BookModel.fromJson(item));
      }

      return right(similrBooks);
    } catch (e) {
      if (e is DioError) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }

  @override
  Future<Either<Failure, List<BookModel>>> searchBooks(
      {required String query}) async {
    try {
      if (query.isEmpty) {
        filterdBooks = featuredBooks;
        return right(filterdBooks);
      } else {
        filterdBooks = featuredBooks
            .where((item) => item.volumeInfo.title!
                .toLowerCase()
                .contains(query.toLowerCase()))
            .toList();

        return right(filterdBooks);
      }
    } catch (e) {
      if (e is DioError) {
        return left(
          ServerFailure.fromDioError(e),
        );
      }
      return left(
        ServerFailure(
          e.toString(),
        ),
      );
    }
  }
}
