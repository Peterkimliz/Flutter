import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Simple Intrest Calculator",
    theme: ThemeData(
        brightness: Brightness.dark,
        primaryColor: Colors.indigo,
        accentColor: Colors.indigoAccent),
    home: SimpleCalculator(),
  ));
}

class SimpleCalculator extends StatefulWidget {
  @override
  _SimpleCalculatorState createState() => _SimpleCalculatorState();
}

class _SimpleCalculatorState extends State<SimpleCalculator> {
  var _formKey = GlobalKey<FormState>();
  var _currencies = ["Rupees", "Dollar", "Pounds"];
  var _minimumPadding = 5.0;
  var _currentSelectedItem = "Rupees";
  var displayResult = '';
  TextEditingController PritextEditingController = TextEditingController();
  TextEditingController RoitextEditingController = TextEditingController();
  TextEditingController TermtextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle? textStyle = Theme.of(context).textTheme.title;
    return Scaffold(
      appBar: AppBar(
        title: Text("Simple Intrest Calculator"),
        elevation: 0.0,
        centerTitle: true,
      ),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: EdgeInsets.all(_minimumPadding * 2),
          child: ListView(
            children: [
              getImageAsset(),
//////////////////////////////////principal text field//////////////////////////
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  controller: PritextEditingController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "please enter principal amount";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter principal eg 200",
                    labelStyle: textStyle,
                    errorStyle:
                        TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
/////////////////////////////////Intrest text field//////////////////////////
              Padding(
                padding: EdgeInsets.only(
                    top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  controller: RoitextEditingController,
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  validator: (String? val) {
                    if (val!.isEmpty) {
                      return "please enter rate of intrest";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Rate of intrest",
                    hintText: "Intrest rate",
                    labelStyle: textStyle,
                    errorStyle:
                        TextStyle(color: Colors.yellowAccent, fontSize: 15.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
/////////////////////////////////raw elements /////////////////////////////////
              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: TermtextEditingController,
                        style: textStyle,
                        keyboardType: TextInputType.number,
                        validator: (String? val) {
                          if (val!.isEmpty) {
                            return "please enter term";
                          }
                        },
                        decoration: InputDecoration(
                          labelText: "Term",
                          hintText: "Time in years",
                          labelStyle: textStyle,
                          errorStyle: TextStyle(
                              color: Colors.yellowAccent, fontSize: 15.0),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 15.0,
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 10.0, right: 10.0),
                        child: DropdownButton<String>(
                          items: _currencies.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          value: _currentSelectedItem,
                          onChanged: (var newItem) {
                            _selectedItem(newItem);
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),

              Padding(
                padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
                child: Row(
                  children: [
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState!.validate()) {
                              displayResult = _checkData();
                            }
                          });
                        },
                        color: Theme.of(context).accentColor,
                        textColor: Theme.of(context).primaryColorDark,
                        child: Text(
                          "Calculate",
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            _reset();
                          });
                        },
                        color: Theme.of(context).primaryColorDark,
                        textColor: Theme.of(context).primaryColorLight,
                        child: Text(
                          "Reset",
                          textScaleFactor: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  this.displayResult,
                  style: textStyle,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget getImageAsset() {
    return Container(
      height: 200.0,
    );
  }

  void _selectedItem(String? newItem) {
    setState(() {
      _currentSelectedItem = newItem!;
    });
  }

  String _checkData() {
    double principal = double.parse(PritextEditingController.text);
    double roi = double.parse(RoitextEditingController.text);
    double term = double.parse(TermtextEditingController.text);

    double amount = principal + (principal * roi * term);
    String result =
        "After $term years, your investment will be worth $amount $_currentSelectedItem";
    return result;
  }

  void _reset() {
    PritextEditingController.text = "";
    RoitextEditingController.text = "";
    TermtextEditingController.text = "";
    displayResult = '';
    _currentSelectedItem = _currencies[0];
  }
}
