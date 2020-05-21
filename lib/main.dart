import 'dart:convert';
import 'dart:ffi';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'flutterkquiz.dart';
import 'quizmaster.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home: homescreen(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: Colors.white),
    );
  }

}
class homescreen extends StatefulWidget{
  @override
  _HomeScreenState createState() =>_HomeScreenState();
  
  
  }
  
  class _HomeScreenState extends State<homescreen>{
  
  FlutterKerala api;
  String eventname;
  List <QuizQuestions> QAs;
  int Qno;
  Future<void> fetch() async{
    var apireturn = await http.get("http://www.mocky.io/v2/5ebd2f5f31000018005b117f");
    var jsonDecoded =jsonDecode(apireturn.body);
    print(jsonDecoded.runtimeType);
    api=FlutterKerala.fromJson(jsonDecoded);
    QAs=api.quizQuestions;
    eventname=api.eventConductedBy;
    
  }
  @override
  void initState() {
    // TODO: implement initState
    Qno=0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Qi-zapp"),
        elevation:0.0,
      ),
      body: FutureBuilder(
          future:fetch(),
          builder: (BuildContext context, AsyncSnapshot snapshot){
            switch (snapshot.connectionState){
              case ConnectionState.waiting:return Center(child:CircularProgressIndicator());
              case ConnectionState.done:return QuizMaster(QAs);             
                          }
                        }              
                      ),
                  );
                  
                }
              
             
                 

}

