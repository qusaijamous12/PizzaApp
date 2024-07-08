import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzadelivery/constants/constants.dart';
import 'package:pizzadelivery/moduels/homescreen/homescreen.dart';
import 'package:pizzadelivery/moduels/login/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/login/cubit/state.dart';
import 'package:pizzadelivery/moduels/register/registerscreen.dart';



class LoginScreen extends StatelessWidget {
  var emailController=TextEditingController();
  var passowrdController=TextEditingController();

  @override
  Widget build(BuildContext context) {
   return BlocProvider(
     create: (BuildContext context)=>LoginCubit(),
     child: BlocConsumer<LoginCubit,LoginState>(
       listener: (context,LoginState){
         if(LoginState is SignInSuccess){
           Fluttertoast.showToast(
               msg: "SignIn Successfully",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.blue.shade800,
               textColor: Colors.white,
               fontSize: 16.0
           );
           NavigateAndFinish(context, widget: HomeScreen());
         }
         else if(LoginState is SignInError){
           Fluttertoast.showToast(
               msg: "SignIn Failed",
               toastLength: Toast.LENGTH_SHORT,
               gravity: ToastGravity.BOTTOM,
               timeInSecForIosWeb: 1,
               backgroundColor: Colors.blue.shade800,
               textColor: Colors.white,
               fontSize: 16.0
           );


         }

       },
       builder: (context,LoginState){
         var cubit=LoginCubit.get(context);
         return Scaffold(
           appBar: AppBar(
             backgroundColor: Colors.blue[800],
             elevation: 0,
             systemOverlayStyle: SystemUiOverlayStyle(
                 statusBarIconBrightness: Brightness.light,
                 statusBarColor: Colors.blue[800]
             ),
           ),
           body: Stack(
             children: [
               Container(
                 height: double.infinity,
                 width: double.infinity,
                 decoration: BoxDecoration(
                     color: Colors.blue[800]
                 ),
                 child: Padding(
                   padding: EdgeInsetsDirectional.only(
                       top: 30,
                       start: 20
                   ),
                   child: AutoSizeText(
                     'Hello\nSign in!',
                     style: TextStyle(
                         fontSize: 40,
                         fontWeight: FontWeight.bold,
                         color: Colors.white
                     ),
                   ),
                 ),
               ),
               Padding(
                 padding: EdgeInsetsDirectional.only(top: 180),
                 child: Container(
                   height: double.infinity,
                   width: double.infinity,
                   decoration: BoxDecoration(
                       color: Colors.white,
                       borderRadius: BorderRadiusDirectional.only(
                         topStart: Radius.circular(40),
                         topEnd: Radius.circular(40),

                       )
                   ),
                   child: Padding(
                     padding: EdgeInsetsDirectional.only(
                         start: 20,
                         end: 20,
                         top: 80
                     ),
                     child: SingleChildScrollView(
                       child: Column(
                         children: [
                           BuildDefaultTextFormField(
                               text: 'Email Address',
                               prefixIcon: Icons.email_outlined,
                               outLineBorder: OutlineInputBorder(),
                               validate: (String ?value){

                               },
                               controller: emailController,
                               textInputType: TextInputType.emailAddress),
                           SizedBox(
                             height: 40,
                           ),
                           BuildDefaultTextFormField(
                               text: 'Password',
                               prefixIcon: Icons.lock_outline,
                               sufixIcon: cubit.icon_visable,
                               ObsecureText: cubit.IsObsecuer,
                               onpressSufix: (){
                                 cubit.ChangeIcon();
                               },
                               outLineBorder: OutlineInputBorder(),
                               validate: (String ?value){

                               },
                               controller: passowrdController,
                               textInputType: TextInputType.visiblePassword),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.end,
                             children: [
                               BuildDefaultTextButton(context, onpress: (){}
                                   , text: 'Forget Password?')
                             ],
                           ),
                           SizedBox(
                             height: 20,
                           ),
                           ConditionalBuilder(
                               condition: LoginState is! LoadingSignInState,
                               builder: (context)=>BuildDefaultButton(
                                   context,
                                   onpress: (){

                                     LoginCubit.get(context).SignIn(context,
                                         email: emailController.text,
                                         password: passowrdController.text);
                                     emailController.text='';
                                     passowrdController.text='';
                                   },
                                   text: 'sign in'),
                               fallback: (context)=>Center(child: CircularProgressIndicator())),
                           SizedBox(
                             height: 20,
                           ),
                           Row(
                             children: [
                               AutoSizeText(
                                 'Don\'t have account?',
                                 style: Theme.of(context).textTheme.subtitle1,
                               ),
                               BuildDefaultTextButton(context, onpress: (){
                                 NavigatePush(context, widget: RegisterScreen());
                               }, text: 'Sign up')
                             ],
                           )




                         ],
                       ),
                     ),
                   ),
                 ),
               ),

             ],
           ),

         );
       },
     ),
   );
  }
}
