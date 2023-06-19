import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_utils/get_utils.dart';

class StudentShowTimeTable extends StatefulWidget {
  const StudentShowTimeTable({super.key,
  });

  @override
  State<StudentShowTimeTable> createState() => _StudentShowTimeTableState();
}

class _StudentShowTimeTableState extends State<StudentShowTimeTable> {
  List<String> periodList = [
    'First Period',
    'Second Period',
    'Third Period',
    'Fourth Period',
    'Fifth Period',
    'Sixth Period',
    'Seventh Period',
    'Eighth Period',
    'Ninth Period ',
    'Tenth Period',
  ]; 

  List<String>periodNumbers = [
    '1', '2', '3', '4', '5', '6', '7','8','9','10'
  ]; 

  List<String>days = [
    'Monday', 
  'Tuesday', 
  'Wednesday',
   'Thursday',
    'Friday' ,
    'Saturday'
    
    ];

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
    var screenSize = MediaQuery.of(context).size;
    return Scaffold( appBar: AppBar(backgroundColor: adminePrimayColor, title:  Text('Time Table'.tr),),
        body: Center(
          child: 
          ListView( 
            scrollDirection: Axis.horizontal,
            children: [ 
              // ListView( 
              //   shrinkWrap: true,
              //   physics: const ClampingScrollPhysics(),
              //   children: [
              //     Flexible(
              //                       child: Container(
              //                         width: 100, 
              //                         height: 100,
              //                         color: const Color.fromARGB(255, 141, 188, 226),
              //                         child:  Center(
              //                           child: Text(periodNumbers[0], style: const TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
              //                           //     ? 'fouthPeriod'
              //                           //     : periodList[index]][periodList[index]]),
              //                         ),
              //                       ),
              //                     ),
              //                     Flexible(
              //                       child: Container(
              //                         width: 100, 
              //                         height: 100,
              //                         color: const Color.fromARGB(255, 141, 188, 226),
              //                         child:  Center(
              //                           child: Text(periodNumbers[0], style: const TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
              //                           //     ? 'fouthPeriod'
              //                           //     : periodList[index]][periodList[index]]),
              //                         ),
              //                       ),
              //                     ),
              //                     Flexible(
              //                       child: Container(
              //                         width: 100, 
              //                         height: 100,
              //                         color: const Color.fromARGB(255, 141, 188, 226),
              //                         child:  Center(
              //                           child: Text(periodNumbers[0], style: const TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
              //                           //     ? 'fouthPeriod'
              //                           //     : periodList[index]][periodList[index]]),
              //                         ),
              //                       ),
              //                     ),
              //                     Flexible(
              //                       child: Container(
              //                         width: 100, 
              //                         height: 100,
              //                         color: const Color.fromARGB(255, 141, 188, 226),
              //                         child:  Center(
              //                           child: Text(periodNumbers[0], style: const TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
              //                           //     ? 'fouthPeriod'
              //                           //     : periodList[index]][periodList[index]]),
              //                         ),
              //                       ),
              //                     ),
              //                     Flexible(
              //                       child: Container(
              //                         width: 100, 
              //                         height: 100,
              //                         color: const Color.fromARGB(255, 141, 188, 226),
              //                         child:  Center(
              //                           child: Text(periodNumbers[0], style: const TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
              //                           //     ? 'fouthPeriod'
              //                           //     : periodList[index]][periodList[index]]),
              //                         ),
              //                       ),
              //                     ),
              //   ],
              // ), 
              
              StreamBuilder(
                stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!).doc(UserCredentialsController.batchId).collection('classes').doc(UserCredentialsController.classId).collection('TimeTables').snapshots(),
                builder: (context, snapshot) {
                  if(snapshot.hasData){ 

                    // if(snapshot.data!.docs.isEmpty){
      
                    //  return  Center(child: Text('No Timetable Added', style: GoogleFonts.poppins(fontWeight: FontWeight.bold,color: cWhite),));
                    // }
                    
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: [
                           Padding(
                            padding: const EdgeInsets.all(10),
                             child: Column(
                               mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Flexible(
                                   child: Container(
                                                                 width: 100, 
                                                                 height: 100,
                                                                 color: const Color.fromARGB(255, 141, 188, 226),
                                                                 child:  const Center(
                                    child: Text('DAY', style: TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
                                    //     ? 'fouthPeriod'
                                    //     : periodList[index]][periodList[index]]),
                                                                 ),
                                                               ),
                                 ), 
                               Flexible(
                                 child: Container(
                                  width: 100, 
                                  height: 100,
                                  color: const Color.fromARGB(255, 141, 188, 226),
                                  child:  const Center(
                                    child: Text('Monday', style: TextStyle(fontWeight: FontWeight.bold,color: cWhite,),),
                                    //     ? 'fouthPeriod'
                                    //     : periodList[index]][periodList[index]]),
                                  ),
                                                             ),
                               ), 
                               Flexible(
                                 child: Container(
                                  width: 100, 
                                  height: 100,
                                  color: const Color.fromARGB(255, 141, 188, 226),
                                  child:  const Center(
                                    child: Text('Tuesday', style: TextStyle(fontWeight: FontWeight.bold,color: cWhite,),),
                                    //     ? 'fouthPeriod'
                                    //     : periodList[index]][periodList[index]]),
                                  ),
                                                             ),
                               ), 
                               Flexible(
                                 child: Container(
                                  width: 100, 
                                  height: 100,
                                  color: const Color.fromARGB(255, 141, 188, 226),
                                  child:  const Center(
                                    child: Text('Wednesday', style: TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
                                    //     ? 'fouthPeriod'
                                    //     : periodList[index]][periodList[index]]),
                                  ),
                                                             ),
                               ), 
                               Flexible (
                                 child: Container(
                                  width: 100, 
                                  height: 100,
                                  color: const Color.fromARGB(255, 141, 188, 226),
                                  child:  const Center(
                                    child: Text('Thursday', style: TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
                                    //     ? 'fouthPeriod'
                                    //     : periodList[index]][periodList[index]]),
                                  ),
                                                             ),
                               ), 
                               Flexible (
                                 child: Container(
                                  width: 100, 
                                  height: 100,
                                  color: const Color.fromARGB(255, 141, 188, 226),
                                  child:  const Center(
                                    child: Text('Friday', style: TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
                                    //     ? 'fouthPeriod'
                                    //     : periodList[index]][periodList[index]]),
                                  ),
                                                             ),
                               ), 
                              ],
                             ),
                           ),
                            ListView.separated( 
                                          shrinkWrap: true, 
                                          physics: const ScrollPhysics(),
                            separatorBuilder: (context, index) {
                              return const SizedBox(height: 10,);
                            },
                            scrollDirection: Axis.horizontal,
                            itemCount: 7,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    
                                    Flexible(
                                      child: Container(
                                        width: 100, 
                                        height: 100,
                                        color: const Color.fromARGB(255, 141, 188, 226),
                                        child:  Center(
                                          child:(snapshot.data!.docs.isEmpty)?  Text('',style: TextStyle(fontSize: 13.w),): Text(periodNumbers[index], style: const TextStyle(fontWeight: FontWeight.bold,color: cWhite),),
                                          //     ? 'fouthPeriod'
                                          //     : periodList[index]][periodList[index]]),
                                        ),
                                      ),
                                    ), 
                                    Flexible(
                                      child: Container(
                                        width: 100, 
                                        height: 100,
                                        color: const Color.fromARGB(255, 141, 188, 226),
                                        child: Center(
                                          child:(snapshot.data!.docs.isEmpty)?  Text('',style: TextStyle(fontSize: 13.w),): Text(snapshot.data!.docs.where((element) => element.id=="Monday").first [ periodList[index]][ periodList[index]]),
                                          // child: Text(widget.mon.data()![(index == 3)
                                          //     ? 'fouthPeriod'
                                          //     : periodList[index]][periodList[index]]),
                                        ),
                                      ),
                                    ), 
                                    Flexible(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        color: const Color.fromARGB(255, 141, 188, 226),
                                        child: Center(
                                         child: (snapshot.data!.docs.isEmpty)?  Text('',style: TextStyle(fontSize: 13.w),): Text(snapshot.data!.docs.where((element) => element.id=="Tuesday").first [ periodList[index]] [ periodList[index]]),
                                          // child: Text(widget.tues.data()![(index == 3)
                                          //     ? 'fouthPeriod'
                                          //     : periodList[index]][periodList[index]]),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: 100, 
                                        height: 100,
                                        color: const Color.fromARGB(255, 141, 188, 226),
                                        child: Center(
                                         child:(snapshot.data!.docs.isEmpty)?  Text('',style: TextStyle(fontSize: 13.w),): Text(snapshot.data!.docs.where((element) => element.id=="Wednesday").first[ periodList[index]] [ periodList[index]]),
                                          // child: Text(widget.wed.data()![(index == 3)
                                          //     ? 'fouthPeriod'
                                          //     : periodList[index]][periodList[index]]),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: 100, 
                                        height: 100,
                                        color: const Color.fromARGB(255, 141, 188, 226),
                                        child: Center(
                                          child:(snapshot.data!.docs.isEmpty)?  Text('',style: TextStyle(fontSize: 13.w),): Text(snapshot.data!.docs.where((element) => element.id=="Thursday").first[ periodList[index]] [ periodList[index]]),
                                          // child: Text(widget.thurs.data()![(index == 3)
                                          //     ? 'fouthPeriod'
                                          //     : periodList[index]][periodList[index]]),
                                        ),
                                      ),
                                    ),
                                    Flexible(
                                      child: Container(
                                        width: 100,
                                        height: 100,
                                        color: const Color.fromARGB(255, 141, 188, 226),
                                        child: Center(
                                          child:(snapshot.data!.docs.isEmpty)?  Text('',style: TextStyle(fontSize: 13.w),): Text(snapshot.data!.docs.where((element) => element.id=="Friday").first[ periodList[index]] [ periodList[index]]),
                                        //   child: Text(widget.fri.data()![(index == 3)
                                        //       ? 'fouthPeriod'
                                              
                                        //       : periodList[index]][periodList[index]]),
                                        // ),
                                      ),
                                    ),
                                )],
                                ),
                              );
                            }),
                          ],
                        ),
                      ); 
                  }  
                  if(!snapshot.hasData){
                    return const Center(child: Text('No Time table Added'),);
                  }
                  return const Center(child: CircularProgressIndicator(),);
                }
              ),
            ],
          ),
        ));
  }
}