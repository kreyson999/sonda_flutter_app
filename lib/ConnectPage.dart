import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonda_projekt/HomePage.dart';

class ConnectPage extends StatefulWidget {
  const ConnectPage({Key? key}) : super(key: key);

  @override
  State<ConnectPage> createState() => _ConnectPageState();
}

class _ConnectPageState extends State<ConnectPage> {
  final Future<BluetoothDevice> _getDevice =
      FlutterBluetoothSerial.instance.getBondedDevices().then((value) {
    // print(value[0].name);
    return value[0];
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Scaffold(
            body: Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 50),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Sonda",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 32,
                        textStyle: TextStyle(color: const Color(0xff323232)))),
                Text("Centrum Sterowania",
                    style: GoogleFonts.manrope(
                        fontSize: 16,
                        textStyle: TextStyle(color: const Color(0xff575757))))
              ],
            ),
          ),
          FutureBuilder(
            future: _getDevice,
            builder: (context, AsyncSnapshot<BluetoothDevice> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: CircularProgressIndicator(
                    valueColor:
                        AlwaysStoppedAnimation<Color>(const Color(0xffFF7D40)),
                  ),
                );
              }
              if (snapshot.hasData) {
                print(snapshot.data);
                return HomePage(server: snapshot.data!);
              }
              return Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                    "Wystąpił błąd, upewnij się, że masz włączone Bluetooth i jesteś zparowany z Sondą!",
                    style: GoogleFonts.manrope(
                        fontSize: 16,
                        textStyle: TextStyle(color: const Color(0xff575757)))),
              );
            },
          ),
        ],
      ),
    )));
    // body: FutureBuilder(
    //   future: _getDevice,
    //   builder: (context, AsyncSnapshot<BluetoothDevice> snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return Text("Ładuje");
    //     }
    //     if (snapshot.hasData) {
    //       print(snapshot.data);
    //       return HomePage(server: snapshot.data!);
    //     }
    //     return Text("Wystąpił bład, upewnij");
    //   },
    // ),
  }
}

// import 'dart:async';

// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:sonda_projekt/HomePage.dart';

// import './BluetoothDeviceListEntry.dart';

// class ConnectPage extends StatefulWidget {
//   /// If true, discovery starts on page start, otherwise user must press action button.
//   final bool start;

//   const ConnectPage({this.start = true});

//   @override
//   _DiscoveryPage createState() => new _DiscoveryPage();
// }

// class _DiscoveryPage extends State<ConnectPage> {
//   StreamSubscription<BluetoothDiscoveryResult>? _streamSubscription;
//   List<BluetoothDiscoveryResult> results =
//       List<BluetoothDiscoveryResult>.empty(growable: true);
//   bool isDiscovering = false;

//   @override
//   void initState() {
//     super.initState();
//     isDiscovering = widget.start;
//     if (isDiscovering) {
//       _startDiscovery();
//     }
//   }

//   void _restartDiscovery() {
//     setState(() {
//       results.clear();
//       FlutterBluetoothSerial.instance
//           .getBondedDevices()
//           .then((value) => print("${value} bonded devices"));
//       isDiscovering = true;
//     });

//     _startDiscovery();
//   }

//   void _startDiscovery() {
//     _streamSubscription =
//         FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
//       setState(() {
//         final existingIndex = results.indexWhere(
//             (element) => element.device.address == r.device.address);
//         if (existingIndex >= 0)
//           results[existingIndex] = r;
//         else
//           results.add(r);
//       });
//     });

//     _streamSubscription!.onDone(() {
//       setState(() {
//         isDiscovering = false;
//       });
//     });
//   }

//   // @TODO . One day there should be `_pairDevice` on long tap on something... ;)

//   @override
//   void dispose() {
//     // Avoid memory leak (`setState` after dispose) and cancel discovery
//     _streamSubscription?.cancel();

//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         iconTheme: IconThemeData(color: const Color(0xffFF7D40)),
//         backgroundColor: const Color(0xffFFF5ED),
//         title: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text("Sonda",
//                 style: GoogleFonts.manrope(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 18,
//                     textStyle: TextStyle(color: const Color(0xff323232)))),
//             Text(isDiscovering ? "Szukam urządzeń" : "Wyszukano urządzenia",
//                 style: GoogleFonts.manrope(
//                     fontSize: 14,
//                     textStyle: TextStyle(color: const Color(0xff575757))))
//           ],
//         ),
//         actions: <Widget>[
//           isDiscovering
//               ? FittedBox(
//                   child: Container(
//                     margin: new EdgeInsets.all(16.0),
//                     child: CircularProgressIndicator(
//                       valueColor: AlwaysStoppedAnimation<Color>(
//                           const Color(0xffFF7D40)),
//                     ),
//                   ),
//                 )
//               : IconButton(
//                   icon: Icon(Icons.refresh,
//                       size: 32, color: const Color(0xffFF7D40)),
//                   onPressed: _restartDiscovery,
//                 )
//         ],
//       ),
//       body: ListView.builder(
//         padding: EdgeInsets.all(0),
//         itemCount: results.length,
//         itemBuilder: (BuildContext context, index) {
//           BluetoothDiscoveryResult result = results[index];
//           final device = result.device;
//           // final address = device.address;
//           return BluetoothDeviceListEntry(
//             device: device,
//             rssi: result.rssi,
//             onTap: () {
//               Navigator.of(context)
//                   .pushReplacement(MaterialPageRoute(builder: (context) {
//                 return HomePage(
//                   server: result.device,
//                 );
//               }));
//             },
//           );
//         },
//       ),
//     );
//   }
// }
