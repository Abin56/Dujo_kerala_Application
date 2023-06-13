import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dujo_kerala_application/view/colors/colors.dart';
import 'package:dujo_kerala_application/view/widgets/fonts/google_monstre.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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

  List<String> teachersList = ['firstPeriodTeacher', 'secondPeriodTeacher', 'thirdPeriodTeacher', 'fourthPeriodTeacher','fifthPeriodTeacher', 'sixthPeriodTeacher', 'seventhPeriodTeacher'];

  
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
    title: GoogleMonstserratWidgets(text: 'Time Table', fontsize: 17, color: adminePrimayColor, fontWeight: FontWeight.bold,),
     iconTheme: const IconThemeData(
    color: adminePrimayColor //change your color here
  ),
    backgroundColor: Colors.transparent,
    elevation: 0,
    bottom:  TabBar(
      unselectedLabelColor:adminePrimayColor,
      unselectedLabelStyle: GoogleFonts.montserrat(fontSize: 12),
      dividerColor: adminePrimayColor,
      indicator: BoxDecoration(color: adminePrimayColor, borderRadius: BorderRadius.circular(50)),
      labelStyle: GoogleFonts.montserrat(fontSize: 13, fontWeight: FontWeight.w500),
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
            PeriodShowingWidget(periodList: periodList, dayName: days[0], teacherList: teachersList),
            PeriodShowingWidget(periodList: periodList, dayName: days[1], teacherList: teachersList),
            PeriodShowingWidget(periodList: periodList, dayName: days[2], teacherList: teachersList),
            PeriodShowingWidget(periodList: periodList, dayName: days[3], teacherList: teachersList),
            PeriodShowingWidget(periodList: periodList, dayName: days[4], teacherList: teachersList),
          ],
        ),
   );
      }
}

class PeriodShowingWidget extends StatelessWidget {
   PeriodShowingWidget({
    super.key,
    required this.periodList, required this.dayName, required this.teacherList
  });

  final List<String> periodList;
  List<String> teacherList;
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
                elevation: 5,
                color: Colors.white.withOpacity(0.9),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  
                  children: [
                   
                   Padding(
                     padding: const EdgeInsets.only(left: 10.0),
                     child: Container(
                      
                      color: adminePrimayColor,child: Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GoogleMonstserratWidgets(text: 'Hour : ${index+1}', fontsize: 12, fontWeight: FontWeight.bold,color: Colors.white,),
                      ),),
                   ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          snapshot.data!.docs.where((element) => element.id== dayName).first [ periodList[index]][ periodList[index]] == ''?  GoogleMonstserratWidgets(text: 'No Period Added', fontsize: 16, color: adminePrimayColor, fontWeight: FontWeight.w500,) : GoogleMonstserratWidgets(text: snapshot.data!.docs.where((element) => element.id== dayName).first [ periodList[index]][ periodList[index]], color: adminePrimayColor, fontsize: 16, fontWeight: FontWeight.w500,),
                          snapshot.data!.docs.where((element) => element.id== dayName).first [ periodList[index]][ teacherList[index]] == ''? const SizedBox(): GoogleMonstserratWidgets(text: 'Teacher : '+ snapshot.data!.docs.where((element) => element.id== dayName).first [ periodList[index]][ teacherList[index]], color: adminePrimayColor.withOpacity(0.7), fontsize: 13, fontWeight: FontWeight.w500,),
                        ],
                      ),
                    ),
                  ],
                ))),
          );
        }) , separatorBuilder: (context, index){
          return const SizedBox(height: 10,);
        }, itemCount: 7);
        }

        return const Text('No data');
      
      })));
  }
}

