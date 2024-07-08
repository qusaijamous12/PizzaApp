import 'package:bloc/bloc.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/state.dart';
import 'package:pizzadelivery/moduels/homescreen/homescreen.dart';
import 'package:pizzadelivery/moduels/login/loginscreen.dart';
import 'package:pizzadelivery/moduels/pizzascreen/pizzaScreen.dart';
import 'package:pizzadelivery/shared/casheHelper/casheHelper.dart';
import 'package:pizzadelivery/shared/observerBloc/blocObserver.dart';

import 'constants/constants.dart';
import 'firebase_options.dart';
import 'moduels/pizzaview/pizzaview.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CasheHelper.init();
  uid=CasheHelper.GetData(key: 'uid');
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Widget ?StartWidget;
  if(uid!=null){
    StartWidget=HomeScreen();

  }
  else if(uid==null){
    StartWidget=LoginScreen();
  }


  runApp( MyApp(widget: StartWidget,));

}

class MyApp extends StatelessWidget{
  @override
  Widget ?widget;
  MyApp({this.widget});

  Widget build(BuildContext context) {
   return MultiBlocProvider(
     providers: [
       BlocProvider(create: (BuildContext context)=>HomeCubit()..GetUserData()..GetPizzaData())
     ],
    child: BlocConsumer<HomeCubit,HomeState>(
    listener: (context,HomeState){


    },
    builder: (context,HomeState){
      return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
       primaryColor: Colors.blue.shade800
    ),
    home: widget,
    );

    },

     ),
   );
  }

}