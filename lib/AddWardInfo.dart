import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covisolate0/ward_homepage.dart';
import 'package:flutter/material.dart';
import 'main.dart';

class AddWardInfo extends StatefulWidget {
  @override
  _AddWardInfoState createState() => _AddWardInfoState();
}

class _AddWardInfoState extends State<AddWardInfo> {
  final noOfBeds = TextEditingController();
  int countOfBeds = 0;

  final TextEditingController availableBeds = TextEditingController();
  final TextEditingController totalBeds = TextEditingController();
  final TextEditingController oxygenBeds = TextEditingController();
  final TextEditingController nameOfOrg = TextEditingController();
  final TextEditingController availableVentilatorBeds = TextEditingController();
  final TextEditingController availableOxygenBeds = TextEditingController();
  final TextEditingController ventilatorBeds = TextEditingController();
  final TextEditingController address = TextEditingController();
  final TextEditingController city = TextEditingController();
  final TextEditingController mobileNumber = TextEditingController();
  final TextEditingController directorName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final pageViewController = PageController(initialPage: 0);

  PageView pageView;

  String typeOfWard = "Government";

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(brightness: Brightness.dark,
        title: Text(
          "Enter Covid Center Info",
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
          height: 700,
          width: MediaQuery.of(context).size.width,
          padding: EdgeInsets.only(top: 30,left: 30,right: 30),
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  tileMode: TileMode.clamp,
                  stops: [.2, .2],
                  colors: [Colors.deepPurpleAccent, Colors.white],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter)),
          child: PageView(
            controller: pageViewController,
            children: [
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 20),
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextFormField(
                        controller: nameOfOrg,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.account_circle),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "Name of Covid Center"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: address,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.location_city),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "Address"),
                      ),
                      SizedBox(
                        height: 15,
                      ),

                      TextFormField(
                        controller: directorName,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "Director Name"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: mobileNumber,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.phone),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "Mobile Number"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: email,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.email),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "E-mail"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: password,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.remove_red_eye),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
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
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "City"),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      OutlinedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(
                                      Colors.white)),
                          onPressed: () async {
                            pageViewController.nextPage(
                                duration: Duration(milliseconds: 900),
                                curve: Curves.ease);
                          },
                          icon: Icon(Icons.arrow_forward),
                          label: Text('Next Page')),
                    ],
                  ),
                ),
              ),
              Card(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: 20, vertical: 10),
                  width: MediaQuery.of(context).size.width * .8,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          OutlinedButton.icon(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(
                                          Colors.white)),
                              onPressed: () async {
                                pageViewController.previousPage(
                                    duration:
                                        Duration(milliseconds: 900),
                                    curve: Curves.ease);
                              },
                              icon: Icon(Icons.keyboard_backspace),
                              label: Text('Previous Page')),
                        ],
                      ),
                      SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        controller: oxygenBeds,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.airline_seat_individual_suite),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "Number of Oxygen Beds"),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: availableOxygenBeds,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.airline_seat_individual_suite),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15)),
                            labelText: "Available Oxygen Beds"),
                      ),

                      SizedBox(
                        height: 15,
                      ),

                      TextFormField(
                        controller: ventilatorBeds,
                        decoration: InputDecoration(
                            prefixIcon: Icon(
                                Icons.airline_seat_individual_suite),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15)),
                            labelText: "Number of Ventilator Beds"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: availableVentilatorBeds,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.airline_seat_individual_suite),
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.circular(15)),
                            labelText: "Available Ventilators Beds"),
                      ),

                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: totalBeds,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.single_bed_outlined),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15)),
                            labelText: "Number of Total Beds"),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: availableBeds,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.single_bed_outlined),
                            border: OutlineInputBorder(
                                borderRadius:
                                BorderRadius.circular(15)),
                            labelText: "Available Beds"),
                      ),
                      SizedBox(height: 10,),
                      Wrap(
                        runAlignment: WrapAlignment.spaceAround,
spacing: 10,
alignment: WrapAlignment.center,
                        children: [
                          Column(
                            children: [
                              Text('Government'),
                              Radio(
                                  value: 'Government',
                                  groupValue: typeOfWard,
                                  onChanged: (val) {
                                    setState(() {
                                      typeOfWard = val;
                                    });
                                  }),
                            ],
                          ),
                          Column(
                            children: [
                              Text('Private'),
                              Radio(
                                  value: 'Private',
                                  groupValue: typeOfWard,
                                  onChanged: (val) {
                                    setState(() {
                                      typeOfWard = val;
                                    });
                                  }),
                            ],
                          ),
                          Column(
                            children: [
                              Text('NGO/ORG'),
                              Radio(
                                  value: "NGO/ORG",
                                  groupValue: typeOfWard,
                                  onChanged: (val) {
                                    setState(() {
                                      typeOfWard = val;
                                    });
                                  }),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all(
                                Colors.deepPurpleAccent),
                            padding: MaterialStateProperty.all(
                                EdgeInsets.all(15)),
                            shape: MaterialStateProperty.all(
                                RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.circular(5)))),
                        icon: Icon(Icons.app_registration),
                        onPressed: () async {
                          DocumentReference docRef = firebaseFirestore
                              .collection("wards")
                              .doc();
                          await docRef.set({
                            "docId": docRef.id,
                            "address": address.text,
                            "director_name": directorName.text,
                            "mobile_number": mobileNumber.text,
                            "email": email.text,
                            "password": password.text,
                            "city": city.text[0].toUpperCase() + city.text.substring(1),
                            "available_beds": availableBeds.text,
                            "available_oxygen_beds":
                                availableOxygenBeds.text,
                            "available_ventilator_beds":
                                availableBeds.text,
                            "org_name": nameOfOrg.text[0].toUpperCase() + nameOfOrg.text.substring(1),
                            "oxygen_beds": oxygenBeds.text,
                            "total_beds": totalBeds.text,
                            "type": typeOfWard,
                            "ventilator_beds": ventilatorBeds.text,
                            "requests": []
                          });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => WardHomePage(docRef.id)));
                        },
                        label: Text('Register'),
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
