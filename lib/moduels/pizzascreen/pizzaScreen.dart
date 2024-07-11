
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pizzadelivery/constants/constants.dart';
import 'package:pizzadelivery/moduels/homescreen/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/pizzaview/pizzaview.dart';

import '../../model/pizzaModel/pizzaModelInfo.dart';

class PizzaScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
   return Scaffold(
     appBar: AppBar(
       leading: IconButton(
         onPressed: (){
           Navigatepop(context);
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
       padding: const EdgeInsets.all(8.0),
       child: Column(
         children: [
           Expanded(
             child: GridView.count(
               physics: BouncingScrollPhysics(),
                 crossAxisCount: 2,
               mainAxisSpacing: 13,
               crossAxisSpacing: 1,
               childAspectRatio: 0.5,
               children: List.generate(HomeCubit.get(context).pizza.length, (index) => BuildPizzaScreenItem(context,HomeCubit.get(context).pizza[index])),
             ),
           )
         ],
       ),
     ),
   );
  }
  Widget BuildPizzaScreenItem(context,PizaaModel model)=>InkWell(
    onTap: (){

      NavigatePush(context, widget: PizzaView(
        image: model.picture,
        discount: model.discount,
        price: model.price,
        macros: model.macros,
      ));
    },
    child: Card(
      elevation: 10,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20)
      ),
      child: Container(
        padding: EdgeInsetsDirectional.symmetric(
            vertical: 1,
            horizontal: 2
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
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 85,
              backgroundImage: NetworkImage(
                  '${model.picture}'
              ),
              backgroundColor: Colors.white,

            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    // Container(
                    //   decoration: BoxDecoration(
                    //       color: Colors.black,
                    //       borderRadius: BorderRadiusDirectional.all(Radius.circular(10))
                    //   ),
                    //   child: IconButton(
                    //     onPressed: (){},
                    //     icon: Icon(
                    //       Icons.add,
                    //       color: Colors.white,
                    //     ),
                    //   ),
                    // )
                    FloatingActionButton(
                      backgroundColor: Colors.black,
                        onPressed: (){},
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                      ),
                    )
                  ],
                )
              ],
            )
          ],
        ),
      ),
    ),
  );
}
