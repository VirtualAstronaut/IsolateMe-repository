import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covisolate0/AddWardInfo.dart';
import 'package:covisolate0/homepage.dart';
import 'package:covisolate0/main.dart';
import 'package:covisolate0/patient_register.dart';
import 'package:covisolate0/ward_homepage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final mobileNumber = TextEditingController();
  final password = TextEditingController();

  bool isCovidLogin = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              tileMode: TileMode.mirror,
              colors: [Colors.deepPurpleAccent, Colors.deepPurple.shade400],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              stops: [0, 1])),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Center(
          child: SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: Card(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Login',
                    style: const TextStyle(
                      fontSize: 25,
                    ),
                  ),
                  Divider(
                    indent: 40,
                    endIndent: 40,
                    color: Colors.deepPurpleAccent,
                    thickness: 3,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      children: [
                        TextFormField(
                          controller: mobileNumber,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.phone),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "Mobile Number"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          controller: password,
                          obscureText: true,
                          decoration: InputDecoration(
                              prefixIcon: Icon(Icons.remove_red_eye),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(15)),
                              labelText: "Password"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Covid Center Login?',
                              style: TextStyle(fontSize: 18),
                            ),
                            Checkbox(
                                value: isCovidLogin,
                                onChanged: (val) {
                                  setState(() {
                                    isCovidLogin = val;
                                  });
                                })
                          ],
                        ),

                        OutlinedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () async {

                                QuerySnapshot querySnapshot =
                                    await firebaseFirestore
                                        .collection(isCovidLogin ? "wards" : "patients")
                                        .where("mobile_number",
                                            isEqualTo: mobileNumber.text)
                                        .where("password",
                                            isEqualTo: password.text)
                                        .get();
                                if (querySnapshot.docs.isEmpty) {
                                  showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: Text("Wrong Password"),
                                        actions: [
                                          OutlinedButton(
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStateProperty
                                                          .all(Colors.white)),
                                              onPressed: () async {
                                                Navigator.pop(context);
                                              },
                                              child: Text('Ok'))
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => isCovidLogin ? WardHomePage(querySnapshot
                                              .docs.first["docId"]) : HomeScreen(
                                              querySnapshot
                                                  .docs.first["city"][0].toUpperCase() +  querySnapshot
                                                  .docs.first["city"].substring(1),querySnapshot
                                              .docs.first["docId"]))

                                  );
                                }

                            },
                            icon: Icon(Icons.login),
                            label: Text(
                                'Login as ${isCovidLogin ? 'Covid Center' : 'Patient'}')),
                        OutlinedButton.icon(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all(Colors.white)),
                            onPressed: () async {

                                Navigator.push(context, MaterialPageRoute(builder: (_)  =>
                                isCovidLogin ? AddWardInfo() : PatientRegister()
                                ));


                            },
                            icon: Icon(Icons.app_registration),
                            label: Text(
                                'Register as ${isCovidLogin ? 'Covid Center' : 'Patient'}'))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
