import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/model/loginModel.dart';
import 'package:pizzadelivery/moduels/register/cubit/state.dart';

class RegisterCubit extends Cubit<RegisterState>{
  RegisterCubit():super(InitialRegisterState());

  static RegisterCubit get(context)=>BlocProvider.of(context);

  void CreateAccountAuth({
    required String email,
    required String password,
    required String name,
    required String phone
}){
    emit(LoadinCreateAccountState());
    FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password).then((value) {


          CreateUserFireStore(
              uid: value.user!.uid,
              email: email,
              name: name,
              phone: phone);

    }).catchError((error){
      print(error.toString());
      emit(CreateAccountErrorState());
    });

  }

  void CreateUserFireStore({
    required String uid,
    required String email,
    required String name,
    required String phone
}){
    LoginModel model=LoginModel(
      uid: uid,
      name: name,
      phone: phone,
      email: email
    );
    FirebaseFirestore.instance.collection('users').doc(uid).set(model.toMap()).then((value){
      emit(CreateAccountFireStoreSuccessState());
      emit(CreateAccountSuccessState());


    }).catchError((error){
      print(error.toString());
      emit(CreateAccountFireStoreErrorState());

    });

  }
}