import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:iwish_app/Models/donations.dart';

class TaskHomePage extends StatefulWidget {
  @override
  _TaskHomePageState createState() {
    return _TaskHomePageState();
  }
}

class _TaskHomePageState extends State<TaskHomePage> {
  List<charts.Series<Donation, String>> _seriesPieData;
  List<Donation> mydata;
  Stream slides;

  @override
  void initState() {
    _queryDb();
  }

  /*
  _generateData(mydata) {
    _seriesPieData = List<charts.Series<Donation, String>>();
    _seriesPieData.add(
      charts.Series(
        domainFn: (Donation donation, _) => donation.date,
        measureFn: (Donation donation, _) => donation.name,
        colorFn: (Task task, _) =>
            charts.ColorUtil.fromDartColor(Color(int.parse(task.colorVal))),
        id: 'tasks',
        data: mydata,
        labelAccessorFn: (Task row, _) => "${row.taskVal}",
      ),
    );
  }
*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tasks')),
      body: _buildBody(context),
    );
  }


  /*
  Widget _buildChart(BuildContext context, List<Donation> donationListData) {
    mydata = donationListData;
  //  _generateData(mydata);
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Container(
        child: Center(
          child: Column(
            children: <Widget>[
              Text(
                'Time spent on daily tasks',
                style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10.0,
              ),
              Expanded(
                child: charts.PieChart(_seriesPieData,
                    animate: true,
                    animationDuration: Duration(seconds: 5),
                    behaviors: [
                      new charts.DatumLegend(
                        outsideJustification:
                        charts.OutsideJustification.endDrawArea,
                        horizontalFirst: false,
                        desiredMaxRows: 2,
                        cellPadding:
                        new EdgeInsets.only(right: 4.0, bottom: 4.0,top:4.0),
                        entryTextStyle: charts.TextStyleSpec(
                            color: charts.MaterialPalette.purple.shadeDefault,
                            fontFamily: 'Georgia',
                            fontSize: 18),
                      )
                    ],
                    defaultRenderer: new charts.ArcRendererConfig(
                        arcWidth: 100,
                        arcRendererDecorators: [
                          new charts.ArcLabelDecorator(
                              labelPosition: charts.ArcLabelPosition.inside)
                        ])),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

   */

  Stream _queryDb() {
    // Make a Query
    Query query = Firestore.instance.collectionGroup('donations');
    // Map the documents to the data payload
    slides =
        query.snapshots().map((list) => list.documents.map((doc) => doc.data));
/*
    var map = Map();
    Firestore.instance
        .collectionGroup("donations")
        .snapshots().map((element) => {//null)
    //    .then((snapshot) {
    //  snapshot.documents.map((element) {
        if (!map.containsKey(element.data['name'])) {
          map[element.data['name']] = 1;
        } else {
          map[element.data['name']] += 1;
        }
      }).toList();
    });
    print(map);

 */
  }

  Widget _buildBody(BuildContext context) {
    return StreamBuilder(
      stream: slides,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return LinearProgressIndicator();
        } else {
          var map = Map();
          List donationList = snapshot.data.toList();
          print(donationList.length.toString());
          return Text(donationList.toString());
          //return _buildChart(context, donationList);
        }
      },
    );
  }
}