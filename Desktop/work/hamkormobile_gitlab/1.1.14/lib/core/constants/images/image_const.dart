class ImageConst {
  static ImageConst? _instance;
  static ImageConst get instance => ImageConst._init();

  ImageConst._init();

  // * ADD ALL IMAGES HERE
  String get logo => toSvg("hamkor_logo");
  String get hamkordialog => toSvg("hamkor_dialog");
  String get homeLogo => toPng("hamkorHomelogo");
  String get homeLogoPng => toPng("hamkorlogo");
  String get uzbFlag => toSvg("flag_uzb");
  String get rusFlag => toSvg("flag_rus");
  String get imageBack => toSvg("icon_delete");
  String get alertEror => toPng("alert_eror");
  String get loading => toLottie("loading");
  String get miniLogo => toSvg("logo");
  String get cardLogo => toSvg("card_logo");
  String get intirnetEror => toPng("internet_eror");
  String get hamkorLogo => toPng("mini_hamkorlogo");
  String get exclamation => toPng("exclamation");
  String get bang => toSvg("bang");
  String get scheta => toSvg("logo_scheta");
  String get arrow_forward => toSvg("arrow_forward");
  String get face_scan => toLottie("face_scan");

  String toPng(String name) => "assets/images/$name.png";
  String toSvg(String name) => "assets/images/$name.svg";
  String toLottie(String name) => "assets/images/$name.json";
  String toJpg(String name) => "assets/images/$name.jpg";
}
