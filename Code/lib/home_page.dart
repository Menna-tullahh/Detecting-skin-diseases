import 'dart:convert';
import 'dart:io';
import 'package:biomedicalapp/main.dart';
import 'package:biomedicalapp/result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:imgur/imgur.dart' as imgur;

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var response;
  var resultjson;
  bool loading = false;
  File _image;
  final picker = ImagePicker();

  Future cameraImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        test_http2(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future galleryImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        print(pickedFile.path);
        test_http(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  test_http(image) async {
    Navigator.of(context).pop();

    setState(() {
      loading=true;
    });
    print(image);
    final client =
        imgur.Imgur(imgur.Authentication.fromToken('YOUR_IMGUR_ACCESS_TOKEN'));

    await client.image
        .uploadImage(
            imagePath: image,
            title: 'BioMedical Project',
            description: 'Test http requests for project')
        .then((image) async{
       response = await http.post(
        'http://10.0.2.2:5000/',
        body: image.link,
      );
       setState(() {
         loading=false;
         print(response.body);
         resultjson = json.decode(response.body);
          String test = resultjson['response'];
          resultjson=test.replaceAll("payload ", "").split(" ");

       });
    });//g
  }
  test_http2(image) async {
    Navigator.of(context).pop();
    setState(() {
      loading=true;
    });
    var response;
    print(image);
    final client =
        imgur.Imgur(imgur.Authentication.fromToken('YOUR_IMGUR_ACCESS_TOKEN'));

    await client.image
        .uploadImage(
            imagePath: image,
            title: 'BioMedical Project',
            description: 'Test http requests for project')
        .then((image) async{
       response = await http.post(
        'http://10.0.2.2:5000/',
        body: image.link,
      );
       setState(() {
         loading=false;
         resultjson = json.decode(response.body);

       });
    });//g
    print(response.body);
  }

  Widget _offsetPopup() => PopupMenuButton<int>(
      itemBuilder: (context) => [
            PopupMenuItem(
              value: 1,
              child: InkWell(
                onTap: cameraImage,
                child: Text(
                  "Camera",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
            ),
            PopupMenuItem(
              value: 2,
              child: InkWell(
                onTap: galleryImage,
                child: Text(
                  "Upload image",
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.w700),
                ),
              ),
            ),
          ],
      icon: Container(
        child: Icon(Icons.camera_alt, color: Colors.black45),
        height: double.infinity,
        width: double.infinity,
        decoration: ShapeDecoration(
            color: Colors.blue,
            shape: StadiumBorder(
              side: BorderSide(color: Colors.black45, width: 3),
            )),
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Skin Disease Detector'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => Welcome()),
            );
          },
        ),
      ),
      body: !loading?Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Center(
            child: _image == null
                ? Padding(
                    padding: const EdgeInsets.all(140.0),
                    child: Text('No image selected.'),
                  )
                : Column(
                    children: <Widget>[
                      Container(height: 400, child: Image.file(_image)),
                      SizedBox(
                        height: 20,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Result(result: resultjson,)),
                          );
                        },
                        child: Stack(
                          children: <Widget>[
                            Center(
                              child: Container(
                                height: 60,
                                width: 180,
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  border: Border.all(
                                    color: Colors.black45,
                                    width: 3,
                                  ),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(5)),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    "The Result",
                                    style: TextStyle(fontSize: 17),
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Icon(Icons.assignment),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
          ),
          Container(
            height: 80,
            width: 80,
            child: _offsetPopup(),
          ),
        ],
      ):Center(child:CircularProgressIndicator()),
    );
  }
}
