import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/login/cubit/state.dart';
import 'package:pizzadelivery/shared/casheHelper/casheHelper.dart';

import '../../../constants/constants.dart';

class LoginCubit extends Cubit<LoginState>{

  LoginCubit():super(InitialLoginState());

  static LoginCubit get(context)=>BlocProvider.of(context);

  bool IsObsecuer=true;
  IconData icon_visable=Icons.visibility_off;

  void ChangeIcon(){
    if(IsObsecuer)
      {
        icon_visable=Icons.visibility;
        IsObsecuer=false;
        emit(ChangeIconSuccessState());

      }
    else
      {
        icon_visable=Icons.visibility_off;
        IsObsecuer=true;
        emit(ChangeIconSuccessState());
      }

  }


  void SignIn(context,{
    required String email,
    required String password
}){
    emit(LoadingSignInState());
    FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password).then((value) {
          print(value.user!.uid);
          CasheHelper.SaveData(value: value.user!.uid, key: 'uid');
          uid=CasheHelper.GetData(key: 'uid');
          HomeCubit.get(context).GetUserData();
          HomeCubit.get(context).GetPizzaData();

          emit(SignInSuccess());

    }).catchError((error){
      print(error.toString());
      emit(SignInError());

    });

  }




}