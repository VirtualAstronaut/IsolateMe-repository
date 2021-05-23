import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:covisolate0/main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WardInfoScreen extends StatefulWidget {
  final String availableBeds;
  final String totalBeds;
  final String docId;
  final String availableOxygenBeds;
  final String ventilatorBeds;
  final String availableVentilators;
  final String type;
  final String orgName;
  final String availableVentilatorBeds;
  final String address;
  final String mobileNumber;
  final String oxygenBeds;
  final String city;
  final String patientDocId;
  WardInfoScreen(
      {this.availableBeds,
      this.totalBeds,
      this.availableOxygenBeds,
      this.ventilatorBeds,
      this.availableVentilators,
      this.type,
      this.orgName,
      this.address,
      this.mobileNumber,
      this.oxygenBeds,
      this.city,
      this.availableVentilatorBeds,
      this.docId,
      this.patientDocId});

  static const TextStyle infoSTyle =
      TextStyle(fontSize: 18, color: Colors.white);

  @override
  _WardInfoScreenState createState() => _WardInfoScreenState();
}

class _WardInfoScreenState extends State<WardInfoScreen> {
  bool isApplied =false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text(
          "Ward Details",
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        shadowColor: Colors.transparent,
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Card(
          margin: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          color: Colors.deepPurpleAccent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.orgName,
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                ),
                Divider(
                  color: Colors.white,
                  thickness: 3,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        'Address : ',
                        style: WardInfoScreen.infoSTyle,
                      ),
                    ),
                    Expanded(child: Text(widget.address, style: WardInfoScreen.infoSTyle)),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'City : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.city, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Type: ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.type, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Mobile Number : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.mobileNumber, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Oxygen Beds : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.oxygenBeds, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ventilator Beds : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.ventilatorBeds, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total Beds : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.totalBeds, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Oxygen Beds : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.availableOxygenBeds, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Beds : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.availableBeds, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Ventilators : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.availableVentilators, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                Divider(
                  color: Colors.white,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Available Ventilator Beds : ',
                      style: WardInfoScreen.infoSTyle,
                    ),
                    Text(widget.availableVentilatorBeds, style: WardInfoScreen.infoSTyle),
                  ],
                ),
                SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    OutlinedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () async {
                          print("tel:+91${widget.mobileNumber}");

                          if (await canLaunch("tel:+91${widget.mobileNumber}"))
                            await launch("tel:${widget.mobileNumber}");
                        },
                        icon: Icon(Icons.phone),
                        label: Text('Call')),
                    SizedBox(
                      width: 25,
                    ),
                    OutlinedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.white)),
                        onPressed: () async {
                          QuerySnapshot querySnap = await firebaseFirestore
                              .collection("patients")
                              .where("docId", isEqualTo: widget.patientDocId)
                              .get();
                          print(widget.patientDocId);
                          await firebaseFirestore.collection('patients').doc(widget.patientDocId).update(
                              {"status" : "Requested for Bed"});
                          await firebaseFirestore
                              .collection("wards")
                              .doc(widget.docId)
                              .update({
                            "requests": FieldValue.arrayUnion(
                                [querySnap.docs.first.data()])
                          });
                          setState(() {
                            isApplied = true;
                          });
                        },
                        icon: Icon(isApplied ? Icons.check : Icons.app_registration),
                        label: Text(isApplied ? 'Applied' : 'Apply'))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
