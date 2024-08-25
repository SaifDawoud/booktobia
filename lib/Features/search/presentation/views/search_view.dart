import 'package:booktobia/Features/home/data/repos/home_repo_impl.dart';
import 'package:booktobia/Features/home/presentation/manger/search_cubit/search_cubit.dart';
import 'package:booktobia/Features/search/presentation/views/widgets/search_view_body.dart';
import 'package:booktobia/core/utils/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<SearchCubit>(
      create: (context) => SearchCubit(getIt.get<HomeRepoImpl>())..searchFeaturedBooks(""),
      child: const Scaffold(
        body: SafeArea(
          child: SearchViewBody(),
        ),
      ),
    );
  }
}
