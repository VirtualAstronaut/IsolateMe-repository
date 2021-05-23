import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covisolate0/homepage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'main.dart';

class PatientRegister extends StatefulWidget {
  @override
  _PatientRegisterState createState() => _PatientRegisterState();
}

class _PatientRegisterState extends State<PatientRegister> {
  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController mobileNo = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController city = TextEditingController();

  final TextEditingController ventilatorBeds = TextEditingController();
  bool isCoronaPositive = false;
  String dateOfBirth = "";
  File adhaarImage;
  File rtpcrImage;
  final imagePicker = ImagePicker();
  final _firebaseStorage = FirebaseStorage.instance;
  bool isUploading=  false;
  Future<String> uploadAdhaar() async {
    final snapshot = await _firebaseStorage
        .ref()
        .child('images/${fullName.text + mobileNo.text + 'Adhaar'}')
        .putFile(adhaarImage);
    return  await snapshot.ref.getDownloadURL();
  }
  Future<String> uploadRTPCR() async {
    final snapshot = await _firebaseStorage
        .ref()
        .child('images/${fullName.text + mobileNo.text + 'RTPCR'}')
        .putFile(rtpcrImage);
    return  await snapshot.ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "Patient Register",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(

          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 30),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  stops: [.2, .2],
                  colors: [Colors.deepPurpleAccent, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: Column(

            children: [

              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: fullName,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.house_sharp),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Name of Patient"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.single_bed_outlined),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Email"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: mobileNo,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.mobile_friendly),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Mobile Number"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        obscureText: true,
                        controller: password,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "Password"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: city,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(15)),
                            labelText: "City"),
                      ),
                      Wrap(
                  direction: Axis.horizontal,
                        children: [
                          Text('Date Of Birth'),
                          OutlinedButton.icon(
                              onPressed: () async {
                                FocusScope.of(context).unfocus();
                                DateTime dateOfBirthDateTime =
                                    await showDatePicker(
                                        context: context,
                                        initialDate: DateTime(2002),
                                        firstDate: DateTime(1900),
                                        lastDate: DateTime(2002));
                                if (dateOfBirthDateTime != null)
                                  setState(() {
                                    dateOfBirth = dateOfBirthDateTime
                                        .toString()
                                        .substring(0, 10);
                                  });
                              },
                              icon: Icon(Icons.date_range),
                              label: Text(dateOfBirth == ""
                                  ? 'Pick Date'
                                  : 'Picked Date\n${dateOfBirth.toString().substring(0, 10)}'))
                        ],
                      ),
                      Text('Are you diagnosed with Corona Positive ?'),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text('Yes'),
                          Radio(
                              value: true,
                              groupValue: isCoronaPositive,
                              onChanged: (val) {
                                setState(() {
                                  isCoronaPositive = val;
                                });
                              }),
                          Text('No'),
                          Radio(
                              value: false,
                              groupValue: isCoronaPositive,
                              onChanged: (val) {
                                setState(() {
                                  isCoronaPositive = val;
                                });
                              }),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AnimatedContainer(
                              duration: Duration(milliseconds: 400),
                              height: isCoronaPositive ? 20 : 0,
                              child: Text(
                                  isCoronaPositive ? 'Upload Documents' : '')),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: isCoronaPositive ? 50 : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () async {
                                    final pickedImage = await imagePicker
                                        .getImage(source: ImageSource.gallery);
                                    setState(() {
                                      adhaarImage = File(pickedImage.path);
                                    });

                                  },
                                  child: Text(adhaarImage == null
                                      ? 'Adhaar'
                                      : 'Adhaar Selected'),
                                ),
                                isCoronaPositive
                                    ? Checkbox(
                                        value:
                                            adhaarImage != null ? true : false,
                                        onChanged: (val) {
                                          setState(() {
                                            adhaarImage = null;
                                          });
                                        },
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                          SizedBox(
                            width: 25,
                          ),
                          AnimatedContainer(
                            duration: Duration(milliseconds: 400),
                            height: isCoronaPositive ? 50 : 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                OutlinedButton(
                                  onPressed: () async {
                                    final pickedImage = await imagePicker
                                        .getImage(source: ImageSource.gallery);
                                    setState(() {
                                      rtpcrImage = File(pickedImage.path);
                                    });
                                  },
                                  child: Text('RTPCR Test'),
                                ),
                                isCoronaPositive
                                    ? Checkbox(
                                        value:
                                            rtpcrImage != null ? true : false,
                                        onChanged: (val) {
                                          setState(() {
                                            rtpcrImage = null;
                                          });
                                        },
                                      )
                                    : Container()
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurpleAccent),
                            padding:
                                MaterialStateProperty.all(EdgeInsets.all(15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)))),
                        icon: Icon(Icons.save),
                        onPressed: () async {
                          setState(() {
                            isUploading = true;
                          });
                          String adhaarUrl = await uploadAdhaar();
                          String rtpcrUrl = await uploadRTPCR();
                          DocumentReference docRef =
                          firebaseFirestore
                              .collection("patients")
                              .doc();
                          await docRef.set({
                            "docId" : docRef.id,
                            "full_name": fullName.text,
                            "city": city.text,
                            "adhaar_image_url" :  adhaarUrl,
                            "rtpcr_image_url" :  rtpcrUrl,
                            "date_of_birth": dateOfBirth,
                            "email": email.text,
                            "is_corona_positive": isCoronaPositive,
                            "mobile_number": mobileNo.text,

                            "status" : "Not booked any bed",
                            "password": password.text
                          });
                          setState(() {
                            isUploading = false;
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => HomeScreen(city.text,docRef.id)));
                        },
                        label: Row(
                          children: [
                            Text('Register'),
                           SizedBox(width:isUploading ? 10 :0,),
                            isUploading ? SizedBox(height: 20,width:20,child: CircularProgressIndicator(backgroundColor: Colors.white,)) : SizedBox()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ),
    );
  }
}
