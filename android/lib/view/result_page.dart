import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_urine_tester/controller/result_ctl.dart';
import 'package:iot_urine_tester/widget/color_material.dart';
import 'package:iot_urine_tester/widget/pixel.dart';

class ResultPage extends StatelessWidget {
  final _ctl = Get.put(ResultCtl());

  Widget _bgImage() {
    return Container(
      width: Pixel.x * 100,
      height: Pixel.y * 100,
      child: SvgPicture.asset(
        'assets/bg_welcome.svg',
        fit: BoxFit.fill,
      ),
    );
  }

  Widget _title(int space) {
    return Flexible(
      flex: space,
      child: Container(
        margin: EdgeInsets.only(top: Pixel.y * 5),
        child: Text(_ctl.result.title,
            style: GoogleFonts.poppins(
                color: ColorMaterial.blue,
                fontSize: Pixel.x * 7,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _image(int space) {
    return Flexible(
      flex: space,
      child: Container(
        padding: EdgeInsets.only(top: Pixel.y * 2, bottom: Pixel.y * 2),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 3,
              blurRadius: 3,
            )
          ],
          // borderRadius: BorderRadius.circular(Pixel.x * 2)
        ),
        margin: EdgeInsets.only(top: Pixel.y * 15),
        child: SvgPicture.asset(_ctl.result.imagePath),
      ),
    );
  }

  Widget _info(int space) {
    return Flexible(
      flex: space,
      child: Container(
        width: Pixel.x * 80,
        margin: EdgeInsets.only(top: Pixel.y * 5, bottom: Pixel.y * 10),
        padding: EdgeInsets.all(Pixel.x * 2),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.withOpacity(0.3),
                  spreadRadius: 3,
                  blurRadius: 3,
                  offset: Offset(3, 3))
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Keterangan :',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: Pixel.x * 4,
              ),
            ),
            Text(
              _ctl.result.info,
              textAlign: TextAlign.justify,
            ),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Center(
      child: Column(
        children: [_title(5), _image(8), _info(10)],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Pixel().init(context);
    return Container(
      color: ColorMaterial.blue,
      child: SafeArea(
        child: Scaffold(
          body: Stack(
            children: [_bgImage(), _content()],
          ),
        ),
      ),
    );
  }
}
