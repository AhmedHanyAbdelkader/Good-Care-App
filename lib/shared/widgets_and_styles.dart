import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:graduation_project/resources/constants.dart';
import 'package:graduation_project/resources/sizes_manager.dart';
import 'package:image_picker/image_picker.dart';



/// text form field class
class MyFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final String? Function(String?)? validator;
  final String labelText;
  final String hintText;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  const MyFormField({
    Key? key,
    required this.labelText,
    required this.hintText,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.validator,
    required this.controller,
    required this.inputType,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSizes.s10),
      child: TextFormField(
        cursorColor: ColorManager.pink,
        onChanged: (value)=> value = controller.text,
        keyboardType: inputType,
        obscureText: obscureText,
        style: Theme.of(context).textTheme.headline3,
        decoration: InputDecoration(
          filled: true,
          hoverColor: Theme.of(context).hoverColor,
          //hoverColor: Colors.black,
          label: Text(labelText, style:const TextStyle(color: ColorManager.pink,),),
          hintText: hintText,
          hintStyle:const TextStyle(color: ColorManager.pink),
          prefixIcon: Icon(prefixIcon,color: Theme.of(context).iconTheme.color),
          suffixIcon: suffixIcon,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(AppSizes.s15),
          ),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color:  Theme.of(context).focusColor,)
          ),
        ),
        validator:validator,
      ),
    );
  }
}


/// login and signup button class
class MyRegistrationButton extends StatelessWidget {
  final String txt;
  final Function() onPressed;
  const MyRegistrationButton({
    required this.txt,
    required this.onPressed,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: Text(txt),
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        primary: ColorManager.pink,
        side:const BorderSide(width:3, color:Colors.brown), //border width and color
        shape: RoundedRectangleBorder( //to set border radius to button
            borderRadius: BorderRadius.circular(AppSizes.s30)
        ),
        padding:const EdgeInsets.all(AppSizes.s20),
      ),
    );
  }
}

/// show toast function
Future<bool?> myToast(){
  return Fluttertoast.showToast(
    msg: "Error! please try again",
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: AppSizes.s16,
  );
}


/// Home GestureDetector
class MyGestureDetector extends StatelessWidget {
  const MyGestureDetector({
    Key? key,
    @ required this.pageId,
    @ required this.imagePath,
    @ required this.labl,
  }) : super(key: key);
  final pageId;
  final  imagePath;
  final  labl;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed(pageId);
      },
      child: Card(
        elevation: AppSizes.s10,
        color: ColorManager.pink,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppSizes.s15,),),
        child: Container(
          width: AppSizes.s300,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: AppSizes.s20,top: AppSizes.s5),
                child: Image(
                    image: AssetImage(imagePath)
                ),
              ),
              Container(
                width: double.infinity,
                color: ColorManager.blue,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSizes.s5,right: AppSizes.s5,left: AppSizes.s5),
                  child: Center(
                    child: Text(labl,
                      style: const TextStyle(color: ColorManager.white),
                      softWrap: true,
                      //overflow: TextOverflow.ellipsis,
                      maxLines: Constants.c_2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


/// image picker button
class photoButton extends StatelessWidget {
  var onPressed;
  String label;
  IconData icon;
  photoButton({Key? key, required this.onPressed,required this.label,required this.icon});
  @override
  Widget build(BuildContext context) {
    return  ElevatedButton.icon(
      onPressed: ()=> onPressed,
      icon: Icon(icon),
      label: Text(label,style: Theme.of(context).textTheme.headline4,),
      style: ElevatedButton.styleFrom(
        primary: ColorManager.pink,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.s15)),
      ),
    );
  }
}

/// image picker Function
 pic(source) async {
  ImagePicker  _picker= ImagePicker();
  XFile? image = await _picker.pickImage(source: source);
  return image;
}


















