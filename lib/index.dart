import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:ocr_application/firebase_ml_api.dart';
import 'package:ocr_application/main.dart';
import 'package:ocr_application/scanTextOutput.dart';
import 'package:ocr_application/temp.dart';
import 'package:ocr_application/tempharshi.dart';
import 'package:ocr_application/textToSpeech.dart';
import 'package:ocr_application/text_recognisation_widget.dart';

class Index extends StatefulWidget {
  const Index({Key? key}) : super(key: key);

  @override
  State<Index> createState() => _IndexState();
}

class _IndexState extends State<Index> {
  late String scannedText;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String _searchValue;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Container(
        child: Align(
          alignment: Alignment.bottomRight,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                onPressed: () async {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => TextRecognitionWidget()));
                  final imageFile = await ImagePicker.pickImage(
                    source: ImageSource.camera,
                    maxWidth: 600,
                  );
                  // final text = await FirebaseMLApi.recogniseText(imageFile);
                  setState(() {
                    // scannedText = text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextRecognitionWidget(
                                  image: imageFile,
                                )));
                  });
                },
                child: Icon(
                  Icons.camera_alt_outlined,
                ),
              ),
              SizedBox(width: 10),
              FloatingActionButton(
                backgroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(15.0))),
                onPressed: () async {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (context) => TextRecognitionWidget()));
                  final imageFile = await ImagePicker.pickImage(
                    source: ImageSource.gallery,
                    maxWidth: 600,
                  );
                  // final text = await FirebaseMLApi.recogniseText(imageFile);
                  setState(() {
                    // scannedText = text;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TextRecognitionWidget(
                                  image: imageFile,
                                )));
                  });
                },
                child: Icon(
                  Icons.photo,
                ),
              ),
              // FloatingActionButton(
              //   onPressed: () {},
              //   child: Icon(
              //     Icons.photo_album_rounded,
              //   ),
              // ),
            ],
          ),
        ),
      ),
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverToBoxAdapter(
                child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 60,
                  ),
                  Text(
                    "Get all your pdfs and docs at a places",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w600,
                      color: Colors.grey.shade800,
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade200,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Form(
                      key: _formKey,
                      child: TextFormField(
                        validator: (input) {
                          if (input != null && input.isEmpty)
                            return "Search Something";
                        },
                        cursorColor: Colors.black,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.grey.shade700,
                          ),
                          border: InputBorder.none,
                          hintText: "Search ",
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                        ),
                        onSaved: (input) => _searchValue = input!,
                      ),
                    ),
                  ),
                ],
              ),
            ))
          ];
        },
        body: Container(
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: 1,
            itemBuilder: (BuildContext context, int index) {
              return Card(
                elevation: 8.0,
                margin:
                    new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
                // shape: ,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      10,
                    ),
                  ),
                  child: ListTile(
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
                    leading: Container(
                      padding: EdgeInsets.only(right: 12.0),
                      decoration: new BoxDecoration(
                          // borderRadius: BorderRadius.circular(
                          //           50,
                          //         ),
                          border: new Border(
                              right: new BorderSide(
                                  width: 1.0, color: Colors.black))),
                      child: Icon(Icons.autorenew, color: Colors.black),
                    ),
                    title: Text(
                      "Document",
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                    // subtitle: Text("Intermediate", style: TextStyle(color: Colors.white)),

                    subtitle: Row(
                      children: <Widget>[
                        Icon(Icons.linear_scale, color: Colors.black),
                        Text("Date", style: TextStyle(color: Colors.black))
                      ],
                    ),
                    trailing: Icon(Icons.keyboard_arrow_right,
                        color: Colors.black, size: 30.0),
                  ),
                ),
              );
            },
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 55.0,
        child: BottomAppBar(
          color: Colors.white,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.home, color: Colors.black),
                onPressed: () {},
              ),
              // IconButton(
              //   icon: Icon(Icons.camera_alt_rounded, color: Colors.black),
              //   onPressed: () {
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => HomePage()));
              //   },
              // ),
              IconButton(
                icon: Icon(Icons.photo, color: Colors.black),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => ScanTextOutput()));
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: Colors.black),
                onPressed: () {
                  // Navigator.push(
                  //     context,
                  //     MaterialPageRoute(
                  //         builder: (context) => TextToSpeech(
                  //               newVoiceText: "Testing it out!!",
                  //             )));
                },
              ),
              IconButton(
                icon: Icon(Icons.logout, color: Colors.black),
                onPressed: () {
                  showAlertDialog(context);
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    // Widget logOutButton = SalomonBottomBarItem(
    //   icon: Icon(Icons.logout),
    //   title: Text("LogOut"),
    //   selectedColor: Colors.redAccent,
    // );
    Widget okButton = TextButton(
      child: Text("Logout"),
      onPressed: () {
        _auth.signOut();
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => HomePage()));
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => LandingPage()),
            (route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout Alert!!"),
      content: Text("Are you sure you want to logout?"),
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
    );
  }
}
