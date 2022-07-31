import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DataTile extends StatelessWidget {
  final IconData icon;
  final String title;
  final String data;
  final bool isPrimary;
  const DataTile(
      {Key? key, this.isPrimary = true, required this.icon, required this.title, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
          color: isPrimary ? const Color(0xffEFFAFD) : const Color(0xffFFF5ED),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.only(right: 12),
            width: 48,
            height: 48,
            decoration: BoxDecoration(
                color: isPrimary ? const Color(0xff0292AB) : const Color(0xffFF7D40),
                borderRadius: BorderRadius.circular(8)),
            child: Icon(icon, size: 32, color: const Color(0xffffffff)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title,
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                    textStyle: TextStyle(color: const Color(0xff323232)))),
              Text(data,
                style: GoogleFonts.manrope(
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                    textStyle: TextStyle(color: const Color(0xff575757)))),
            ],
          )
        ],
      ),
    );
  }
}
