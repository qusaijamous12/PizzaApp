import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';

Widget BuildDefaultTextFormField({
  required String text,
  required IconData prefixIcon,
  IconData ?sufixIcon,
  required InputBorder outLineBorder,
  required String ?Function(String?)? validate,
  required TextEditingController controller,
  required TextInputType textInputType,
  var ObsecureText=false,
  void Function()? onpressSufix,
})=>TextFormField(
  decoration: InputDecoration(
    labelText: text,
    prefixIcon:Icon(
        prefixIcon
    ),
    suffixIcon: IconButton(
      onPressed: onpressSufix,
      icon: Icon(
          sufixIcon
      ),
    ),
    border: outLineBorder,


  ),
  validator:validate,
  obscureText: ObsecureText,
  controller:controller,
  keyboardType:textInputType,

);



Widget BuildDefaultButton(context,{
  required void Function()? onpress,
  required String text
})=>
    Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.blue[800],
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20))

      ),
      child: MaterialButton(
        onPressed:onpress,
        child: AutoSizeText(
          '${text.toUpperCase()}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.white
          ),
        ),

      ),
    );


Widget BuildDefaultButton2(context,{
  required void Function()? onpress,
  required String text
})=>
    Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadiusDirectional.all(Radius.circular(20))

      ),
      child: MaterialButton(
        onPressed:onpress,
        child: AutoSizeText(
          '${text.toUpperCase()}',
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Colors.black
          ),
        ),

      ),
    );



Widget BuildDefaultTextButton(context,{
  required void Function()? onpress,
  required String text
})=>TextButton(
    onPressed: onpress,
    child: AutoSizeText(
      '${text}',
      style: Theme.of(context).textTheme.titleLarge!.copyWith(
          fontSize: 18,
          color: Colors.black
      ),
    ));



dynamic NavigatePush(context,
    {
      required Widget widget
    }
    )=>Navigator.push(
    context,
    MaterialPageRoute(builder: (context)=>widget));



dynamic NavigateAndFinish(
    context,
    {
      required Widget widget
    }

    )=>Navigator.
pushAndRemoveUntil(
    context,
    MaterialPageRoute(builder: (context)=>widget), (route) => false);



dynamic Navigatepop(context)=>Navigator.pop(context);

PreferredSizeWidget BuildDefaultAppBar(context,{
  required IconData icon,
  required void Function()? onpress,
  String ?title,
  List<Widget> ?widget,
})=>AppBar(
  leading: IconButton(
    onPressed: onpress,
    icon: Icon(
      icon,
      color: Colors.black,

    ),
  ),
  title: AutoSizeText(
    '${title}',
    style: Theme.of(context).textTheme.titleLarge!.copyWith(
        fontSize: 18
    ),
  ),
  actions: widget,
);

String ?uid;
