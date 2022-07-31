import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonda_projekt/ConnectPage.dart';

class ConnectButton extends StatelessWidget {
  final bool isConnected;

  const ConnectButton({Key? key, required this.isConnected}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
          color: const Color(0xffFF7D40),
          borderRadius: BorderRadius.circular(8)),
      child: Center(
        child: Container(
            padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
            decoration: BoxDecoration(
                color: const Color(0xffFF9866),
                borderRadius: BorderRadius.circular(50)),
            child: GestureDetector(
              onTap: () {
                if (!isConnected) {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) {
                    return ConnectPage();
                  }));
                }
              },
              child: Text(isConnected ? "Połączono z Sondą" : "Łącze z Sondą...",
                  style: GoogleFonts.manrope(
                      fontSize: 16,
                      textStyle: TextStyle(color: const Color(0xffffffff)))),
            )),
      ),
    );
  }
}
