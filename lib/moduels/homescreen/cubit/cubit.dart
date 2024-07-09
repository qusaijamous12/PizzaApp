
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
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
    pizza=[];
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

  bool isCheck=false;
  void ChangeIsCheck(value){
    isCheck=!isCheck;
    emit(ChangeIsCheckState());


  }

  int ?isSpicy;
  void ChangeIsSpicy(int x){
    if(x==1) {
      isSpicy = 1;
      print(isSpicy);

      emit(ChangeIsSpicyState());
    }
    else if(x==2) {
      isSpicy = 2;
      print(isSpicy);

      emit(ChangeIsSpicyState());


    }
    else {
      isSpicy = 3;
      print(isSpicy);
      emit(ChangeIsSpicyState());

    }

  }

  File ?pizzaImage;
  var imagePicker=ImagePicker();

  Future<void> selectImage()async{
    final picker=await imagePicker!.pickImage(source: ImageSource.gallery);
    if(picker!=null){
      pizzaImage=File(picker.path);
      emit(selectImageSuccess());
    }
    else
      {
        print('no image is selected');
        emit(selectImageError());
      }

  }

  void UploadPizzaImage({
    required String name,
    required String descrption,
    required dynamic price,
    dynamic discont,
    required bool IsVeg,
    required dynamic IsSpicy,
    required Map<String,dynamic> macros
}){
    FirebaseStorage.instance.ref().child('pizza/${Uri.file(pizzaImage!.path).pathSegments.last}').putFile(pizzaImage!).then((p0) {
        p0.ref.getDownloadURL().then((value) {
          emit(UploadPizzaImageSuccessState());
          PizaaModel pizaaModel=PizaaModel(
            name:name,
            description: descrption,
            price: price,
            discount: discont,
            isVeg: IsVeg,
            spicy: IsSpicy,
            picture: value,
            macros:Macros.fromJson(macros)

          );
          FirebaseFirestore.instance.collection('pizza').add(pizaaModel.toMap()).then((value) {
            emit(AddPizzaSuccessState());


          }).catchError((error){
            print(error.toString());
            emit(AddPizzaErrorState());
          });
          

        }).catchError((error){
          emit(UploadPizzaImageErrorState());


        });

    }).catchError((error){
      print(error.toString());
      emit(UploadPizzaImageErrorState());

    });
  }

  
}