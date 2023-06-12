import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:flutter/material.dart';

import '../../../../controllers/userCredentials/user_credentials.dart';

class SS extends StatefulWidget {
  const SS({super.key});

  @override
  State<SS> createState() => _SSState();
}

class _SSState extends State<SS> with SingleTickerProviderStateMixin{



  
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

  TabController? _tabController; 

  List<String> periodList = [
    'firstPeriod',
    'secondPeriod',
    'thirdPeriod',
    'fourthPeriod',
    'fifthPeriod',
    'sixthPeriod',
    'seventhPeriod'
  ]; 

  
  List<String>periodNumbers = [
    '1', '2', '3', '4', '5', '6', '7'
  ]; 

  List<String>days = ['Monday', 
  'Tuesday', 'Wednesday', 'Thursday', 'Friday'];


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
      _tabController = TabController(length: 5, vsync: this);
    
    
  }

    @override
  void dispose() {
    // TODO: implement dispose
    _tabController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
   appBar: AppBar(
    title: const Text('Time Table'),
    backgroundColor: adminePrimayColor,
    bottom:  TabBar(
      controller: _tabController,
            tabs: const [
              Tab(text: 'MON'),
              Tab(text: 'TUE'),
              Tab(text: 'WED'),
               Tab(text: 'THUR'),
              Tab(text: 'FRI'),

            ],
          ),
        ),
        body:  TabBarView(
          controller: _tabController,
          children: [
            PeriodShowingWidget(periodList: periodList, dayName: days[0]),
            PeriodShowingWidget(periodList: periodList, dayName: days[1]),
            PeriodShowingWidget(periodList: periodList, dayName: days[2]),
            PeriodShowingWidget(periodList: periodList, dayName: days[3]),
            PeriodShowingWidget(periodList: periodList, dayName: days[4]),
          ],
        ),
   );
      }
}

class PeriodShowingWidget extends StatelessWidget {
   PeriodShowingWidget({
    super.key,
    required this.periodList, required this.dayName
  });

  final List<String> periodList;
  String dayName;

  @override
  Widget build(BuildContext context) {
    return Center(child: StreamBuilder(
      stream: FirebaseFirestore.instance.collection('SchoolListCollection').doc(UserCredentialsController.schoolId).collection(UserCredentialsController.batchId!).doc(UserCredentialsController.batchId).collection('classes').doc(UserCredentialsController.classId).collection('TimeTables').snapshots(),
      builder: ((context, snapshot) {
        if(snapshot.hasData){
           return ListView.separated(itemBuilder: ((context, index) {
          return (snapshot.data!.docs.isEmpty)? const Text(''): Padding(
            padding: const EdgeInsets.only(right: 10, left: 10),
            child: SizedBox(
              height: 80,
              child: Card(
                color: adminePrimayColor,
                
                child: Center(child: Text(snapshot.data!.docs.where((element) => element.id== dayName).first [ periodList[index]][ periodList[index]], style: const TextStyle(color: Colors.white, fontSize: 18),)))),
          );
        }) , separatorBuilder: (context, index){
          return const SizedBox(height: 10,);
        }, itemCount: 7);
        }

        return const Text('data');
      
      })));
  }
}

