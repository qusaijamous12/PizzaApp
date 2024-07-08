import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizzadelivery/constants/constants.dart';
import 'package:pizzadelivery/model/pizzaModel/pizzaModelInfo.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/state.dart';
import 'package:pizzadelivery/moduels/login/loginscreen.dart';
import 'package:pizzadelivery/moduels/pizzascreen/pizzaScreen.dart';
import 'package:pizzadelivery/shared/casheHelper/casheHelper.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,HomeState){

      },
      builder: (context,HomeState){
        var cubit=HomeCubit.get(context).loginModel;
        return ConditionalBuilder(
            condition: HomeCubit.get(context).loginModel!=null,
            builder: (context)=>Scaffold(
              appBar: AppBar(
                titleSpacing: 20,
                title: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage(
                          'https://media.istockphoto.com/id/184928432/photo/pizza-from-the-top-pepperoni-cheese.jpg?s=612x612&w=0&k=20&c=wkC4yrZLcvHqg-9kQtRb1wan_z15eiO1Z297OFSuxpg='
                      ),
                    ),
                    AutoSizeText(
                      'PIZZA',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w900,
                          fontSize: 25
                      ),
                    ),

                  ],
                ),
                actions: [
                  IconButton(
                      onPressed: (){
                        CasheHelper.RemoveData(key: 'uid');
                        NavigateAndFinish(context, widget: LoginScreen());
                      }, icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                    size: 30,
                  ))
                ],
                backgroundColor: Colors.white,
                elevation: 0,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark

                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextButton(
                          onPressed: (){},
                          child: AutoSizeText(
                            'Upgrade my plane',
                            style: TextStyle(
                                fontWeight: FontWeight.w900,
                                fontSize: 16
                            ),
                          )),
                      SizedBox(
                        height: 40,
                      ),
                      AutoSizeText(
                        'Pizza Palooza:\nBeacuase Ordinary\nIsn\'t an Option',
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 40
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: 400,
                        child: ListView.separated(
                            physics: BouncingScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context,index)=>BuildPizzaItem(context,HomeCubit.get(context).pizza[index]),
                            separatorBuilder: (context,index)=>SizedBox(
                              width: 15,
                            ),
                            itemCount: HomeCubit.get(context).pizza.length),
                      ),
                      SizedBox(
                        height: 20,
                      ),

                      TextButton(
                          onPressed: (){
                            NavigatePush(context, widget: PizzaScreen());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              AutoSizeText(
                                'View all',
                                style: TextStyle(
                                    color: Colors.blue[800],
                                    fontSize: 20
                                ),
                              ),
                              Icon(
                                Icons.arrow_forward,
                                color: Colors.blue[800],
                                size: 25,
                              )
                            ],
                          ))


                    ],
                  ),
                ),
              ),

            ),
            fallback: (context)=>Center(child: CircularProgressIndicator()));
      },
    );
  }
  Widget BuildPizzaItem(context,PizaaModel model)=>Card(
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadiusDirectional.circular(20)
    ),
    child: Container(
      padding: EdgeInsetsDirectional.symmetric(
          vertical: 10,
          horizontal: 20
      ),
      decoration: BoxDecoration(
          color: Colors.white,
          // border: Border.all(
          //     width: 1
          // ),
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
      ),
      width: 225,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 90,
            backgroundImage: NetworkImage(
                '${model.picture}'
            ),
            backgroundColor: Colors.white,

          ),
          Row(
            children: [
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                    horizontal: 20
                ),
                decoration: BoxDecoration(
                    color: Colors.blue[800],
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
                ),
                child: AutoSizeText(
                  'Spicy',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Spacer(),
              if(model.isVeg==true)
              Container(
                padding: EdgeInsetsDirectional.symmetric(
                    vertical: 10,
                    horizontal: 20
                ),
                decoration: BoxDecoration(
                    color: Colors.red[800],
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(20))
                ),
                child: AutoSizeText(
                  'NON-VEG',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 8,
          ),
          AutoSizeText(
            '${model.name}',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          SizedBox(
            height: 8,
          ),
          AutoSizeText(
            '${model.description}',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.grey
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              AutoSizeText(
                '\$${(model.price-(model.price)*(model.discount/100)).toStringAsFixed(1)}',
                style: TextStyle(
                    color: Colors.blue[800],
                    fontWeight: FontWeight.w500,
                    fontSize: 20
                ),
              ),
              AutoSizeText(
                '\$${model.price}',
                style: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 20,
                  decoration: TextDecoration.lineThrough,

                ),
              ),
              Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                ),
                child: IconButton(
                  onPressed: (){},
                  icon: Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          )
        ],
      ),
    ),
  );
}
