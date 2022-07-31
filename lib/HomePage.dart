import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ionicons/ionicons.dart';
import 'package:sonda_projekt/components/ConnectButton.dart';
import 'package:sonda_projekt/components/ReadDataSection.dart';

class HomePage extends StatefulWidget {
  final BluetoothDevice server;
  const HomePage({Key? key, required this.server}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  BluetoothConnection? connection;

  bool isConnecting = true;
  bool get isConnected => (connection?.isConnected ?? false);
  bool isDisconnecting = false;

  @override
  void initState() {
    super.initState();

    print(FlutterBluetoothSerial.instance.state);

    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });

      // connection!.input!.listen(_onDataReceived).onDone(() {
      //   // Example: Detect which side closed the connection
      //   // There should be `isDisconnecting` flag to show are we are (locally)
      //   // in middle of disconnecting process, should be set before calling
      //   // `dispose`, `finish` or `close`, which all causes to disconnect.
      //   // If we except the disconnection, `onDone` should be fired as result.
      //   // If we didn't except this (no flag set), it means closing by remote.
      //   if (isDisconnecting) {
      //     print('Disconnecting locally!');
      //   } else {
      //     print('Disconnected remotely!');
      //   }
      //   if (this.mounted) {
      //     setState(() {});
      //   }
      // });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
  }

  @override
  void dispose() {
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection?.dispose();
      connection = null;
    }

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        padding: EdgeInsets.only(top: 0),
        children: [
          Padding(
              padding: const EdgeInsets.only(top: 20),
              child: ConnectButton(
                isConnected: isConnected,
              )),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Steruj silnikiem",
                    style: GoogleFonts.manrope(
                        fontWeight: FontWeight.bold,
                        fontSize: 24,
                        textStyle: TextStyle(color: const Color(0xff323232)))),
                Padding(
                  padding: const EdgeInsets.only(top: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 60,
                        width: 60,
                        decoration: BoxDecoration(
                            color: const Color(0xffFFF5ED),
                            borderRadius: BorderRadius.circular(8)),
                        child: IconButton(
                            onPressed: _sendData,
                            icon: Icon(Ionicons.chevron_up,
                                size: 32, color: const Color(0xffF27639))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Container(
                          height: 60,
                          width: 60,
                          decoration: BoxDecoration(
                              color: const Color(0xffFFF5ED),
                              borderRadius: BorderRadius.circular(8)),
                          child: IconButton(
                              onPressed: () => {},
                              icon: Icon(
                                Ionicons.chevron_down,
                                size: 32,
                                color: const Color(0xffF27639),
                              )),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(top: 20), child: ReadDataSection())
        ],
      ),
    );
  }

  void _sendData() async {
    try {
      connection!.output.add(Uint8List.fromList(utf8.encode("test" + "\r\n")));
      await connection!.output.allSent;
    } catch (e) {
      setState(() {
        
      });
    }
  }
}
