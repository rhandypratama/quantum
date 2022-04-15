// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// const kPrimaryColor = Color(0xFF873991);
// const kPrimaryColor = Color(0xFF24695c);
const kPrimaryColor = Colors.teal;
// const kPrimaryColor = Colors.blueGrey;
// const kSecondaryColor = Color(0xFF3a96d2);
const kSecondaryColor = Color(0xFFba895d);
const kThirdColor = Color(0xFFf8c159);
const kContentColorLightTheme = Color(0xFF1D1D35);
const kContentColorDarkTheme = Color(0xFFF5FCF9);
const kWarninngColor = Color(0xFFF3BB1C);
const kErrorColor = Color(0xFFF03738);
const kInfoColor = Color.fromARGB(255, 206, 231, 248);
const kBackgroundColorLight = Color(0xFFFFFFFF);
const kBackgroundCardLight = Color(0xFFf5f7fb);
const kBackgroundSnackbar = Color.fromARGB(255, 68, 68, 68);

const kGreenColor = Color(0xFF6AC259);
const kRedColor = Color(0xFFE92E30);
const kGrayColor = Color(0xFFC1C1C1);
const kBlackColor = Color(0xFF101010);
const kPrimaryGradient = LinearGradient(
  colors: [Color(0xFF46A0AE), Color(0xFF00FFCB)],
  begin: Alignment.centerLeft,
  end: Alignment.centerRight,
);

// Padding
const kDefaultPadding = 20.0;
const double kPaddingS = 8.0;
const double kPaddingM = 16.0;
const double kPaddingL = 32.0;

// Spacing
const double kSpaceS = 8.0;
const double kSpaceM = 16.0;
const double kSpaceL = 32.0;

// RADIUS
const double kRadiusS = 10.0;

// ICON SIZE
const double kIconSize = 26.0;

// FONT SIZE
const double kFontSize = 12.0;

enum TicketType { FILE, AUDIO, IMAGE, TEXT }

const Map<int, String> months = {
  1: "January",
  2: "February",
  3: "March",
  4: "April",
  5: 'May',
  6: "June",
  7: "July",
  8: "August",
  9: "September",
  10: "October",
  11: "November",
  12: "December"
};

class Url {
  
  // static const String baseUrl = 'http://192.168.1.6:8000/api/';
  static const String baseUrl = 'https://api.personel.id/api/';
  static const String firebaseStorage = 'https://storage.googleapis.com/personel-v1-9079c.appspot.com/';
  
  static const signIn = 'login';
  static const sighUp = 'guest/register';
  static const signOut = 'logout';
  static const me = 'me';
  static const announcement = 'announcement';
  static const requirement = 'dashboard/requirement';
  static const attendance = 'attendance';
  static const employeeShift = 'employee-shift';
  static const holidayDate = 'holiday/date';
  static const leave = 'leave';
  static const leaveType = 'leave-type';
  static const reimburse = 'reimburse';
  static const reimburseType = 'reimburse-type';
  static const overtime = 'overtime';
  static const employee = 'employee';
  static const storage = 'storage';
  // static const payslip = 'payslip';
  
  // SETTING
  // static final getMaxPendingTicket = 'get-max-pending-value';
  // static final settingMaxPendingTicket = 'setting-max-pending-tiket';

}