

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/layout/cubit/cubit.dart';
import 'package:shop/modules/search/search_screen.dart';
import 'package:shop/modules/login/login.dart';
import 'package:shop/shared/component/components.dart';
import 'package:shop/shared/network/remote/cach_helper.dart';

import 'cubit/states.dart';

class ShopLayout extends StatelessWidget {
  

  @override
  Widget build(BuildContext context)
  {
    var cubit = ShopAppCubit.get(context);
    
    return BlocConsumer<ShopAppCubit, ShopLayoutStates>(
      listener: (context, state){},
      builder: (context, state){
        return Scaffold(
          appBar: AppBar(
            title:  Text(
                "Salla"
            ),
            actions:  [
              IconButton(
                  onPressed: () {
                    navigateTo(context,  SearchScreen());
                  },
                  icon:  Icon(Icons.search)
              )
            ],
          ),
          body: cubit.Screens[cubit.currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (int index)
            {
              cubit.changeBottomNavBar(index);
            },
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(icon: Icon(Icons.apps), label: 'Categories'),
              BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorites'),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
            ],
          ),
        );
      },
    );
  }
  //var cubit = ShopAppCubit.get(context);
  }

