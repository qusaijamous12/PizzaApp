import 'package:auto_size_text/auto_size_text.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizzadelivery/constants/constants.dart';
import 'package:pizzadelivery/moduels/register/cubit/cubit.dart';
import 'package:pizzadelivery/moduels/register/cubit/state.dart';

class RegisterScreen extends StatelessWidget {
  var nameController=TextEditingController();
  var emailController=TextEditingController();
  var passwordController=TextEditingController();
  var phoneController=TextEditingController();



  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context)=>RegisterCubit(),
      child: BlocConsumer<RegisterCubit,RegisterState>(
        listener: (context,RegisterState){
          if(RegisterState is CreateAccountSuccessState){
            Fluttertoast.showToast(
                msg: "Create Account Success",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue.shade800,
                textColor: Colors.white,
                fontSize: 16.0
            );
          }
          else if(RegisterState is CreateAccountErrorState){
            Fluttertoast.showToast(
                msg: "Create Account Error",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.blue.shade800,
                textColor: Colors.white,
                fontSize: 16.0
            );

          }

        },
        builder: (context,RegisterState){
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue[800],
            elevation: 0,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: Brightness.light,
              statusBarColor: Colors.blue[800],
            ),
          ),
          body: Stack(
            children: [
              Container(
                padding: EdgeInsetsDirectional.only(
                    top: 40,
                    start: 20
                ),
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                ),
                child: AutoSizeText(
                  'Hello\nSign Up!',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Colors.white,
                      fontSize: 35
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsetsDirectional.only(
                    top: 160
                ),
                child: Container(
                  height: double.infinity,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadiusDirectional.only(
                          topEnd: Radius.circular(40),
                          topStart: Radius.circular(40)

                      )


                  ),
                  child: Padding(
                    padding: EdgeInsetsDirectional.only(
                        bottom: 20,
                        start: 20,
                        end: 20,
                        top: 40
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          BuildDefaultTextFormField(
                              text: 'Name',
                              prefixIcon: Icons.perm_identity,
                              outLineBorder: OutlineInputBorder(),
                              validate: (String ?value){

                              },
                              controller:nameController ,
                              textInputType: TextInputType.text),
                          SizedBox(
                            height:20 ,
                          ),
                          BuildDefaultTextFormField(
                              text: 'Email Address',
                              prefixIcon: Icons.email_outlined,
                              outLineBorder: OutlineInputBorder(),
                              validate: (String ?value){

                              },
                              controller:emailController ,
                              textInputType: TextInputType.emailAddress),
                          SizedBox(
                            height:20 ,
                          ),
                          BuildDefaultTextFormField(
                              text: 'Password',
                              prefixIcon: Icons.lock_outline,
                              outLineBorder: OutlineInputBorder(),
                              validate: (String ?value){

                              },
                              controller:passwordController ,
                              textInputType: TextInputType.visiblePassword),
                          SizedBox(
                            height:20 ,
                          ),
                          BuildDefaultTextFormField(
                              text: 'Phone',
                              prefixIcon: Icons.phone,
                              outLineBorder: OutlineInputBorder(),
                              validate: (String ?value){

                              },
                              controller:phoneController ,
                              textInputType: TextInputType.phone),
                          SizedBox(
                            height:20 ,
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          ConditionalBuilder(
                              condition: RegisterState is! LoadinCreateAccountState,
                              builder: (context)=>BuildDefaultButton(
                                  context,
                                  onpress: (){
                                    RegisterCubit.get(context).CreateAccountAuth(
                                        email: emailController.text,
                                        password: passwordController.text,
                                        name: nameController.text,
                                        phone: phoneController.text);
                                    emailController.text='';
                                    passwordController.text='';
                                    nameController.text='';
                                    phoneController.text='';

                                  },
                                  text: 'Register'),
                              fallback: (context)=>Center(child: CircularProgressIndicator()))

                        ],
                      ),
                    ),
                  ),


                ),
              )
            ],
          ),
        );
        },

      ),
    );
  }
}
