import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop/models/search/search_model.dart';
import 'package:shop/modules/search/cubit/states.dart';
import 'package:shop/shared/network/end_points.dart';
import 'package:shop/shared/network/remote/dio.dart';

import '../../../shared/constants/constatnts.dart';

class SearchCubit extends Cubit<SearchStates>
{
  SearchCubit() : super(SearchInitialState());

  static SearchCubit get(context) => BlocProvider.of(context);

  SearchModel? searchModel;

  void search(String text)
  {

    emit(SearchLoadingState());


    DioHelper.postData(
        url: SEARCH,
        data:
        {
          'text' : text
        },
        token: token
    ).then((value){
        searchModel = SearchModel.fromJson(value.data);


        emit(SearchSuccessState());
    }
    ).catchError((error){

      print(error.toString());
      emit(SearchErrorState());
    });
  }
}