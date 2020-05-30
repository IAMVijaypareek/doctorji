import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SettingPage extends StatefulWidget {
  @override
  _SettingPageState createState() => _SettingPageState();
}

class _SettingPageState extends State<SettingPage> {
  DateTime _dateTime = DateTime.now();
  DateTime _startDate = DateTime.now();
  DateTime _lastDate = DateTime.now();

  Future<void> _selectdate(
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    ).then((value) {
      if (value != null) {
        setState(() {
          _dateTime = value;
        });
      }
    });
  }

  Future<void> _selectdate1(
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    ).then((value) {
      if (value != null) {
        setState(() {
          _startDate = value;
        });
      }
    });
  }

  Future<void> _selectdate2(
    BuildContext context,
  ) async {
    await showDatePicker(
      context: context,
      initialDate: _dateTime,
      firstDate: DateTime(2020),
      lastDate: DateTime(2021),
    ).then((value) {
      if (value != null) {
        setState(() {
          _lastDate = value;
        });
      }
    });
  }
 

  Widget show() {
    return CalendarDatePicker(
        initialDate: DateTime.now(),
        firstDate: DateTime(2020),
        lastDate: DateTime(2021),
        onDateChanged: (da) {
          setState(() {
            _dateTime = da;
          });
        });
  }

  @override
  Widget build(BuildContext context) {
    String _formattedate = new DateFormat.yMMMd().format(_dateTime);
    String _formattedate1 = new DateFormat.yMMMd().format(_startDate);
    String _formattedate2 = new DateFormat.yMMMd().format(_lastDate);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "My Earning",
          style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            show(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Today's Earning :1000 Rs ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              print("date");
                              _selectdate(
                                context,
                              );
                            }),
                        Text('Date: $_formattedate ' ?? ""),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Total Patient Served : 1",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Total Earning :10000 Rs ",
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              print("date");
                              _selectdate1(context);
                            }),
                        Text('Start Date: $_formattedate1 ' ?? ""),
                      ],
                    ),
                    Row(
                      children: [
                        IconButton(
                            icon: Icon(Icons.date_range),
                            onPressed: () {
                              print("date");
                              _selectdate2(context);
                            }),
                        Text('End Date: $_formattedate2' ?? ""),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Text(
                            "Total Patient Served : 1",
                            style: TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
