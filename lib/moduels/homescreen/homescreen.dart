import 'dart:io';

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
  var drawerKey=GlobalKey<ScaffoldState>();
  var nameController=TextEditingController();
  var descrptionController=TextEditingController();
  var priceController=TextEditingController();
  var discountController=TextEditingController();
  var formKey=GlobalKey<FormState>();
  String ?image;
  var caloriesController=TextEditingController();
  var carbController=TextEditingController();
  var fatController=TextEditingController();
  var protienController=TextEditingController();








  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit,HomeState>(
      listener: (context,HomeState){

      },
      builder: (context,HomeState){
        var cubit=HomeCubit.get(context).loginModel;
        var cubitt=HomeCubit.get(context);
        var pizzaImage=HomeCubit.get(context).pizzaImage;
        return ConditionalBuilder(
            condition: HomeCubit.get(context).loginModel!=null&&cubit!.status=='user',
            builder: (context)=>Scaffold(
              key: drawerKey,
              appBar: AppBar(
                titleSpacing: 2,
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
                  )),
                  IconButton(
                      onPressed: (){
                        drawerKey.currentState!.openDrawer();


                      }, icon: Icon(
                    Icons.menu,
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
                        height: 450,
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
              drawer: Drawer(
                width: 200,
                backgroundColor: Colors.black!.withOpacity(0.5),
                child: SafeArea(
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                      top: 30,
                      start: 10,
                      end: 10
                    ),
                    child: Column(

                      children: [
                        CircleAvatar(
                          radius: 48,
                          backgroundColor: Colors.white,
                          child: CircleAvatar(
                            radius: 45,
                            backgroundImage: NetworkImage(
                              '${cubit!.image}'
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Container(
                          alignment: AlignmentDirectional.center,
                          width: 180,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          child: Padding(
                            padding: EdgeInsetsDirectional.only(
                              start: 15
                            ),
                            child: Row(

                              children: [
                                Icon(
                                  Icons.perm_identity
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                AutoSizeText(
                                  'Name : ${cubit!.name}',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                      color: Colors.black
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        InkWell(
                          onTap: (){
                            NavigatePush(context, widget: PizzaScreen());
                          },
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            width: 180,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadiusDirectional.circular(20)
                            ),
                            child: Padding(
                              padding: EdgeInsetsDirectional.only(
                                start: 15
                              ),
                              child: Row(
                                children: [
                                  CircleAvatar(
                                    radius: 25,
                                    backgroundImage: NetworkImage(
                                        'https://media.istockphoto.com/id/184928432/photo/pizza-from-the-top-pepperoni-cheese.jpg?s=612x612&w=0&k=20&c=wkC4yrZLcvHqg-9kQtRb1wan_z15eiO1Z297OFSuxpg='
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  AutoSizeText(
                                    'Pizza',
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                        color: Colors.black
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Spacer(),
                        Padding(
                          padding:EdgeInsetsDirectional.only(
                            bottom: 250
                          ),
                          child: BuildDefaultButton2(
                              context,
                              onpress: (){

                              },
                              text: 'LogoUT'),
                        )

                      ],
                    ),
                  ),
                ),
              ),

            ),
            fallback: (context)=>Scaffold(
              backgroundColor: Colors.grey[300],
              appBar: AppBar(
                backgroundColor: Colors.white,
                actions: [
                  IconButton(
                      onPressed: (){
                        CasheHelper.RemoveData(key: 'uid');
                        NavigateAndFinish(context, widget: LoginScreen());
                      }, icon: Icon(
                    Icons.logout_outlined,
                    color: Colors.black,
                    size: 30,
                  )),
                ],
                elevation: 0,
                title: Text(
                  'Pizza Admin ',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.all(20.0),
                child: SingleChildScrollView(
                  physics: BouncingScrollPhysics(),
                  child: Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Create a New Pizza !',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          child: Stack(
                            alignment: AlignmentDirectional.bottomEnd,
                            children: [
                              Container(
                                padding: EdgeInsetsDirectional.all(30),
                                height: 350,
                                width: double.infinity,
                                child: Material(
                                  elevation:20 ,
                                  shape: CircleBorder(),
                                  child: CircleAvatar(
                                    backgroundImage: pizzaImage==null?NetworkImage('https://static.vecteezy.com/system/resources/previews/007/567/154/non_2x/select-image-icon-vector.jpg'):FileImage(File(pizzaImage.path))as ImageProvider,
                                  ),
                                ),

                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  backgroundColor: Colors.black,
                                  child: IconButton(
                                    onPressed: (){
                                      cubitt.selectImage();
                                    },
                                    icon: Icon(
                                      Icons.add,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )

                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Name',
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none

                            ),
                            controller: nameController,
                            validator: (String ?value){
                              if(value==null || value.isEmpty){
                                return 'Please enter the Name';
                              }
                              return null;
                            },

                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          child: TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Description',
                                labelStyle: TextStyle(
                                    color: Colors.grey
                                ),
                                filled: true,
                                fillColor: Colors.white,
                                border: InputBorder.none

                            ),
                            controller: descrptionController,
                            validator: (String ?value){
                              if(value==null || value.isEmpty){
                                return 'Please enter the descrption';
                              }
                              return null;
                            },

                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadiusDirectional.circular(20)
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Price',
                                      labelStyle: TextStyle(
                                          color: Colors.grey
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none

                                  ),
                                  controller: priceController,
                                  validator: (String ?value){
                                    if(value==null || value.isEmpty){
                                      return 'Please enter the price';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(color: Colors.white),
                                    borderRadius: BorderRadiusDirectional.circular(20)
                                ),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      labelText: 'Discount',
                                      labelStyle: TextStyle(
                                          color: Colors.grey
                                      ),
                                      suffixIcon: Icon(
                                          Icons.discount
                                      ),
                                      filled: true,
                                      fillColor: Colors.white,
                                      border: InputBorder.none

                                  ),
                                  controller: discountController,
                                ),
                              ),
                            ),

                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'IsVeg   :   ',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Checkbox(
                                value: cubitt.isCheck,
                                onChanged: (newValue){
                                  cubitt.ChangeIsCheck(newValue);
                                  print(newValue);

                                })
                          ],
                        ),
                        Row(
                          children: [
                            Text(
                              'Is Spicy   :   ',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              onTap: (){
                                cubitt.ChangeIsSpicy(1);
                              },
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.green,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: (){
                                cubitt.ChangeIsSpicy(2);
                              },
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.orange,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            InkWell(
                              onTap: (){
                                cubitt.ChangeIsSpicy(3);
                              },
                              child: CircleAvatar(
                                radius: 19,
                                backgroundColor: Colors.black,
                                child: CircleAvatar(
                                  radius: 17,
                                  backgroundColor: Colors.red,
                                ),
                              ),
                            ),


                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Text(
                              'Macros : ',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),



                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                                    ),
                                    elevation: 10,
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          vertical: 10,
                                          horizontal: 5
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book_online,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 10,
                                            child: TextFormField(
                                              validator: (String ?value){
                                                if(value==null || value.isEmpty){
                                                  return ' enter value';
                                                }
                                                return null;
                                              },

                                              controller: caloriesController,
                                              decoration: InputDecoration(
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              'calories'
                                          )

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                                    ),
                                    elevation: 10,
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          vertical: 10,
                                          horizontal: 5
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book_online,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 10,
                                            child: TextFormField(
                                              validator: (String ?value){
                                                if(value==null || value.isEmpty){
                                                  return ' enter value';
                                                }
                                                return null;
                                              },

                                              controller: protienController,
                                              decoration: InputDecoration(
                                              ),
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              'Protien'
                                          )

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                                    ),
                                    elevation: 10,
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          vertical: 10,
                                          horizontal: 5
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book_online,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 10,
                                            child: TextFormField(
                                              controller: fatController,
                                              decoration: InputDecoration(
                                              ),
                                              validator: (String ?value){
                                                if(value==null || value.isEmpty){
                                                  return ' enter value';
                                                }
                                                return null;
                                              },

                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              'Fat'
                                          )

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                              Row(
                                children: [
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                                    ),
                                    elevation: 10,
                                    child: Container(
                                      height: 90,
                                      width: 90,
                                      padding: EdgeInsetsDirectional.symmetric(
                                          vertical: 10,
                                          horizontal: 5
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Icon(
                                            Icons.book_online,
                                            color: Colors.red,
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Container(
                                            width: 70,
                                            height: 10,
                                            child: TextFormField(
                                              controller: carbController,
                                              decoration: InputDecoration(
                                              ),
                                              validator: (String ?value){
                                                if(value==null || value.isEmpty){
                                                  return ' enter value';
                                                }
                                                return null;
                                              },
                                            ),
                                          ),
                                          SizedBox(
                                            height: 3,
                                          ),
                                          Text(
                                              'Carbs'
                                          )

                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(
                                width: 5,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadiusDirectional.circular(20)
                          ),
                          child: MaterialButton(onPressed: (){
                            if(formKey.currentState!.validate()){
                              cubitt.UploadPizzaImage(
                                  name: nameController.text,
                                  descrption: descrptionController.text,
                                  price: double.parse(priceController.text),
                                  IsVeg: cubitt.isCheck,
                                  discont: double.parse(discountController.text),
                                  IsSpicy: cubitt.isSpicy,
                                  macros: {
                                    'calories':caloriesController.text,
                                    'carbs':carbController.text,
                                    'fat':fatController.text,
                                    'protien':protienController.text
                                  }
                              );
                              nameController.text='';
                              descrptionController.text='';
                              protienController.text='';
                              priceController.text='';
                              discountController.text='';
                              cubitt.isCheck=false;
                              cubitt.isSpicy=0;
                              fatController.text='';
                              carbController.text='';
                              caloriesController.text='';

                            }
                          },
                            child: AutoSizeText(
                              'Add Pizza Now',
                              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                  color: Colors.white
                              ),
                            ),
                          ),
                        )





                      ],
                    ),
                  ),
                ),
              ),


            ));
        // else if(cubit.status=='admin')
        //   return ConditionalBuilder(
        //       condition: HomeCubit.get(context).loginModel!=null&&HomeCubit.get(context).pizza.length>0,
        //       builder: (context)=>Scaffold(
        //         backgroundColor: Colors.grey[300],
        //         appBar: AppBar(
        //           backgroundColor: Colors.white,
        //           actions: [
        //             IconButton(
        //                 onPressed: (){
        //                   CasheHelper.RemoveData(key: 'uid');
        //                   NavigateAndFinish(context, widget: LoginScreen());
        //                 }, icon: Icon(
        //               Icons.logout_outlined,
        //               color: Colors.black,
        //               size: 30,
        //             )),
        //           ],
        //           elevation: 0,
        //           title: Text(
        //             'Pizza Admin ',
        //             style: Theme.of(context).textTheme.titleLarge,
        //           ),
        //           systemOverlayStyle: SystemUiOverlayStyle(
        //             statusBarColor: Colors.white,
        //             statusBarIconBrightness: Brightness.dark
        //           ),
        //         ),
        //         body: Padding(
        //           padding: const EdgeInsets.all(20.0),
        //           child: SingleChildScrollView(
        //             physics: BouncingScrollPhysics(),
        //             child: Form(
        //               key: formKey,
        //               child: Column(
        //                 crossAxisAlignment: CrossAxisAlignment.start,
        //                 children: [
        //                   Text(
        //                     'Create a New Pizza !',
        //                     style: Theme.of(context).textTheme.titleLarge,
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Card(
        //                     elevation: 10,
        //                     shape: RoundedRectangleBorder(
        //                       borderRadius: BorderRadiusDirectional.circular(20)
        //                     ),
        //                     child: Stack(
        //                       alignment: AlignmentDirectional.bottomEnd,
        //                       children: [
        //                         Container(
        //                           padding: EdgeInsetsDirectional.all(30),
        //                           height: 350,
        //                           width: double.infinity,
        //                           child: Material(
        //                             elevation:20 ,
        //                             shape: CircleBorder(),
        //                             child: CircleAvatar(
        //                               backgroundImage: pizzaImage==null?NetworkImage('https://static.vecteezy.com/system/resources/previews/007/567/154/non_2x/select-image-icon-vector.jpg'):FileImage(File(pizzaImage.path))as ImageProvider,
        //                             ),
        //                           ),
        //
        //                         ),
        //                         Padding(
        //                           padding: const EdgeInsets.all(8.0),
        //                           child: CircleAvatar(
        //                             backgroundColor: Colors.black,
        //                             child: IconButton(
        //                                 onPressed: (){
        //                                   cubitt.selectImage();
        //                                 },
        //                                 icon: Icon(
        //                                   Icons.add,
        //                                   color: Colors.white,
        //                                 ),
        //                             ),
        //                           ),
        //                         )
        //
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Container(
        //                     decoration: BoxDecoration(
        //                       border: Border.all(color: Colors.white),
        //                       borderRadius: BorderRadiusDirectional.circular(20)
        //                     ),
        //                     clipBehavior: Clip.antiAliasWithSaveLayer,
        //                     child: TextFormField(
        //                       decoration: InputDecoration(
        //                         labelText: 'Name',
        //                         labelStyle: TextStyle(
        //                           color: Colors.grey
        //                         ),
        //                         filled: true,
        //                         fillColor: Colors.white,
        //                         border: InputBorder.none
        //
        //                       ),
        //                       controller: nameController,
        //                       validator: (String ?value){
        //                         if(value==null || value.isEmpty){
        //                           return 'Please enter the Name';
        //                         }
        //                         return null;
        //                       },
        //
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Container(
        //                     decoration: BoxDecoration(
        //                         border: Border.all(color: Colors.white),
        //                         borderRadius: BorderRadiusDirectional.circular(20)
        //                     ),
        //                     clipBehavior: Clip.antiAliasWithSaveLayer,
        //                     child: TextFormField(
        //                       decoration: InputDecoration(
        //                           labelText: 'Description',
        //                           labelStyle: TextStyle(
        //                               color: Colors.grey
        //                           ),
        //                           filled: true,
        //                           fillColor: Colors.white,
        //                           border: InputBorder.none
        //
        //                       ),
        //                       controller: descrptionController,
        //                       validator: (String ?value){
        //                         if(value==null || value.isEmpty){
        //                           return 'Please enter the descrption';
        //                         }
        //                         return null;
        //                       },
        //
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Row(
        //                     children: [
        //                       Expanded(
        //                         child: Container(
        //                           decoration: BoxDecoration(
        //                               border: Border.all(color: Colors.white),
        //                               borderRadius: BorderRadiusDirectional.circular(20)
        //                           ),
        //                           clipBehavior: Clip.antiAliasWithSaveLayer,
        //                           child: TextFormField(
        //                             decoration: InputDecoration(
        //                                 labelText: 'Price',
        //                                 labelStyle: TextStyle(
        //                                     color: Colors.grey
        //                                 ),
        //                                 filled: true,
        //                                 fillColor: Colors.white,
        //                                 border: InputBorder.none
        //
        //                             ),
        //                             controller: priceController,
        //                             validator: (String ?value){
        //                               if(value==null || value.isEmpty){
        //                                 return 'Please enter the price';
        //                               }
        //                               return null;
        //                             },
        //                           ),
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Expanded(
        //                         child: Container(
        //                           decoration: BoxDecoration(
        //                               border: Border.all(color: Colors.white),
        //                               borderRadius: BorderRadiusDirectional.circular(20)
        //                           ),
        //                           clipBehavior: Clip.antiAliasWithSaveLayer,
        //                           child: TextFormField(
        //                             decoration: InputDecoration(
        //                                 labelText: 'Discount',
        //                                 labelStyle: TextStyle(
        //                                     color: Colors.grey
        //                                 ),
        //                                 suffixIcon: Icon(
        //                                   Icons.discount
        //                                 ),
        //                                 filled: true,
        //                                 fillColor: Colors.white,
        //                                 border: InputBorder.none
        //
        //                             ),
        //                             controller: discountController,
        //                           ),
        //                         ),
        //                       ),
        //
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Row(
        //                     children: [
        //                       Text(
        //                         'IsVeg   :   ',
        //                         style: Theme.of(context).textTheme.titleLarge,
        //                       ),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       Checkbox(
        //                           value: cubitt.isCheck,
        //                           onChanged: (newValue){
        //                             cubitt.ChangeIsCheck(newValue);
        //                             print(newValue);
        //
        //                           })
        //                     ],
        //                   ),
        //                   Row(
        //                     children: [
        //                       Text(
        //                         'Is Spicy   :   ',
        //                         style: Theme.of(context).textTheme.titleLarge,
        //                       ),
        //                       SizedBox(
        //                         width: 10,
        //                       ),
        //                       InkWell(
        //                         onTap: (){
        //                           cubitt.ChangeIsSpicy(1);
        //                         },
        //                         child: CircleAvatar(
        //                           radius: 19,
        //                           backgroundColor: Colors.black,
        //                           child: CircleAvatar(
        //                             radius: 17,
        //                             backgroundColor: Colors.green,
        //                           ),
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         width: 5,
        //                       ),
        //                       InkWell(
        //                         onTap: (){
        //                           cubitt.ChangeIsSpicy(2);
        //                         },
        //                         child: CircleAvatar(
        //                           radius: 19,
        //                           backgroundColor: Colors.black,
        //                           child: CircleAvatar(
        //                             radius: 17,
        //                             backgroundColor: Colors.orange,
        //                           ),
        //                         ),
        //                       ),
        //                       SizedBox(
        //                         width: 5,
        //                       ),
        //                       InkWell(
        //                         onTap: (){
        //                           cubitt.ChangeIsSpicy(3);
        //                         },
        //                         child: CircleAvatar(
        //                           radius: 19,
        //                           backgroundColor: Colors.black,
        //                           child: CircleAvatar(
        //                             radius: 17,
        //                             backgroundColor: Colors.red,
        //                           ),
        //                         ),
        //                       ),
        //
        //
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Row(
        //                     children: [
        //                       Text(
        //                         'Macros : ',
        //                         style: Theme.of(context).textTheme.titleLarge,
        //                       ),
        //
        //
        //
        //                     ],
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   SingleChildScrollView(
        //                     physics: BouncingScrollPhysics(),
        //                     scrollDirection: Axis.horizontal,
        //                     child: Row(
        //                       children: [
        //                         Row(
        //                           children: [
        //                             Card(
        //                               shape: RoundedRectangleBorder(
        //                                   borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
        //                               ),
        //                               elevation: 10,
        //                               child: Container(
        //                                 height: 90,
        //                                 width: 90,
        //                                 padding: EdgeInsetsDirectional.symmetric(
        //                                     vertical: 10,
        //                                     horizontal: 5
        //                                 ),
        //                                 child: Column(
        //                                   mainAxisAlignment: MainAxisAlignment.center,
        //                                   children: [
        //                                     Icon(
        //                                       Icons.book_online,
        //                                       color: Colors.red,
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Container(
        //                                       width: 70,
        //                                       height: 10,
        //                                       child: TextFormField(
        //                                         validator: (String ?value){
        //                                           if(value==null || value.isEmpty){
        //                                             return ' enter value';
        //                                           }
        //                                           return null;
        //                                         },
        //
        //                                         controller: caloriesController,
        //                                         decoration: InputDecoration(
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Text(
        //                                       'calories'
        //                                     )
        //
        //                                   ],
        //                                 ),
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                         Row(
        //                           children: [
        //                             Card(
        //                               shape: RoundedRectangleBorder(
        //                                   borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
        //                               ),
        //                               elevation: 10,
        //                               child: Container(
        //                                 height: 90,
        //                                 width: 90,
        //                                 padding: EdgeInsetsDirectional.symmetric(
        //                                     vertical: 10,
        //                                     horizontal: 5
        //                                 ),
        //                                 child: Column(
        //                                   mainAxisAlignment: MainAxisAlignment.center,
        //                                   children: [
        //                                     Icon(
        //                                       Icons.book_online,
        //                                       color: Colors.red,
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Container(
        //                                       width: 70,
        //                                       height: 10,
        //                                       child: TextFormField(
        //                                         validator: (String ?value){
        //                                           if(value==null || value.isEmpty){
        //                                             return ' enter value';
        //                                           }
        //                                           return null;
        //                                         },
        //
        //                                         controller: protienController,
        //                                         decoration: InputDecoration(
        //                                         ),
        //                                       ),
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Text(
        //                                         'Protien'
        //                                     )
        //
        //                                   ],
        //                                 ),
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                         Row(
        //                           children: [
        //                             Card(
        //                               shape: RoundedRectangleBorder(
        //                                   borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
        //                               ),
        //                               elevation: 10,
        //                               child: Container(
        //                                 height: 90,
        //                                 width: 90,
        //                                 padding: EdgeInsetsDirectional.symmetric(
        //                                     vertical: 10,
        //                                     horizontal: 5
        //                                 ),
        //                                 child: Column(
        //                                   mainAxisAlignment: MainAxisAlignment.center,
        //                                   children: [
        //                                     Icon(
        //                                       Icons.book_online,
        //                                       color: Colors.red,
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Container(
        //                                       width: 70,
        //                                       height: 10,
        //                                       child: TextFormField(
        //                                         controller: fatController,
        //                                         decoration: InputDecoration(
        //                                         ),
        //                                         validator: (String ?value){
        //                                           if(value==null || value.isEmpty){
        //                                             return ' enter value';
        //                                           }
        //                                           return null;
        //                                         },
        //
        //                                       ),
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Text(
        //                                         'Fat'
        //                                     )
        //
        //                                   ],
        //                                 ),
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                         Row(
        //                           children: [
        //                             Card(
        //                               shape: RoundedRectangleBorder(
        //                                   borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
        //                               ),
        //                               elevation: 10,
        //                               child: Container(
        //                                 height: 90,
        //                                 width: 90,
        //                                 padding: EdgeInsetsDirectional.symmetric(
        //                                     vertical: 10,
        //                                     horizontal: 5
        //                                 ),
        //                                 child: Column(
        //                                   mainAxisAlignment: MainAxisAlignment.center,
        //                                   children: [
        //                                     Icon(
        //                                       Icons.book_online,
        //                                       color: Colors.red,
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Container(
        //                                       width: 70,
        //                                       height: 10,
        //                                       child: TextFormField(
        //                                         controller: carbController,
        //                                         decoration: InputDecoration(
        //                                         ),
        //                                         validator: (String ?value){
        //                                           if(value==null || value.isEmpty){
        //                                             return ' enter value';
        //                                           }
        //                                           return null;
        //                                         },
        //                                       ),
        //                                     ),
        //                                     SizedBox(
        //                                       height: 3,
        //                                     ),
        //                                     Text(
        //                                         'Carbs'
        //                                     )
        //
        //                                   ],
        //                                 ),
        //                               ),
        //                             )
        //                           ],
        //                         ),
        //                         SizedBox(
        //                           width: 5,
        //                         ),
        //                       ],
        //                     ),
        //                   ),
        //                   SizedBox(
        //                     height: 20,
        //                   ),
        //                   Container(
        //                     width: double.infinity,
        //                     decoration: BoxDecoration(
        //                         color: Colors.black,
        //                         borderRadius: BorderRadiusDirectional.circular(20)
        //                     ),
        //                     child: MaterialButton(onPressed: (){
        //                       if(formKey.currentState!.validate()){
        //                         cubitt.UploadPizzaImage(
        //                             name: nameController.text,
        //                             descrption: descrptionController.text,
        //                             price: double.parse(priceController.text),
        //                             IsVeg: cubitt.isCheck,
        //                             discont: double.parse(discountController.text),
        //                             IsSpicy: cubitt.isSpicy,
        //                           macros: {
        //                               'calories':caloriesController.text,
        //                             'carbs':carbController.text,
        //                             'fat':fatController.text,
        //                             'protien':protienController.text
        //                           }
        //                             );
        //                         nameController.text='';
        //                         descrptionController.text='';
        //                         protienController.text='';
        //                         priceController.text='';
        //                         discountController.text='';
        //                         cubitt.isCheck=false;
        //                         cubitt.isSpicy=0;
        //                         fatController.text='';
        //                         carbController.text='';
        //                         caloriesController.text='';
        //
        //                       }
        //                     },
        //                       child: AutoSizeText(
        //                         'Add Pizza Now',
        //                         style: Theme.of(context).textTheme.titleLarge!.copyWith(
        //                             color: Colors.white
        //                         ),
        //                       ),
        //                     ),
        //                   )
        //
        //
        //
        //
        //
        //                 ],
        //               ),
        //             ),
        //           ),
        //         ),
        //
        //
        //       ),
        //       fallback: (context)=>Scaffold());
        // else
        //   return Scaffold();
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
     // height: 250,
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
                    color: model.spicy==1?Colors.green : model.spicy==2?Colors.orange:Colors.red,
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
                    color: Colors.blue[800],
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
