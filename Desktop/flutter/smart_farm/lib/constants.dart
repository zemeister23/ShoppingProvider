import 'package:flutter/material.dart';
import 'package:smart_farm/calendar/calendar_page.dart';
import 'package:smart_farm/menu/menu_page.dart';
import 'package:smart_farm/search/search_page.dart';
import 'package:smart_farm/settings/settings_page.dart';

const kPrimaryBackgroundColor = Color(0xFFEFEFEF);
const kPrimaryLightColor = Color(0xFFDDDDDD);
const kPrimaryBorderColor = Color(0xFF999999);
const kPrimaryColor = Color(0xFFFF8843);
const kPrimaryDarkColor = Color(0xFFFF4949);
const kPrimaryExtraColor = Color(0xFF55B963);

const ipAdress = "http://localhost:1337";

List<Widget> kAllPages = [
  MenuPage(),
  SearchPage(),
  CalendarPage(),
  const SettingsPage()
];

const List<String> kProducts = ["Hayvonlar", "Ozuqalar", "Fermalar"];
const List<String> kCities = [
  "Andijon viloyati",
  "Buxoro viloyati",
  "Jizzax viloyati",
  "Qoraqalpog'stion",
  "Qashqadaryo viloyati",
  "Navoiy viloyati",
  "Namangan viloyati",
  "Surxondaryo viloyati",
  "Sirdaryo viloyati",
  "Toshkent viloyati",
  "Farg'ona viloyati",
  "Xorazm viloyati",
];

const List<String> kData = [
  "Chirchiq",
  "Chinzon",
  "Chorvoq",
  "Buka",
  "Katta Chimyon",
  "Bokabod",
  "Oxngaron",
];

const List<String> kAnimalsName = ["Ot", "Qo'y", "Tovuq", "Sigir"];

const List<Color> kRandomColors = [
  Colors.redAccent,
  Colors.yellowAccent,
  Colors.greenAccent,
  Colors.cyanAccent,
  Colors.limeAccent,
  Colors.tealAccent,
  Colors.orangeAccent,
];
