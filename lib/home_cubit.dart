import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:taskweb/Model/launch_model.dart';
import 'package:taskweb/dio_helper.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());
  static HomeCubit get(context) => BlocProvider.of(context);

  List<Launches> listData = [];

  void getData() async {
    emit(HomeLoading());
    await DioHelper.getData(url: "launches/upcoming").then((value) {
      print(value.data);
      List<dynamic> s =
          value.data.map((job) => Launches.fromJson(job)).toList();
      // list.addAll(s);
      for (var i in s) {
        listData.add(i);
      }

      //    print(value.data);

      emit(HomeSuccess());
    }).catchError((e) {
      print("error");
      print(e.toString());
      emit(HomeError());
    });
  }
}
