import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iot_urine_tester/service/firebase_func.dart';
import 'package:iot_urine_tester/widget/color_material.dart';
import 'package:iot_urine_tester/widget/custom_button.dart';
import 'package:iot_urine_tester/widget/pixel.dart';

class WelcomePage extends StatelessWidget {
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

  Widget _emptySpace(int space) {
    return Expanded(
      flex: space,
      child: Container(),
    );
  }

  Widget _icToilet() {
    return Expanded(
      flex: 5,
      child: Container(
        width: Pixel.x * 40,
        child: SvgPicture.asset(
          'assets/ic_toilet.svg',
        ),
      ),
    );
  }

  Widget _welcomeText() {
    return Expanded(
      flex: 2,
      child: Container(
        child: Text('Welcome to Smart Urinoir\nDehidration Test',
            style:
                GoogleFonts.poppins(color: Colors.white, fontSize: Pixel.x * 5),
            textAlign: TextAlign.center),
      ),
    );
  }

  Widget _button() {
    return Expanded(
      flex: 2,
      child: CustomButton(
        bgcolor: Colors.white,
        textcolor: ColorMaterial.blue,
        hint: 'START',
        width: Pixel.x * 40,
        function: () => FirebaseFunc.getData(),
      ),
    );
  }

  Widget _decoration() {
    return Center(
      child: Column(
        children: [
          _emptySpace(4),
          _icToilet(),
          _welcomeText(),
          _button(),
          _emptySpace(4)
        ],
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
            children: [_bgImage(), _decoration()],
          ),
        ),
      ),
    );
  }
}
