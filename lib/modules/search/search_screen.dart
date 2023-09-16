import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/modules/search/cubit/cubit.dart';
import 'package:shop/modules/search/cubit/states.dart';

import '../../shared/component/components.dart';


class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var formKey = GlobalKey<FormState>();

    var searchController = TextEditingController();

    return BlocProvider(
        create: (context) => SearchCubit(),
      child: BlocConsumer<SearchCubit,SearchStates>(
        listener: (context, state){},
        builder: (context, state)
        {
          return Scaffold(
            appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.black),
            ),
            body: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultFormField(
                        controller: searchController,
                        type: TextInputType.text,
                        validate: (String? value)
                        {
                          if(formKey.currentState!.validate())
                          {
                            return 'please write anything';
                          }
                          return null;
                        },
                        label: 'Search',
                        prefIcon: Icons.search,
                      onSubmit: (value)
                      {
                        SearchCubit.get(context).search(value.toString());
                      }
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchLoadingState)
                      const LinearProgressIndicator(),
                    const SizedBox(
                      height: 10,
                    ),
                    if(state is SearchSuccessState)
                      Expanded(
                      child: ListView.separated(
                          itemBuilder: (context, index)=> buildListItem(SearchCubit.get(context).searchModel?.data?.data?[index],context,isOldPrice: false),
                          separatorBuilder: (context, index)=> myDivider(),
                          itemCount:  SearchCubit.get(context).searchModel!.data!.data!.length
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}