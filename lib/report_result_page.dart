import 'package:flutter/material.dart';

import 'home_page.dart';

class ReportResultPage extends StatelessWidget {
  static String id ="ReportResultPage";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back),
          onPressed: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context)=>HomePage()));
          },
        ),
        title:const Text('Result'),
      ),
      body: Column(

      ),
    );
  }
}
