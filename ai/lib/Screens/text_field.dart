import 'dart:typed_data';

import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  
  final TextEditingController search;
  final VoidCallback selectimage,onsend;
  final List<Uint8List> image;
  const InputField({super.key, required this.search, required this.selectimage, required this.onsend, required this.image});

  @override
  Widget build(BuildContext context) {
          
    return    Container(
                margin:const EdgeInsets.all(8),
                decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.inversePrimary.withOpacity(0.4),
                borderRadius: BorderRadius.circular(15),
                ),
            child: Column(
              children: [

                  Visibility(
                    visible: image.isNotEmpty,
                    child: SizedBox(
                      height: 120,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.all(8),
                        itemBuilder: (context,index){
                        return Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            image: DecorationImage(
                              
                              fit: BoxFit.cover,
                              image: MemoryImage(image[index]))
                          ),
                        );
                      }, 
                      separatorBuilder: (context,i)=> const SizedBox(width: 10,), 
                      itemCount: image.length),
                    ),
                  )
                ,Row(
                  children: [
                    IconButton(onPressed: selectimage, icon:const Icon(Icons.image)),
                    Expanded(child: TextFormField(
                      controller: search,
                      maxLines: 5,
                      minLines: 1,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Enter the prompt here',
                      )
                    )),
                     Container(
                      margin:const EdgeInsets.all(8),
                     decoration: BoxDecoration(
                       color: Theme.of(context).colorScheme.inversePrimary,
                       shape: BoxShape.circle,
                     ),
                      child: IconButton(onPressed: onsend, icon:const Icon(Icons.send_outlined)))
                  ],
                )
              ]
            ),
          )   ;
  }
}