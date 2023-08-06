import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

// endpoints==================
const baseUrl = 'https://www.osamapro.online/api';
const loginUrl = '$baseUrl/login';
const registerUrl = '$baseUrl/register';

const linksUrl = '$baseUrl/links';
const searchUrl = '$baseUrl/search';
const followUrl = '$baseUrl/follow';

//https://www.osamapro.online/api
// ============= STYLE CONSTS ==============

const kScaffoldColor = Color(0xffFDFDFD);
const kRedColor = Color(0xffA90606);

const kPrimaryColor = Color(0xff2D2B4E);
const kSecondaryColor = Color(0xffFFD465);
const kOnSecondaryColor = Color(0xff784E00);
const kDangerColor = Color(0xffF56C61);

// Low Opacity Colors
const kLinksColor = Color(0xff807D99);
const kLightPrimaryColor = Color(0xffE7E5F1);
const kLightSecondaryColor = Color(0xFFFFE6A6);
const kLightDangerColor = Color(0xffFEE2E7);
const kOnLightDangerColor = Color(0xff783341);

// Text Styles
TextStyle kPrimaryTextStyle = GoogleFonts.roboto(
  color: kPrimaryColor,
  fontSize: 28,
  fontWeight: FontWeight.w600,
);

TextStyle kSecondryTextStyle = GoogleFonts.roboto(
  color: kOnSecondaryColor,
  fontSize: 16,
  fontWeight: FontWeight.w600,
);
