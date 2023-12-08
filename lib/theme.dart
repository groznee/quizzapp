// ignore_for_file: deprecated_member_use

import 'package:google_fonts/google_fonts.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';

var themeDefault = FlexColorScheme.dark(
  scheme: FlexScheme.blue,
  fontFamily: GoogleFonts.poppins().fontFamily,
).toTheme;
var themeBlue = FlexColorScheme.dark(
  scheme: FlexScheme.amber,
  fontFamily: GoogleFonts.openSans().fontFamily,
).toTheme;
var themeRed = FlexColorScheme.dark(
  scheme: FlexScheme.red,
  fontFamily: GoogleFonts.montserrat().fontFamily,
).toTheme;
var themeGreen = FlexColorScheme.dark(
  scheme: FlexScheme.green,
  fontFamily: GoogleFonts.lato().fontFamily,
).toTheme;
var themeAmber = FlexColorScheme.dark(
  scheme: FlexScheme.indigo,
  fontFamily: GoogleFonts.roboto().fontFamily,
).toTheme;

// var appTheme = FlexThemeData.dark(
//   scheme: FlexScheme.deepBlue,
//   surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
//   blendLevel: 15,
//   appBarStyle: FlexAppBarStyle.background,
//   appBarOpacity: 0.90,
//   subThemesData: const FlexSubThemesData(
//     blendOnLevel: 30,
//   ),
//   visualDensity: FlexColorScheme.comfortablePlatformDensity,
//   useMaterial3: true,
//   // To use the playground font, add GoogleFonts package and uncomment
//   fontFamily: GoogleFonts.karla().fontFamily,
// );
