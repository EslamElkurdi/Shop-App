

import 'package:carousel_slider/carousel_slider.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/layout/cubit/states.dart';
import 'package:shop/models/home/home.dart';
import 'package:shop/shared/component/components.dart';

import '../../models/categories/categories_model.dart';
import '../../shared/styles/colors.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopAppCubit, ShopLayoutStates>(
      listener: (context, state)
      {
        if(state is ShopFavoritesSuccessState){
          if(state.changeFavoritesModel?.status == false){
            showToast(state.changeFavoritesModel?.message);
          }

        }
      },
      builder: (context, state){
        return ConditionalBuilder(
            condition: ShopAppCubit.get(context).homeModel != null && ShopAppCubit.get(context).dataModel != null,
            builder: (context)=> productBuilder(ShopAppCubit.get(context).homeModel,ShopAppCubit.get(context).dataModel,context),
            fallback: (context)=> const Center(child: CircularProgressIndicator())
        );
      },
    );
  }

  Widget productBuilder(HomeModel? model,CategoryDataModel? categoryDataModel,context)
  {
    if (model == null  && categoryDataModel == null) {
      // Handle the case when the model is null
      return const Center(child: CircularProgressIndicator());
    }

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CarouselSlider(
              items: model?.data.banners.map((e) => Image(
                  image: NetworkImage(e.image)
              )).toList(),
              options: CarouselOptions(
                height: 250.0,
                initialPage: 0,
                viewportFraction: 1.0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayAnimationDuration: const Duration(seconds: 1),
                autoPlayInterval: const Duration(seconds: 3),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
              )
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 15.0,
                ),
                Text(
                  "Categories",
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w800
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.separated(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => buildCategories(categoryDataModel.data?.items[index]),
                      separatorBuilder:  (context, index) => const SizedBox(
                        width: 10,
                      ),
                      itemCount: categoryDataModel!.data!.items.length
                  ),
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Text(
                  "New Products",
                  style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800
                  ),
                ),
              ],
            ),
          ),

          Container(
            color: Colors.grey[300],
            child: GridView.count(
              shrinkWrap: true,
              physics:  const NeverScrollableScrollPhysics(),
              crossAxisCount: 2,
              mainAxisSpacing: 1.0,
              crossAxisSpacing: 10.0,
              childAspectRatio: 1 / 1.7,
              children: List.generate(model!.data.products.length,
                      (index) => buildGridProduct(model.data.products[index], context)
              ),
            ),
          ),
        ],
      ),
    );
  }


  Widget buildGridProduct(ProductsModel model, context) => Container(
    color: Colors.white,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Stack(

            alignment: AlignmentDirectional.bottomStart,
            children: [
              Image(
                image: NetworkImage(model.image),
                width: double.infinity,
                height: 200.0,
                // fit: BoxFit.cover,
              ),
              if(model.discount != 0)
                Container(
                  color: Colors.red,
                  padding: EdgeInsets.all( 3.0),
                  child: const Text(
                    'DISCOUNT',
                    style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.white
                    ),
                  ),
                ),
            ]
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              Text(
                '${model.name}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '${model.price.round()}',
                    style: const TextStyle(
                        fontSize: 14.0,
                        height: 1.3,
                        color: defaultColor
                    ),
                  ),
                  const SizedBox(
                    width: 5.0,
                  ),
                  if(model.discount != 0)
                    Text(
                      '${model.oldPrice.round()}',
                      style: const TextStyle(
                          fontSize: 14.0,
                          height: 1.3,
                          color: Colors.grey,
                          decoration: TextDecoration.lineThrough
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                      padding: EdgeInsets.zero,
                      onPressed: ()
                      {
                         ShopAppCubit.get(context).changeFavorites(model.id);
                      },
                      icon: CircleAvatar(
                        radius: 15.0,
                         backgroundColor: ShopAppCubit.get(context).favorites[model.id] == true ? defaultColor : Colors.grey,
                        child: Icon(
                          Icons.favorite_border,
                          size: 14.0,
                        ),
                      )
                  )
                ],
              ),
            ],
          ),
        )
      ],
    ),
  );

  Widget buildCategories(CategoryItem? categoryItem) =>  Stack(
    alignment: Alignment.bottomCenter,
    children: [
      Image(
          height: 100,
          width: 100,
          fit: BoxFit.cover,
          image: NetworkImage(categoryItem!.image)

      ),
      Container(
        alignment: Alignment.center,
        color: Colors.black.withOpacity(0.8),
        width: 100,
        height: 26,
        // height: 100,
        child: Text(
          textAlign: TextAlign.center,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "${categoryItem.name}",
          style: TextStyle(
              fontSize: 17,
              color: Colors.white,

          ),
        ),
      )

    ],
  );
}