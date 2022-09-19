import 'package:biomedicalapp/home_page.dart';
import 'package:biomedicalapp/main.dart';
import 'package:flutter/material.dart';

class Result extends StatefulWidget {
  var result;
  Result({this.result});
  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("The Result", style: TextStyle(fontSize: 20),),
            SizedBox(height: 20,),
            Text(widget.result[16].replaceAll("}",""), style: TextStyle(fontSize: 50, color: Colors.red),),
            Text(widget.result[11], style: TextStyle(fontSize: 15),),
            SizedBox(height: 70),
            InkWell(
              onTap: (){Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage()),
              );},
              child: Stack(
                children: <Widget>[
                  Center(
                    child: Container(
                      height: 60,
                      width: 180,
                      decoration: BoxDecoration(
                        color: Colors.blue[700],
                        border: Border.all(
                          color: Colors.black45,
                          width: 3,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Again",style: TextStyle(fontSize: 18),),
                        SizedBox(width: 10,),
                        Icon(Icons.autorenew,size: 20,),

                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


