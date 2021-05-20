import 'package:covisolate0/main.dart';
import 'package:flutter/material.dart';
class WardInfoScreen extends StatelessWidget {
  final String availableBeds;
  final String totalBeds;
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

  WardInfoScreen({
    this.availableBeds,
    this.totalBeds,
    this.availableOxygenBeds,
    this.ventilatorBeds,
    this.availableVentilators,
    this.type,
    this.orgName,
    this.address,
    this.mobileNumber,
    this.oxygenBeds,
    this.city, this.availableVentilatorBeds});

  static const TextStyle infoSTyle = TextStyle(
      fontSize: 18,
      color: Colors.white
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: Card(
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 25),
        color: Colors.deepPurpleAccent,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(orgName,style: const TextStyle(fontSize: 25,color: Colors.white),),
              Divider(color: Colors.white,thickness: 3,),
           SizedBox(height: 10,),
           Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: [
               Text('Address : ',style: infoSTyle,),
               Text(address,style:infoSTyle),
             ],
           ),

              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('City : ',style: infoSTyle,),
                  Text(city,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Type: ',style: infoSTyle,),
                  Text(type,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Mobile Number : ',style: infoSTyle,),
                  Text(mobileNumber,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Oxygen Beds : ',style: infoSTyle,),
                  Text(oxygenBeds,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Ventilator Beds : ',style: infoSTyle,),
                  Text(ventilatorBeds,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Total Beds : ',style: infoSTyle,),
                  Text(totalBeds,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Oxygen Beds : ',style: infoSTyle,),
                  Text(availableOxygenBeds,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Beds : ',style: infoSTyle,),
                  Text(availableBeds,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Ventilators : ',style: infoSTyle,),
                  Text(availableVentilators,style:infoSTyle),
                ],
              ),
              Divider(color: Colors.white,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Available Ventilator Beds : ',style: infoSTyle,),
                  Text(availableVentilatorBeds,style:infoSTyle),
                ],
              ),


              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  OutlinedButton.icon(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.white)
                    ),
                      onPressed: () async {
                      },
                      icon: Icon(Icons.phone),
                      label: Text( 'Call')),
                  SizedBox(width: 25,),
                  OutlinedButton.icon(
                      style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white)
                      ),
                      onPressed: () async {

                      },
                      icon: Icon(Icons.app_registration),
                      label: Text( 'Register'))
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}