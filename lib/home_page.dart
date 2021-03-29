import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'calendar_widget.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title:  Text('Calendar Table'),
          bottom: TabBar(
            tabs: <Widget>[
              Tab(
                child:Container(
                  child: Center(
                      child: Text(
                        "Simples",
                        style: TextStyle(fontSize: 20),
                      )),
                  width: 120,
                  height: 40,
                ),
              ),
              Tab(
                child:Container(
                  child: Center(
                      child: Text(
                        "Custom",
                        style: TextStyle(fontSize: 20),
                      )),
                  width: 120,
                  height: 40,
                ),
              ),
              Tab(
                child:Container(
                  child: Center(
                      child: Text(
                        "Builder",
                        style: TextStyle(fontSize: 20),
                      )),
                  width: 120,
                  height: 40,
                ),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            CalendarWidget(calendarOption: calendarShown.simples,),
            CalendarWidget(calendarOption: calendarShown.custom,),
            CalendarWidget(calendarOption: calendarShown.builder,),
          ],
        ),
      ),
    );
  }
}
