import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/layout/shop_layout.dart';

import '../../shared/component/components.dart';

class FavoriteScreen extends StatelessWidget {
   const FavoriteScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return  BlocConsumer<ShopAppCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){

        // ShopAppCubit.get(context).getFavoritesData();

        return ConditionalBuilder(
            condition: state is! ShopLoadingGetFavoritesState,
           builder: (context)=> ListView.separated(
               itemBuilder: (context, index)=> buildListItem(ShopAppCubit.get(context).favoritesModel?.data?.data?[index].product,context),
               separatorBuilder: (context, index)=> myDivider(),
               itemCount:  ShopAppCubit.get(context).favoritesModel!.data!.data!.length
           ),
          fallback: (context)=> const Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}