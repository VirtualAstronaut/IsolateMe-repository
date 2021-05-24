import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covisolate0/loginscreen.dart';
import 'package:covisolate0/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WardHomePage extends StatefulWidget {
  final String docId;

  WardHomePage(this.docId);
  @override
  _WardHomePageState createState() => _WardHomePageState();
}

class _WardHomePageState extends State<WardHomePage> {
  static const TextStyle infoSTyle = TextStyle(fontSize: 18);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        actions: [
          IconButton(
              tooltip: "Refresh",
              icon: Icon(Icons.refresh),
              onPressed: () {
                setState(() {

                });
              }),
          IconButton(
              tooltip: "Logout",
              icon: Icon(Icons.logout),
              onPressed: () {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (_) => LoginScreen()));
              })
        ],
        title: Text(
          "Covid Center Admin",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder<QuerySnapshot>(
          future: firebaseFirestore
              .collection("wards")
              .where("docId", isEqualTo: widget.docId)
              .get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting)
              return Center(
                child: CircularProgressIndicator(),
              );
            else {
              List<DocumentSnapshot> listOfDocs = snapshot.data.docs;
              if (snapshot.data.docs.first["requests"].length < 1)
                return Center(
                  child: Text(
                    'No Requests yet !',
                    style: const TextStyle(fontSize: 25),
                  ),
                );
              return ListView.builder(
                  itemCount: snapshot.data.docs.first["requests"].length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) {
                    return Card(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Name: ",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  listOfDocs.first["requests"][index]
                                      ["full_name"],
                                  style: infoSTyle,
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.deepPurpleAccent,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Mobile No: ",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  listOfDocs.first["requests"][index]
                                      ["mobile_number"],
                                  style: infoSTyle,
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.deepPurpleAccent,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "City",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  listOfDocs.first["requests"][index]["city"],
                                  style: infoSTyle,
                                )
                              ],
                            ),
                            Divider(
                              color: Colors.deepPurpleAccent,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Type Of Bed",
                                  style: const TextStyle(
                                      color: Colors.black, fontSize: 20),
                                ),
                                Text(
                                  listOfDocs.first["requests"][index]
                                      ["bed_type"],
                                  style: infoSTyle,
                                )
                              ],
                            ),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              direction: Axis.horizontal,
                              alignment: WrapAlignment.center,
                              runAlignment: WrapAlignment.center,
                              children: [
                                OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              width: 300,
                                              height: 300,
                                              child: Image.network(
                                                listOfDocs.first["requests"]
                                                    [index]["adhaar_image_url"],
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            actions: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ok'))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('Adhaar')),
                                const SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () async {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                            content: SizedBox(
                                              width: 300,
                                              height: 300,
                                              child: Image.network(
                                                listOfDocs.first["requests"]
                                                    [index]["rtpcr_image_url"],
                                                loadingBuilder:
                                                    (BuildContext context,
                                                        Widget child,
                                                        ImageChunkEvent
                                                            loadingProgress) {
                                                  if (loadingProgress == null)
                                                    return child;
                                                  return Center(
                                                    child:
                                                        CircularProgressIndicator(
                                                      value: loadingProgress
                                                                  .expectedTotalBytes !=
                                                              null
                                                          ? loadingProgress
                                                                  .cumulativeBytesLoaded /
                                                              loadingProgress
                                                                  .expectedTotalBytes
                                                          : null,
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                            actions: [
                                              OutlinedButton(
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text('ok'))
                                            ],
                                          );
                                        },
                                      );
                                    },
                                    child: Text('RTPCR')),
                                const SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () async {
                                      await firebaseFirestore
                                          .collection('patients')
                                          .doc(listOfDocs.first["requests"]
                                              [index]["docId"])
                                          .update({
                                        "status": "Approved, Come With Docs"
                                      });
                                      String bedType = listOfDocs
                                          .first["requests"][index]["bed_type"];
                                      String fieldValue =
                                          bedType != "Normal Bed"
                                              ? bedType != "Ventilator Bed"
                                                  ? "available_oxygen_beds"
                                                  : "available_ventilator_beds"
                                              : "available_beds";

                                      bool isOxygenOrVentilator =
                                          bedType == "Normal Bed"
                                              ? false
                                              : true;
                                      DocumentSnapshot wardInfo =
                                          await firebaseFirestore
                                              .collection('wards')
                                              .doc(widget.docId)
                                              .get();
                                      if (isOxygenOrVentilator)
                                        await firebaseFirestore
                                            .collection('wards')
                                            .doc(widget.docId)
                                            .update(
                                          {
                                            "available_beds": (int.parse(
                                                    wardInfo["available_beds"]) -
                                                1).toString(),
                                            fieldValue: (int.parse(
                                                    wardInfo[fieldValue].toString()) -
                                                1).toString()
                                          },
                                        );
                                      else {
                                        await firebaseFirestore
                                            .collection('wards')
                                            .doc(widget.docId)
                                            .update({
                                          "available_beds":( int.parse(
                                                  wardInfo["available_beds"]) -
                                              1).toString()
                                        });
                                      }
                                      await firebaseFirestore
                                          .collection("wards")
                                          .doc(widget.docId)
                                          .update({
                                        "requests": FieldValue.arrayRemove([
                                          listOfDocs.first["requests"][index]
                                        ])
                                      });
                                      setState(() {});
                                    },
                                    child: Text("Approve")),
                                const SizedBox(
                                  width: 10,
                                ),
                                OutlinedButton(
                                    style: ButtonStyle(
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                Colors.white)),
                                    onPressed: () async {
                                      await firebaseFirestore
                                          .collection('patients')
                                          .doc(listOfDocs.first["requests"]
                                              [index]["docId"])
                                          .update({"status": "Rejected, Please apply somewhere else"});
                                      await firebaseFirestore
                                          .collection("wards")
                                          .doc(widget.docId)
                                          .update({
                                        "requests": FieldValue.arrayRemove([
                                          listOfDocs.first["requests"][index]
                                        ])
                                      });
                                      setState(() {});
                                    },
                                    child: Text("Reject")),
                              ],
                            )
                          ],
                        ),
                      ),
                    );
                  });
            }
          },
        ),
      ),
    );
  }
}
