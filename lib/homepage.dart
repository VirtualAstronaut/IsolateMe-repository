import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covisolate0/main.dart';
import 'package:covisolate0/wardinfoscreen.dart';
import 'package:flutter/material.dart';

import 'loginscreen.dart';

class HomeScreen extends StatefulWidget {
  final String city;
  final String docId;
  HomeScreen(this.city, this.docId);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isApproved = false;

  @override
  void didChangeDependencies() async {
    super.didChangeDependencies();
    await getStatus();
  }

  Future<QuerySnapshot> getData() {
    print(widget.city);
    if (!isCurrentCity)
      return firebaseFirestore.collection("wards").get();
    else
      return firebaseFirestore
          .collection("wards")
          .where('city', isEqualTo: widget.city)
          .get();
  }

  getStatus() async {
    QuerySnapshot querySnapshot = await firebaseFirestore
        .collection("patients")
        .where('docId', isEqualTo: widget.docId)
        .get();
    setState(() {
      isApproved = querySnapshot.docs.first["isApproved"];
    });
  }

  static const TextStyle infoSTyle = TextStyle(
    fontSize: 18,
  );
  bool isCurrentCity = true;
  @override
  Widget build(BuildContext context) {
    final screenDims = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(brightness: Brightness.light,
        actions: [
          IconButton(
              tooltip: "Logout",
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              })
        ],
        title: Text(
          "Find Covid Ward",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(margin: EdgeInsets.only(left: 10),child: Text('${isApproved ? "Approved " : "Not Approved"}',style: const TextStyle(fontSize: 17),)),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Container(
                      margin: EdgeInsets.only(right: 10),
                      child: Text(
                        'Filter by',
                        style: const TextStyle(fontSize: 17),
                      )),
                  DropdownButton(
                    items: [
                      DropdownMenuItem(
                        child: Text('Rajkot'),
                        value: true,
                      ),
                      DropdownMenuItem(
                        child: Text('Any'),
                        value: false,
                      )
                    ],
                    value: isCurrentCity,
                    onChanged: (val) {
                      setState(() {
                        isCurrentCity = val;
                      });
                    },
                  )
                ],
              ),

            ],
          ),
          FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => WardInfoScreen(
                                      availableVentilatorBeds:
                                          snapshot.data.docs[index]
                                              ["available_ventilator_beds"],
                                      address: snapshot.data.docs[index]
                                          ["address"],
                                      availableBeds: snapshot.data.docs[index]
                                          ["available_beds"],
                                      availableOxygenBeds: snapshot.data.docs[index]
                                          ["available_oxygen_beds"],
                                      availableVentilators: snapshot.data
                                          .docs[index]["available_ventilators"],
                                      type: snapshot.data.docs[index]["type"],
                                      ventilatorBeds: snapshot.data.docs[index]
                                          ["ventilator_beds"],
                                      city: snapshot.data.docs[index]["city"],
                                      mobileNumber: snapshot.data.docs[index]
                                          ["mobile_number"],
                                      orgName: snapshot.data.docs[index]
                                          ["org_name"],
                                      oxygenBeds: snapshot.data.docs[index]["oxygen_beds"],
                                      totalBeds: snapshot.data.docs[index]["total_beds"],
                                      docId: snapshot.data.docs[index]["docId"],
                                      patientDocId: widget.docId)));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border(
                                bottom: BorderSide(
                              color: Colors.deepPurpleAccent,
                            )),
                            // borderRadius: BorderRadius.only(
                            //     bottomLeft: Radius.circular(10),
                            //     bottomRight: Radius.circular(10))
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                width: screenDims.width,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9),
                                        topRight: Radius.circular(9)),
                                    color: Colors.deepPurpleAccent),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      snapshot.data.docs[index]["org_name"],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    ),
                                    Text(
                                      snapshot.data.docs[index]["city"],
                                      style: const TextStyle(
                                          color: Colors.white, fontSize: 20),
                                    )
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'Address : ${snapshot.data.docs[index]["address"]}',
                                          style: infoSTyle,
                                        ),
                                        Text(
                                          'Type : ${snapshot.data.docs[index]["type"]}',
                                          style: infoSTyle,
                                        ),
                                        Text(
                                          'Mobile Number : ${snapshot.data.docs[index]["mobile_number"]}',
                                          style: infoSTyle,
                                        ),
                                        // Text(
                                        //   'Available Oxygen Beds ${snapshot.data.docs[index]["available_oxygen_beds"]}',
                                        //   style: infoSTyle,
                                        // ),
                                        // Text(
                                        //   'Available Ventilator Beds ${snapshot.data.docs[index]["ventilator_beds"]}',
                                        //   style: infoSTyle,
                                        // ),
                                        // Text(
                                        //   'Available Beds ${snapshot.data.docs[index]["available_ventilators"]}',
                                        //   style: infoSTyle,
                                        // ),
                                      ],
                                    ),
                                    Column(
                                      children: [
                                        Container(
                                          height: 25,
                                          width: 40,
                                          color: int.parse(
                                                      snapshot.data.docs[index]
                                                          ["available_beds"]) ==
                                                  0
                                              ? Colors.red
                                              : Colors.green,
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
