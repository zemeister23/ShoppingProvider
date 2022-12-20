import 'package:easy_localization/easy_localization.dart';

extension StringLocalization on String {
  String get locale => this.tr();
  String get lunchtime => this.tr()[0]+this.tr()[1]+":"+this.tr()[2]+this.tr()[3]+"-"+this.tr()[4]+this.tr()[5]+":"+this.tr()[6]+this.tr()[7];
}
