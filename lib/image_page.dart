import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:graduation_project/resources/sizes_manager.dart';
import 'package:graduation_project/resources/strings_manager.dart';
import 'package:graduation_project/shared/widgets_and_styles.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';



class ImagePage extends StatefulWidget {
  static const String id = AppStrings.IMAGEPAGEID;
  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  bool isImagePicked = false;
  late  XFile? _image;
  Uint8List? newImage;



  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton.icon(
                onPressed: ()async {
                 _image =await pic(ImageSource.camera);
                _image != null ?  setState(() {isImagePicked=true;}) :null ;
                },
                icon: const Icon(Icons.camera_enhance),
                label: Text(
                  AppStrings.takePhoto,
                  style: Theme.of(context).textTheme.headline4,
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s15)),
                ),
              ),
              const SizedBox(
                height: AppSizes.s25,
              ),
              ElevatedButton.icon(
                onPressed: () async{
                _image =  await pic(ImageSource.gallery);

                _image != null ? setState(() {isImagePicked=true;}) : null;
                },
                //icon:const Icon(Icons.photo),
                icon: const Icon(Icons.photo),
                label: Text(
                  AppStrings.choosePhoto,
                  style: Theme.of(context).textTheme.headline4,
                ),
                style: ElevatedButton.styleFrom(
                  primary: ColorManager.pink,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppSizes.s15)),
                ),
              ),
              const SizedBox(
                height: AppSizes.s35,
              ),
              Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                    child: isImagePicked != false ? Image.file(File(_image!.path)) :null,),
                  ElevatedButton(
                      onPressed: ()async{
                        newImage =  await doUpload();
                        newImage != null ? setState(() {}) : null;
                      },
                      child:const Text(AppStrings.getResult),
                  ),
                ],
              ),
              const SizedBox(height: AppSizes.s22,),
              newImage != null ? Image.memory(newImage!) : const SizedBox(child: CircularProgressIndicator(),),
            ],
          ),
        ),
      ),
    );
  }



  doUpload()async{
    http.Response? respone;
    File file = File( _image!.path );
    var request = http.MultipartRequest(AppStrings.post, Uri.parse(AppStrings.imageUrl),);
    Map<String, String> headers = {"Content-type": "multipart/form-data"};
    request.files.add(http.MultipartFile(AppStrings.image,
        file.readAsBytes().asStream(),
        file.lengthSync(),
        filename: AppStrings.image,
        contentType: MediaType(AppStrings.image, AppStrings.jpeg),
      ),
    );
    request.headers.addAll(headers);
    final result = await request.send();
    respone = await http.Response.fromStream(result);

    final rejs = jsonDecode(respone.body);
    String? image = rejs[AppStrings.image];

    Uint8List? bytesImage;
    int len = image!.length - 1;
    bytesImage = base64.decode(image.substring(2,len));

    return bytesImage;
  }




}


