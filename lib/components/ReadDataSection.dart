import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sonda_projekt/components/DataTile.dart';

class ReadDataSection extends StatefulWidget {
  const ReadDataSection({Key? key}) : super(key: key);

  @override
  State<ReadDataSection> createState() => _ReadDataSectionState();
}

class _ReadDataSectionState extends State<ReadDataSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Czytaj dane z czujników",
            style: GoogleFonts.manrope(
                fontWeight: FontWeight.bold,
                fontSize: 24,
                textStyle: TextStyle(color: const Color(0xff323232)))),
        Column(
          children: [
            DataTile(
              data: "16*C",
              title: "Temperatura wody",
              icon: CupertinoIcons.thermometer,
              isPrimary: true
            ),
            SizedBox(height: 12),
            DataTile(
              data: "16*C",
              title: "Temperatura wody",
              icon: CupertinoIcons.thermometer,
              isPrimary: false
            ),
          ],
        )
      ],
    );
  }
}
