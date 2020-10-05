import 'package:flutter/material.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        accentColor: Colors.red,
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String courseName;
  int coursecredit = 1;
  double courseLetterGrade = 4;
  List<Course> allCourses;

  static int counter = 0;

  var formKey = GlobalKey<FormState>();
  double gpa = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    allCourses = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Calculate GPA"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (formKey.currentState.validate()) {
            formKey.currentState.save();
          }
        },
        child: Icon(Icons.add),
      ),
      body: OrientationBuilder(builder: (context, orientation) {
        if (orientation == Orientation.portrait) {
          return appmain();
        } else
          return appmainLandscape();
      }),
    );
  }

  Widget appmain() {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          //statik form
          Container(
            padding: EdgeInsets.all(10),
            color: Colors.blue.shade200,
            child: Form(
              key: formKey,
              child: Column(
                children: <Widget>[
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: "Course Name",
                      hintText: "Enter Course Name",
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      for (int i = 0; i < allCourses.length; i++) {
                        if (value == allCourses[i].name) {
                          return "You cannot add same lecture twice ";
                        }
                      }

                      if (value.length > 0) {
                        return null;
                      } else
                        return "Course name cannot be empty";
                    },
                    onSaved: (valuesave) {
                      courseName = valuesave;
                      setState(() {
                        allCourses.add(Course(courseName, courseLetterGrade,
                            coursecredit, RandomColor()));
                        gpa = 0;
                        CalculateGpa();
                      });
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<int>(
                              items: creditItems(),
                              value: coursecredit,
                              onChanged: (choosenCredit) {
                                setState(() {
                                  coursecredit = choosenCredit;
                                });
                              },
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)))),
                      Container(
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton<double>(
                              items: courseGradeLetterItems(),
                              value: courseLetterGrade,
                              onChanged: (choosenLetter) {
                                setState(() {
                                  courseLetterGrade = choosenLetter;
                                });
                              },
                            ),
                          ),
                          padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))))
                    ],
                  ),
                ],
              ),
            ),
          ),
          Container(
            height: 70,
            decoration: BoxDecoration(
                border: BorderDirectional(
              top: BorderSide(color: Colors.blue, width: 2),
              bottom: BorderSide(color: Colors.blue, width: 2),
            )),
            child: Center(
              child: RichText(
                textAlign: TextAlign.center,
                text: TextSpan(children: [
                  TextSpan(
                      text: "GPA :",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                  TextSpan(
                      text: allCourses.length == 0
                          ? "0"
                          : "${gpa.toStringAsFixed(2)}",
                      style: TextStyle(fontSize: 20, color: Colors.black)),
                ]),
              ),
            ),
          ),
          //dinamik liste
          Expanded(
              child: Container(
                  color: Colors.blue.shade100,
                  child: ListView.builder(
                    itemBuilder: _makeListItems,
                    itemCount: allCourses.length,
                  ))),
        ],
      ),
    );
  }

  Widget appmainLandscape() {
    return Container(
        child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Expanded(
          child: //statik form
              Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                color: Colors.blue.shade200,
                child: Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: "Course Name",
                          hintText: "Enter Course Name",
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          for (int i = 0; i < allCourses.length; i++) {
                            if (value == allCourses[i].name) {
                              return "You cannot add  same lecture twice ";
                            }
                          }

                          if (value.length > 0) {
                            return null;
                          } else
                            return "Course name cannot be empty";
                        },
                        onSaved: (valuesave) {
                          courseName = valuesave;
                          setState(() {
                            allCourses.add(Course(courseName, courseLetterGrade,
                                coursecredit, RandomColor()));
                            gpa = 0;
                            CalculateGpa();
                          });
                        },
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<int>(
                                  items: creditItems(),
                                  value: coursecredit,
                                  onChanged: (choosenCredit) {
                                    setState(() {
                                      coursecredit = choosenCredit;
                                    });
                                  },
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)))),
                          Container(
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<double>(
                                  items: courseGradeLetterItems(),
                                  value: courseLetterGrade,
                                  onChanged: (choosenLetter) {
                                    setState(() {
                                      courseLetterGrade = choosenLetter;
                                    });
                                  },
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 4),
                              margin: EdgeInsets.only(top: 10),
                              decoration: BoxDecoration(
                                  border:
                                      Border.all(color: Colors.blue, width: 2),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Container(
                  height: 70,
                  decoration: BoxDecoration(
                      border: BorderDirectional(
                    top: BorderSide(color: Colors.blue, width: 2),
                    bottom: BorderSide(color: Colors.blue, width: 2),
                  )),
                  child: Center(
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: [
                        TextSpan(
                            text: "GPA :",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                        TextSpan(
                            text: allCourses.length == 0
                                ? "0"
                                : "${gpa.toStringAsFixed(2)}",
                            style:
                                TextStyle(fontSize: 20, color: Colors.black)),
                      ]),
                    ),
                  ),
                ),
              ),
            ],
          ),
          flex: 1,
        ),
        Expanded(
            child: Container(
                color: Colors.blue.shade100,
                child: ListView.builder(
                  itemBuilder: _makeListItems,
                  itemCount: allCourses.length,
                ))),
      ],
    ));
  }

  List<DropdownMenuItem<int>> creditItems() {
    List<DropdownMenuItem<int>> credits = [];
    for (int i = 1; i < 11; i++) {
      credits.add(DropdownMenuItem<int>(
        value: i,
        child: Text("$i Credit", style: TextStyle(fontSize: 20)),
      ));
    }
    return credits;
  }

  List<DropdownMenuItem<double>> courseGradeLetterItems() {
    List<DropdownMenuItem<double>> letters = [];
    letters.add(DropdownMenuItem(
      child: Text(
        "AA",
        style: TextStyle(fontSize: 20),
      ),
      value: 4,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "BA",
        style: TextStyle(fontSize: 20),
      ),
      value: 3.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "BB",
        style: TextStyle(fontSize: 20),
      ),
      value: 3,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "CB",
        style: TextStyle(fontSize: 20),
      ),
      value: 2.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "CC",
        style: TextStyle(fontSize: 20),
      ),
      value: 2,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "DC",
        style: TextStyle(fontSize: 20),
      ),
      value: 1.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "DD",
        style: TextStyle(fontSize: 20),
      ),
      value: 1,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "FD",
        style: TextStyle(fontSize: 20),
      ),
      value: 0.5,
    ));
    letters.add(DropdownMenuItem(
      child: Text(
        "FF",
        style: TextStyle(fontSize: 20),
      ),
      value: 0,
    ));
    return letters;
  }

  Widget _makeListItems(BuildContext context, int index) {
    counter++;

    return Dismissible(
      key: Key(counter.toString()),
      onDismissed: (direction) {
        setState(() {
          allCourses.removeAt(index);
          CalculateGpa();
        });
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: allCourses[index].color, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        margin: EdgeInsets.all(10),
        child: ListTile(
          leading: Icon(
            Icons.border_color,
            color: allCourses[index].color,
          ),
          title: Text(allCourses[index].name),
          trailing: Icon(
            Icons.delete_sweep,
            color: allCourses[index].color,
          ),
          subtitle: Text(allCourses[index].credit.toString() +
              " Credit " +
              allCourses[index].gradeLetter.toString() +
              " Coefficient"),
        ),
      ),
    );
  }

  void CalculateGpa() {
    double totalGrade = 0;
    double totalCredit = 0;
    for (var currentCourse in allCourses) {
      var creditCurrent = currentCourse.credit;
      var letterGradeValueCurrent = currentCourse.gradeLetter;
      totalGrade = totalGrade + (letterGradeValueCurrent * creditCurrent);

      totalCredit += coursecredit;
    }
    gpa = totalGrade / totalCredit;
  }

  Color RandomColor() {
    return Color.fromARGB(
        150 + Random().nextInt(105),
        150 + Random().nextInt(105),
        Random().nextInt(60),
        Random().nextInt(255));
  }
}

class Course {
  String name;
  double gradeLetter;
  int credit;
  Color color;

  Course(this.name, this.gradeLetter, this.credit, this.color);
}
