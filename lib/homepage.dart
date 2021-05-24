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
  String status = "";

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
      status = querySnapshot.docs.first["status"];
    });
  }

  static const TextStyle infoSTyle = TextStyle(
    fontSize: 16,
  );
  bool isCurrentCity = true;
  @override
  Widget build(BuildContext context) {
    final screenDims = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
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
          Card(
            child: Wrap (
              runAlignment: WrapAlignment.center,
              crossAxisAlignment: WrapCrossAlignment.center,
              alignment: WrapAlignment.center,
              children: [
                Container(
                    margin: EdgeInsets.only(top: 10),
                    child: Text(
                      "Status: " + status,
                      style: const TextStyle(fontSize: 17),
                    )),
                Row(
                mainAxisAlignment: MainAxisAlignment.center,
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
                          child: Text(widget.city),
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
          ),
          FutureBuilder<QuerySnapshot>(
            future: getData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              } else {
                if (snapshot.data.docs.length < 1)
                  return Expanded(child: Center(child: Text('No Wards Registered in App in Your City',style: TextStyle(fontSize: 18),),));
                return Expanded(
                  child: ListView.builder(
                    itemCount: snapshot.data.docs.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () async {
                          print(snapshot.data.docs[index].data());
                          await Navigator.push(
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
                          await getStatus();
                          setState(() {
                          });
                        },
                        child: Card(
                          child: Container(


                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  width: screenDims.width,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(5),
                                          topRight: Radius.circular(5)),
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
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Address : ${snapshot.data.docs[index]["address"]}',
                                              style: infoSTyle,
                                              softWrap: true,
                                            ),
                                            Text(
                                              'Type : ${snapshot.data.docs[index]["type"]}',
                                              style: infoSTyle,
                                            ),
                                            Text(
                                              'Mobile Number : ${snapshot.data.docs[index]["mobile_number"]}',
                                              style: infoSTyle,
                                            ),

                                          ],
                                        ),
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
