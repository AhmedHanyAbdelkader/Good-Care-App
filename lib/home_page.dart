import 'package:flutter/material.dart';
import 'package:graduation_project/model/shared_pref.dart';
import 'package:graduation_project/registration/log_in_page.dart';
import 'package:graduation_project/resources/assets_manager.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:graduation_project/resources/constants.dart';
import 'package:graduation_project/resources/sizes_manager.dart';
import 'package:graduation_project/resources/strings_manager.dart';
import 'package:graduation_project/shared/widgets_and_styles.dart';

import 'image_page.dart';


class HomePage extends StatelessWidget {
  static String id =AppStrings.HOMEPAGEID;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        actions: [
          IconButton(
            icon:const Icon(Icons.login,size: AppSizes.s30,),
            onPressed: () async{
              MyLocalData myPrefs = MyLocalData();
              await myPrefs.removeToken();
              Navigator.of(context).pushReplacementNamed(LogInPage.id);
            },
          ),
        ],
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
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
            const SizedBox(height: 50,),
            const MyGestureDetector(pageId: ImagePage.id,imagePath: AssetsImages.xRayImagePath,labl:AppStrings.breastCancer),
            const SizedBox(height: AppSizes.s20,),
            const MyGestureDetector(pageId: ImagePage.id,imagePath: AssetsImages.laboratoryImagePath,labl:AppStrings.lesionMelanome),
          ],
        ),
      ),
    );
  }
}










