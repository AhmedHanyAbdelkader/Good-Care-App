import 'package:flutter/material.dart';
import 'package:graduation_project/report_result_page.dart';
import 'package:graduation_project/resources/color_manager.dart';
import 'package:im_stepper/stepper.dart';


class ReportDataPage extends StatefulWidget {
  static String id ="ReportDataPage";
  @override
  _IconStepperDemo createState() => _IconStepperDemo();
}

class _IconStepperDemo extends State<ReportDataPage> {
  // THE FOLLOWING TWO VARIABLES ARE REQUIRED TO CONTROL THE STEPPER.
  int activeStep = 0; // Initial step set to 5.
  int upperBound = 2; // upperBound MUST BE total number of icons minus 1.

  TextEditingController radiusMeanController    = TextEditingController();
  TextEditingController textureMeanController   = TextEditingController();
  TextEditingController perimeterMeanController = TextEditingController();
  TextEditingController areaMeanController      = TextEditingController();
  TextEditingController perimeterSeController   = TextEditingController();
  TextEditingController areaSeController        = TextEditingController();
  TextEditingController radiusWorstController   = TextEditingController();
  TextEditingController textureWorstController  = TextEditingController();
  TextEditingController perimeterWorstController= TextEditingController();
  TextEditingController areaWorstController     = TextEditingController();

  var myMap;

  final _formKey1 = GlobalKey<FormState>();
  final _formKey2 = GlobalKey<FormState>();
  final _formKey3 = GlobalKey<FormState>();

  @override
  void initState() {
    final   Map<int , Widget> _map = {
      0: myColumn1(),
      1: myColumn2(),
      2: myColumn3(),
    };
    myMap= _map;
    super.initState();
  }

  @override
  void dispose() {
    radiusMeanController.dispose;
    textureMeanController.dispose;
    perimeterMeanController.dispose;
    areaMeanController.dispose;
    perimeterSeController.dispose;
    areaSeController.dispose;
    radiusWorstController.dispose;
    textureWorstController.dispose;
    perimeterWorstController.dispose;
    areaWorstController.dispose;
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
          title:const Text('write the report data '),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              IconStepper(
                icons: const [
                  Icon(Icons.article_rounded,),
                  Icon(Icons.add_moderator),
                  Icon(Icons.fact_check),
                ],

                // activeStep property set to activeStep variable defined above.
                activeStep: activeStep,
                activeStepColor: ColorManager.pink,
                lineColor: Colors.black,
                activeStepBorderColor: ColorManager.pink,
                enableNextPreviousButtons: false,
                enableStepTapping: false,

                // This ensures step-tapping updates the activeStep.
                onStepReached: (index) {
                  setState(() {
                    activeStep = index;
                    print(index);
                  });
                },
              ),
              header(),
              Expanded(
                child: Center(child: myMap[activeStep],),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  previousButton(),
                  cancelButton(),
                  nextButton(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Returns the next button.
  Widget nextButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.blue,
      ),
      onPressed: () {
        ///
        if(activeStep==0 && _formKey1.currentState!.validate()) {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          }
          else {
            Navigator.of(context)
                .push(
                MaterialPageRoute(builder: (context) => ReportResultPage()))
                .then((value) => dispose());
          }
        }
        ///
        else if(activeStep==1 && _formKey2.currentState!.validate()) {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          }
          else {
            Navigator.of(context)
                .push(
                MaterialPageRoute(builder: (context) => ReportResultPage()))
                .then((value) => dispose());
          }
        }
        ///
        else if(activeStep==2 && _formKey3.currentState!.validate()) {
          // Increment activeStep, when the next button is tapped. However, check for upper bound.
          if (activeStep < upperBound) {
            setState(() {
              activeStep++;
            });
          }
          else {
            Navigator.of(context)
                .push(
                MaterialPageRoute(builder: (context) => ReportResultPage()))
                .then((value) => dispose());
          }
        }
      },
      child: activeStep<2 ? const Text('Next') : const Text('Result') ,
    );
  }

  /// Returns the cancel button
  Widget cancelButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.blue,
      ),
      onPressed: () {
          Navigator.of(context).pop();
      },
      child:const Text('Cancel'),
    );
  }

  /// Returns the previous button.
  Widget previousButton() {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: ColorManager.blue,
      ),
      onPressed: () {
        // Decrement activeStep, when the previous button is tapped. However, check for lower bound i.e., must be greater than 0.
        if (activeStep > 0) {
          setState(() {
            activeStep--;
          });
        }else{
          Navigator.of(context).pop();
        }
      },
      child: const Text('Prev'),
    );
  }

  /// Returns the header wrapping the header text.
  Widget header() {
    return Container(
      decoration: BoxDecoration(
        color: ColorManager.blue,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              headerText(),
              style:const TextStyle(
                color: ColorManager.white,
                fontSize: 20,
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Returns the header text based on the activeStep.
  String headerText() {
    switch (activeStep) {
      case 0:
        return 'step 1';
      case 1:
        return 'step 2';
      default:
        return 'step 3';
    }
  }

  /// wwwwwwwwwwwwwwwwwwwww


  Widget myColumn1(){
    return SingleChildScrollView(
      child: Form(
        key: _formKey1,
        child: Column(
          children: [
            myField(radiusMeanController, 'radius mean'),
            myField(textureMeanController, 'texture mean'),
            myField(perimeterMeanController, 'perimeter mean'),
            myField(areaMeanController, 'area mean'),
          ],
        ),
      ),
    );
  }
  Widget myColumn2(){
    return SingleChildScrollView(
      child: Form(
        key: _formKey2,
        child: Column(
          children: [
            myField(perimeterSeController, 'perimeter se'),
            myField(areaSeController, 'area se'),
            myField(radiusWorstController, 'radius worst'),
            myField(textureWorstController, 'texture worst'),
          ],
        ),
      ),
    );
  }
  Widget myColumn3(){
    return SingleChildScrollView(
      child: Form(
        key: _formKey3,
        child: Column(
          children: [
            myField(perimeterWorstController, 'perimeter worst'),
            myField(areaWorstController, 'area worst'),
          ],
        ),
      ),
    );
  }

  Widget myField(controller,label){
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: 150,
        height: 60,
        decoration: BoxDecoration(
          color: ColorManager.pink2,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: ColorManager.blue,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: TextFormField(
            keyboardType: TextInputType.number,
            cursorColor: ColorManager.pink,
            controller: controller,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'empty cell';
              }
              return null;
            },
            onChanged: (value) => value = controller.text,
            minLines: 1,
            decoration: InputDecoration(
                label:  Text('$label'),
                labelStyle:const TextStyle(color: ColorManager.white),
                border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}




