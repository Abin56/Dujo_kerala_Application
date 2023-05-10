import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/controllers/userCredentials/user_credentials.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class StudentShowTimeTable extends StatefulWidget {
  const StudentShowTimeTable({super.key,
  });

  @override
  State<StudentShowTimeTable> createState() => _StudentShowTimeTableState();
}

class _StudentShowTimeTableState extends State<StudentShowTimeTable> {
  List<String> periodList = [
    'firstPeriod',
    'secondPeriod',
    'thirdPeriod',
    'fourthPeriod',
    'fifthPeriod',
    'sixthPeriod',
    'seventhPeriod'
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();  
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight, 
       DeviceOrientation.landscapeLeft, 
    ]
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    SystemChrome.setPreferredOrientations(
      [
      DeviceOrientation.landscapeRight, 
       DeviceOrientation.landscapeLeft, 
       DeviceOrientation.portraitUp, 
       DeviceOrientation.portraitDown
    ]
    );
    super.dispose();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold( appBar: AppBar(backgroundColor: adminePrimayColor),
        body: Center(
          child: 
          StreamBuilder(
            stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!).doc(UserCredentialsController.batchId).collection('classes').doc(UserCredentialsController.classId).collection('TimeTables').snapshots(),
            builder: (context, snapshot) {
              if(snapshot.hasData){
                  return ListView.separated( 
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
                              color: Colors.orange,
                              child: Center(
                                child: Text(snapshot.data!.docs.where((element) => element.id=="Monday").first [ periodList[index]][ periodList[index]]),
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
                              color: Colors.orange,
                              child: Center(
                               child: Text(snapshot.data!.docs.where((element) => element.id=="Tuesday").first [ periodList[index]] [ periodList[index]]),
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
                              color: Colors.orange,
                              child: Center(
                               child: Text(snapshot.data!.docs.where((element) => element.id=="Wednesday").first[ periodList[index]] [ periodList[index]]),
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
                              color: Colors.orange,
                              child: Center(
                                child: Text(snapshot.data!.docs.where((element) => element.id=="Thursday").first[ periodList[index]] [ periodList[index]]),
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
                              color: Colors.orange,
                              child: Center(
                                child: Text(snapshot.data!.docs.where((element) => element.id=="Friday").first[ periodList[index]] [ periodList[index]]),
                              //   child: Text(widget.fri.data()![(index == 3)
                              //       ? 'fouthPeriod'
                                    
                              //       : periodList[index]][periodList[index]]),
                              // ),
                            ),
                          ),
                      )],
                      ),
                    );
                  }); 
              }  
              if(!snapshot.hasData){
                return const Center(child: Text('No Timetable Added'),);
              }
              return const Center(child: CircularProgressIndicator(),);
            }
          ),
        ));
  }
}