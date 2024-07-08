
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/model/loginModel.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/state.dart';

import '../../../constants/constants.dart';
import '../../../model/pizzaModel/pizzaModelInfo.dart';

class HomeCubit extends Cubit<HomeState>{
  HomeCubit():super(InitialHomeState());
  
  static HomeCubit get(context)=>BlocProvider.of(context);
  
  LoginModel ?loginModel;
  
  void GetUserData(){
    FirebaseFirestore.instance.collection('users').doc(uid).get().then((value){
      loginModel=LoginModel.fromJosn(value.data()!);
      print(loginModel!.name);
      emit(GetDataUserSuccessState());

    }).catchError((error){
      print(error.toString());
      emit(GetDataUserErrorState());

    });
  }

  List<PizaaModel> pizza=[];
  
  void GetPizzaData(){
    FirebaseFirestore.instance.collection('pizza').get().then((value) {
      value.docs.forEach((element) {
        pizza.add(PizaaModel.fromJosn(element.data()));
        emit(GetDataPizzaSuccessState());
      });
      print(pizza[0].macros!.calories);

    }).catchError((error){
      print(error.toString());
      emit(GetDataPizzaErrorState());

    });
  }
}