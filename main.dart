import 'package:flutter/material.dart';

void main(){
  runApp(
      MaterialApp(
        debugShowCheckedModeBanner: false,
        color: Colors.brown,
        title: "Simple Interest Calculator",
        home: SimpleInterestForm(),
      )
  );
}

class SimpleInterestForm extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return SimpleInterestFormState();
  }
}

class SimpleInterestFormState extends State<SimpleInterestForm>{
  var principal;
  var rate_of_interest;
  var time;
  var _currencies = ["Rupees", "Dollars", "Pound", "Euro"];
  var current = "Rupees";
  var display = '';
  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
          title: Text("Simple Interest Calculator"),
          leading: Icon(Icons.currency_rupee),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
            SizedBox(height: 20.0,),

            TextField(
              controller: principalController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Principle",
                  labelText: "Principle",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20.0))
              ),
    ),
            SizedBox(height: 10.0,),
            TextField(
              controller: roiController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  hintText: "Rate Of Interest",
                  labelText: "ROI",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
                )
              ),
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(
                  child: TextField(
                    controller: termController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      hintText: "Terms",
                      labelText: "Terms",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0)
                      )
                  ),
                ),
                ),
                SizedBox(width: 20.0,),
                Expanded(child: DropdownButton<String>(
                    items: _currencies.map((String value){
                      return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value)
                      );
                    }).toList(),
                    value: current,
                    onChanged: (var newValue){
                      setState(() {
                        current = newValue!;
                      });
                    }))
              ],
            ),
            SizedBox(height: 10.0,),
            Row(
              children: <Widget>[
                Expanded(child:
                Padding(
                padding: EdgeInsets.symmetric(horizontal: 40.0),
                    child:ElevatedButton(onPressed: () {
                      setState((){
                        this.display = calculate(current);
                      });
                    },
                      child: Text("Calculate"),
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0)
                        )
                      )),
                    )),


                Expanded(child:
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 40.0),
                  child: ElevatedButton(onPressed: () {
                    setState(() {
                      termController.text='';
                      principalController.text='';
                      roiController.text='';
                      current=_currencies[0];
                      display = '';
                    });
                  },
                    child: Text("Reset"),
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0)
                          )
                      )
                  )),
                )
              ],
            ),
            SizedBox(height: 30.0,),
            Center(child:
            Padding(padding: EdgeInsets.all(60.0),
              child: Text(this.display, style: TextStyle(
              fontWeight: FontWeight.bold,
                fontSize: 40.0
            ),),))
  ]
    )
    ));
  }
  String calculate(String current){
      double p = double.parse(principalController.text),
      r = double.parse(roiController.text),
      t = double.parse(termController.text);
      double interest = (p*r*t)/100, amount = p+interest;
      switch(current){
        case "Pound":
          return "Interest: £$interest and Amount: £$amount";
        case "Dollars":
          return "Interest: \$$interest and Amount: \$$amount" ;
        case "Euro":
          return "Interest: €$interest and Amount: €$amount";
        default:
          return "Interest: ₹$interest/- and Amount: ₹$amount/-";
      }
  }
}
