import 'package:flutter/material.dart';
import 'package:graduation_project/model/shared_pref.dart';
import 'package:graduation_project/registration/sign_up_page.dart';
import 'package:graduation_project/resources/assets_manager.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:graduation_project/resources/constants.dart';
import 'package:graduation_project/resources/sizes_manager.dart';
import '../home_page.dart';
import '../resources/strings_manager.dart';
import '../shared/widgets_and_styles.dart';
import 'package:http/http.dart' as http;

class LogInPage extends StatefulWidget {
  static String id =AppStrings.LOGINPAGEID;

  const LogInPage({Key? key}) : super(key: key);

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _visiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      body: Container(
        width: double.infinity,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: AppSizes.s50,),
                Image.asset(AssetsImages.logoImagePath,height: AppSizes.s120,width: AppSizes.s80,),
                const SizedBox(height: AppSizes.s5,),
                const Text(
                  AppStrings.appName,
                style: TextStyle(
                  fontSize: AppSizes.s30,
                  fontWeight: FontWeight.bold,
                  color: ColorManager.pink,
                ),
                ),
                const SizedBox(height: AppSizes.s30,),
                MyFormField(
                  controller: emailController,
                  inputType: TextInputType.emailAddress,
                  obscureText: false,
                  labelText: AppStrings.email,
                  hintText: AppStrings.gmail,
                  prefixIcon: Icons.email,
                  validator: (value){
                    bool emailValid = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(value!);
                    if(value ==null || value =='' || value.length== Constants.c_0 || emailValid==false)
                    {
                      return AppStrings.enterValidEmail;
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.s20,),
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
                    if(value ==null || value =='' ||value.length ==0 || isPasswordRegExpMatch==false)
                    {
                      return AppStrings.enterValidPassword;
                    }else{
                      return null;
                    }
                  },
                ),
                const SizedBox(height: AppSizes.s20,),
                MyRegistrationButton(
                  txt: AppStrings.logIn,
                  onPressed: ()async{
                    if(_formKey.currentState!.validate()){

                      MyLocalData myPrefs = MyLocalData();
                      Future<dynamic>? token = myPrefs.readToken();
                      if(token != null){
                        Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                      }else{
                        var respone =await http.post(Uri.parse(AppStrings.loginUrl),
                            body: {
                              AppStrings.email:emailController.text,
                              AppStrings.password:passwordController.text
                            });
                        print(respone.body.toString());
                        print(respone.statusCode);

                        if(respone.statusCode == Constants.c_200){

                          Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
                          emailController.dispose();
                          passwordController.dispose();
                        }else{
                          myToast();
                        }
                      }
                    }else{
                      myToast();
                    }
                  },
                ),
                const SizedBox(height: AppSizes.s10,),
                Padding(
                  padding: const EdgeInsets.all(AppSizes.s10),
                  child: Row(
                    children: [
                      Text(AppStrings.dontHaveAccount,style: Theme.of(context).textTheme.headline6,),
                      TextButton(
                        child:const Text(AppStrings.createOne,style: TextStyle(color: ColorManager.pink),),
                        onPressed: (){
                          Navigator.of(context).pushNamed(SignUpPage.id);
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}

















