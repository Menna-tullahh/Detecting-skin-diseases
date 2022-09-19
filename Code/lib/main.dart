import 'dart:io';
import 'package:biomedicalapp/Welcome.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'home_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Welcome(),
    );
  }
}


class Welcome extends StatefulWidget {
  @override
  _WelcomeState createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[200],
      body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Welcome",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 55,
                ),
              ),
              SizedBox(height: 50,),
              Text("We can detect what your skin have",style: TextStyle(fontSize: 16),),
              SizedBox(height: 5,),

              Text("Thank you for using our application",style: TextStyle(fontSize: 16),),
              SizedBox(height: 60,),

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
                          color: Colors.blue,
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
                          Text("Lets Start",style: TextStyle(fontSize: 17),),
                          SizedBox(width: 20,),
                          Icon(Icons.arrow_forward),

                        ],
                      ),
                    ),
                  ],
                ),
              ),

            ],
          )),
    );
  }
}

