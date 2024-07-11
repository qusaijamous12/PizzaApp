import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzadelivery/constants/constants.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/state.dart';

import '../../model/pizzaModel/pizzaModelInfo.dart';

class DeletePizza extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,HomeState){

      },
      builder: (context,HomeState){
        var cubit=HomeCubit.get(context).pizza;
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            leading: IconButton(
              onPressed: (){
                Navigatepop(context);
              },
              icon: Icon(
                Icons.navigate_before_outlined,
                color: Colors.black,
              ),
            ),
          ),
          body: ConditionalBuilder(
              condition: cubit.length>0,
              builder: (context)=>SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            itemBuilder: (context,index)=>BuildDeletePizzaItem(context,cubit[index]),
                            separatorBuilder: (context,index)=>SizedBox(
                              height: 10,
                            ),
                            itemCount: cubit.length),
                      )
                    ],
                  ),
                ),
              ),
              fallback: (context)=>Center(child: CircularProgressIndicator())),
        );
      },

    );
  }
  Widget BuildDeletePizzaItem(context,PizaaModel model)=>Dismissible(
    key: Key(model.pizzaId),
    onDismissed: (value){
      FirebaseFirestore.instance.collection('pizza').doc(model.pizzaId).delete().then((value){
        Fluttertoast.showToast(
            msg: "Delete Successfully",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue.shade800,
            textColor: Colors.white,
            fontSize: 16.0
        );
        HomeCubit.get(context).GetPizzaData();

      }).catchError((error){
        print(error.toString());
        Fluttertoast.showToast(
            msg: "Delete Error",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.BOTTOM,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.blue.shade800,
            textColor: Colors.white,
            fontSize: 16.0
        );

      });




    },
    child: Card(
      elevation: 20,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusDirectional.circular(20)
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 80,
            backgroundImage: NetworkImage(
                '${model.picture}'
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model.name}',
                style: Theme.of(context).textTheme.titleLarge,
              )
            ],
          )

        ],
      ),
    ),
  );
}
