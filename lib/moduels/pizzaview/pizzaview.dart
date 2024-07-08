import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizzadelivery/constants/constants.dart';

import '../../model/pizzaModel/pizzaModelInfo.dart';

class PizzaView extends StatelessWidget {

  String ?image;
  dynamic ?price;
  dynamic ?discount;
  Macros ?macros;
  PizzaView({
    this.image,
    this.price,
    this.discount,
    this.macros

});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: Icon(
            Icons.navigate_before_outlined,
            color: Colors.black,
            size: 30,
          ),
        ),
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
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: (){}, icon: Icon(
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
            children: [
              Container(
                width: double.infinity,
                child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)
                  ),

                  child: Padding(
                    padding: EdgeInsetsDirectional.all(15),
                    child: CircleAvatar(
                      radius: 150,
                      backgroundImage: NetworkImage(
                        '${image}'
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              Card(
                elevation: 10,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child:Container(
                  padding: EdgeInsetsDirectional.all(20),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      //border: Border.all(),
                      borderRadius: BorderRadiusDirectional.circular(20)
                  ),
                  child: Column(
                    children: [

                      Row(
                        children: [
                          AutoSizeText(
                            'Truffle Temptation',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                          Spacer(),
                          AutoSizeText(
                            '\$${(price-(price)*(discount/100)).toStringAsFixed(1)}',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.blue[800],
                              fontWeight: FontWeight.bold
                            ),

                          )
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          AutoSizeText(
                            ' Extravaganza',
                            style: Theme.of(context).textTheme.titleLarge,

                          ),
                          Spacer(),
                          AutoSizeText(
                            '\$${price}',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                decoration: TextDecoration.lineThrough,
                              fontSize: 16,
                              color: Colors.grey
                            ),

                          )
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
                                  Text(
                                      '${macros!.calories} calories'
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
                                        Text(
                                            '${macros!.protien} protien'
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
                                        Text(
                                            '${macros!.fat} Fat'
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
                                        Text(
                                            '${macros!.calories} calories'
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
                        child: MaterialButton(onPressed: (){},
                          child: AutoSizeText(
                            'Buy Now',
                            style: Theme.of(context).textTheme.titleLarge!.copyWith(
                                color: Colors.white
                            ),
                          ),
                        ),
                      )

                    ],
                  ),

                )
                ,
              )
            ],
          ),
        ),
      ),

    );
  }
}
