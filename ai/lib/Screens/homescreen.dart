
import 'dart:developer';
import 'dart:typed_data';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:ai/Models/ai_models.dart';
import 'package:ai/Screens/chat_view.dart';
import 'package:ai/Screens/text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
List<AiModel> aimodels=[];
final TextEditingController search=TextEditingController();
final gemini=Gemini.instance;
List<Uint8List> image=[];
      final ImagePicker imagepicker= ImagePicker();
      bool loading = false;

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
   
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
       centerTitle: true,
        title:const Text("APNA AI",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        ),
      ),
      body: Column(
        children: [
       
        Expanded(
          child: Visibility(
            replacement:const Center(child: Text("How can I help you today?")),
            visible: aimodels.isNotEmpty,
            child:  
            SingleChildScrollView(
              reverse: true,
              child: ListView.separated(
                shrinkWrap: true,
                physics:const NeverScrollableScrollPhysics(),
                itemBuilder: (context,index){
                  return ChatView(aimodels: aimodels[index]);
                }, 
                separatorBuilder: (context,i)=>const SizedBox(height: 10,), 
                itemCount: aimodels.length),
            )
            
            
            ),
        ),
        Visibility(
          visible: loading,
          child:const SizedBox(
            height:60,
            child:  LoadingIndicator(
                indicatorType: Indicator.ballBeat, /// Required, The loading type of the widget
                colors:  [Colors.purple,Colors.cyan],       /// Optional, The color collections
                strokeWidth: 0.5,                     /// Optional, The stroke of the line, only applicable to widget which contains line
                  /// Optional, the stroke backgroundColor
            ),
          )
         ),
          InputField(
            image: image,
            search: search, selectimage: () async{
      final List<XFile> files = await imagepicker.pickMultiImage();
          if (files.isNotEmpty) {
            for (final img in files) {
              image.add(await img.readAsBytes());
              setState(() {});
            }
           
          } 
          }, onsend: (){
            aimodels.add(AiModel(
              isUser: true,
              text: search.text.toString(),
              images: image
              
            ));
            loading=true;
            List<Uint8List> img=image;
            image=[];
            String edit=search.text.toString();
            search.clear();
            setState(() {});

            gemini.streamGenerateContent(edit,images: img)
                .listen((value) {
 loading=false;
                  if (aimodels.last.isUser ==true) {
                       aimodels.add(AiModel(
              isUser: false,
              text: value.output,
              images: []

            ));
                  }

                aimodels.last.text="${aimodels.last.text}${value.output}";
               
            setState(() {});
              }).onError((e) {
            log('streamGenerateContent exception', error: e);
                        });
          }, )
        ]
      ) ,
    );
  }
}
