import 'package:flutter/material.dart';

class SS extends StatefulWidget {
  const SS({super.key});

  @override
  State<SS> createState() => _SSState();
}

class _SSState extends State<SS> {

  
  // @override
  // void initState() {
  //   // TODO: implement initState
      
  //   SystemChrome.setPreferredOrientations([
  //     DeviceOrientation.landscapeRight, 
  //     DeviceOrientation.landscapeLeft, 
  //   ]
  //   );
  //   super.initState(); 
  // }

  // @override
  // void dispose() {
  // //  TODO: implement dispose
  //   SystemChrome.setPreferredOrientations(
  //     [
  //     // DeviceOrientation.landscapeRight, 
  //     //  DeviceOrientation.landscapeLeft, 
  //      DeviceOrientation.portraitUp, 
  //      DeviceOrientation.portraitDown
  //   ]
  //   );
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      body: OrientationBuilder(builder: (context, orientation){
        if(orientation== Orientation.landscape){
          return const Center(child: Text('Landscape mode'),);
        }

        else{
          return const Center(child: Text('Normal mode'),);
        }
      }),
             
        );
      }
}