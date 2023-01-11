import 'package:flutter/material.dart';
import 'package:graduation_project/home_page.dart';
import 'package:graduation_project/model/shared_pref.dart';
import 'package:graduation_project/resources/assets_manager.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:graduation_project/resources/constants.dart';
import 'package:graduation_project/resources/sizes_manager.dart';
import 'package:graduation_project/resources/strings_manager.dart';
import '../shared/widgets_and_styles.dart';
import 'log_in_page.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SignUpPage extends StatefulWidget {
  static String id = AppStrings.SIGNUPPAGEID;
  SignUpPage({Key? key}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const SizedBox(height: AppSizes.s50,),
            Image.asset(AssetsImages.logoImagePath,height: AppSizes.s120,width: AppSizes.s80,),
            const SizedBox(height: 5,),
            const Text(
              AppStrings.appName,
              style: TextStyle(
                fontSize: AppSizes.s30,
                fontWeight: FontWeight.bold,
                color: ColorManager.pink,
              ),
            ),
            const SizedBox(height: AppSizes.s30,),
            ///Name
            MyFormField(
              controller: nameController,
              inputType: TextInputType.text,
              obscureText: false,
              labelText: AppStrings.userName,
              hintText: AppStrings.userNameHint,
              prefixIcon: Icons.person_pin,
              validator: (value){
                bool nameValid = RegExp(r'[!@#<>?":_`~;[\]\\|=+)(*&^%0-9-]').hasMatch(value!);
                if(value ==null || value =='' || value.length==0 || nameValid==false)
                {
                  return AppStrings.enterValidName;
                }else{
                  return null;
                }
              },
            ),
            const SizedBox(height: AppSizes.s20,),
            ///Email
            MyFormField(
              controller: emailController,
              inputType: TextInputType.emailAddress,
              obscureText: false,
              labelText: AppStrings.email,
              hintText: AppStrings.gmail,
              prefixIcon: Icons.email,
              validator: (value){
                bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                if(value == null || value =='' || value.length==0 || emailValid==false)
                {
                  return AppStrings.enterValidEmail;
                }else{
                  return null;
                }
              },
            ),
            const SizedBox(height: AppSizes.s20,),
            ///password
            MyFormField(
              controller: passwordController,
              inputType: TextInputType.visiblePassword,
              obscureText: !_visiblePassword,
              labelText: AppStrings.password,
              hintText: '',
              prefixIcon: Icons.vpn_key,
              suffixIcon: InkWell(
                onTap: (){
                  setState(() {
                    _visiblePassword = !_visiblePassword;
                  });
                },
                child: Icon(_visiblePassword ?Icons.visibility : Icons.visibility_off ,
                  color: Theme.of(context).iconTheme.color,
                ),
              ),
              validator: (value){
                String  pattern = r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
                bool isPasswordRegExpMatch = RegExp(pattern).hasMatch(value.toString());
                if(value ==null || value =='' || value.length == Constants.c_0 || isPasswordRegExpMatch==false)
                {
                  return AppStrings.enterValidPassword;
                }
                else{
                  return null;
                }
              },
            ),
            const SizedBox(height: AppSizes.s20,),
            ///Button
            MyRegistrationButton(
              txt: AppStrings.signUp,
              onPressed: ()async{
                if(_formKey.currentState!.validate()){

                  var respone =await http.post(Uri.parse(AppStrings.registerUrl),
                      body: json.encode({
                        AppStrings.userNameForJson:nameController.text,
                        AppStrings.email:emailController.text,
                        AppStrings.password:passwordController.text
                      },),
                    headers: {
                      'Content-Type': 'application/json'
                    },
                  );
                  Map<String,dynamic>? jsn = jsonDecode(respone.body);
                  if(respone.statusCode == 200){
                    MyLocalData myPrefs = new MyLocalData();
                    myPrefs.stroeToken(jsn![AppStrings.token]);
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                    emailController.dispose();
                    passwordController.dispose();
                    nameController.dispose();
                  }else{
                    myToast();
                  }
                }else{
                  myToast();
                }
              },
            ),
            Padding(
              padding: const EdgeInsets.all(AppSizes.s10),
              child: Row(
                children: [
                   Text(AppStrings.alreadyRegistered,style: Theme.of(context).textTheme.headline6,),
                  TextButton(
                      onPressed: (){
                        Navigator.of(context).pushNamed(LogInPage.id);
                      },
                      child:const Text(AppStrings.logIn,style: TextStyle(color: ColorManager.pink),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}














