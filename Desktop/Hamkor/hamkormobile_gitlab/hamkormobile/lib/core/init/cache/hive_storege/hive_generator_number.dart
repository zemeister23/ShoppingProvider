class HiveGeneratorNumber {
  static final HiveGeneratorNumber _instance = HiveGeneratorNumber._init();
  static HiveGeneratorNumber get instance => _instance;

  static const int CLIENT_CARDS = 0;
  static const int CLIENT_CARDS_DATA = 1;
  static const int CLIENT_CARDS_CARD = 2;
  static const int TRANSACTIONS = 3;
  static const int TRANSACTIONS_DATUM = 4;
  static const int TRANSACTIONS_RECIVER = 5;
  static const int ACCOUNTS_MODEL = 6;
  static const int ACCOUNTS_DATUM = 7;
  static const int P2PTEMPLATES = 8;
  static const int P2PTEMPLATES_DATUM = 9;
  static const int P2PTEMPLATES_RECIVER = 10;
  static const int DEPOSITS = 11;
  static const int DEPOSITS_DATUM = 12;
  static const int LOANS = 13;
  static const int LOANS_DATUM= 14;
  static const int CLIENT_NAME= 15;
  static const int CLIENT_NAME_DATA= 16;
  static const int CARDS_OPERATIONS= 17;
  static const int CARDS_OPERATIONS_DATUM= 18;
  static const int CARDS_OPERATIONS_OPERATIONS= 19;



  HiveGeneratorNumber._init();
}
