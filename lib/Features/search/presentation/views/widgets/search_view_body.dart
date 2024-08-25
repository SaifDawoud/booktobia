import 'package:booktobia/Features/home/presentation/manger/featured_books_cubit/featured_books_cubit.dart';
import 'package:booktobia/Features/home/presentation/views/widgets/custom_book_item.dart';
import 'package:booktobia/core/widgets/custom_error_widget.dart';
import 'package:booktobia/core/widgets/custom_loading_indicator.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../home/presentation/manger/search_cubit/search_cubit.dart';
import 'custom_search_text_field.dart';

class SearchViewBody extends StatelessWidget {
  const SearchViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SearchCubit, SearchCubitState>(
        builder: (context, state) {
      if (state is FeaturedBooksSearchSuccess) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                onChanged: (val) {
                  context.read<SearchCubit>().searchFeaturedBooks(val);
                },
                decoration: InputDecoration(
                  enabledBorder: buildOutlineInputBorder(),
                  focusedBorder: buildOutlineInputBorder(),
                  hintText: 'Search',
                  suffixIcon: IconButton(
                    onPressed: () {},
                    icon: const Opacity(
                      opacity: .8,
                      child: Icon(
                        FontAwesomeIcons.magnifyingGlass,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              const Text(
                'Search Result',
                style: Styles.textStyle18,
              ),
              const SizedBox(
                height: 16,
              ),
              Expanded(
                  flex: 1,
                  child: ListView.builder(
                    itemCount: state.filterdBooks.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CachedNetworkImage(
                          width: 50,
                          height: 200,
                          fit: BoxFit.fitHeight,
                          imageUrl: state.filterdBooks[index].volumeInfo
                              .imageLinks!.thumbnail,
                        ),
                      );
                    },
                  )),
            ],
          ),
        );
      } else if (state is FeaturedBooksSearchFailure) {
        return CustomErrorWidget(errMessage: state.errMessage);
      } else {
        return const CustomLoadingIndicator();
      }
    });
  }

  OutlineInputBorder buildOutlineInputBorder() {
    return OutlineInputBorder(
      borderSide: const BorderSide(
        color: Colors.white,
      ),
      borderRadius: BorderRadius.circular(
        12,
      ),
    );
  }
}
