import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qizap/flutterkquiz.dart';

class QuizMaster extends StatefulWidget {
  List<QuizQuestions> QAs;
  QuizMaster(List<QuizQuestions> qAs) {
    QAs = qAs;
  }

  @override
  _QuizMasterState createState() => _QuizMasterState();
}

class _QuizMasterState extends State<QuizMaster> {
  List<QuizQuestions> QAs;
  int Qno;
  int points;
  @override
  void initState() {
    QAs = widget.QAs;
    Qno = 0;
    points = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      Container(
        margin: const EdgeInsets.all(15.0),
        child: Text(QAs[Qno].questions,style: DefaultTextStyle.of(context).style.apply(fontSizeFactor: 2.0),),
      ),
      Expanded(
          child: ListView.builder(
              itemCount: QAs[Qno].answers.length,
              itemBuilder: (BuildContext context, int index) {
                return InkWell(
                    onTap: () => _nextquestion(index, context),
                    child: ListTile(
                      title: Text(QAs[Qno].answers[index].answers),
                    ));
              }))
    ]);
  }

  void _nextquestion(int selected, BuildContext context) {
    Qno++;
    if ((Qno) < QAs.length) {
      setState(() {
        print(QAs[Qno].answers[selected].isTrue);
        if (QAs[Qno].answers[selected].isTrue == true) {
          points++;
          print(points);
        }
      });
    } else {
      
      Widget okButton = FlatButton(
        child: Text("OK"),
        onPressed: () {SystemNavigator.pop();},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        content: Text("you scored " +
            points.toString() +
            " out of " +
            QAs.length.toString()),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
        barrierDismissible: false
      );
    }
  }
}
