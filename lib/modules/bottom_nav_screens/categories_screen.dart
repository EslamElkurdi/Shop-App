import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/shared/component/components.dart';

import '../../layout/cubit/states.dart';
import '../../models/categories/categories_model.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return ListView.separated(
            itemBuilder: (context, index)=> categoryBuilder(ShopAppCubit.get(context).dataModel?.data?.items[index]),
            separatorBuilder: (context, index)=> myDivider(),
            itemCount:  ShopAppCubit.get(context).dataModel!.data!.items.length
        );
      },
    );
  }


  Widget categoryBuilder( CategoryItem? categoryItem)=> Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children:
      [
        Image(

            width: 80,
            height: 80,
            image: NetworkImage(categoryItem!.image)),
        SizedBox(
          width: 20,
        ),
        Text(
          '${categoryItem.name}',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold
          ),
        ),
        Spacer(),
        Icon(
            Icons.arrow_forward_ios_sharp
        )
      ],
    ),
  );
}
