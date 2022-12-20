
class HiveBoxName{

 static final HiveBoxName _instance = HiveBoxName._init();
  static HiveBoxName get instance => _instance;
static const MAIN_BOX = "main_box"; 
static const CLIENT_CARDS = "client_cards";
static const TRANSACTIONS = "transactions";
static const ACCOUNTS = "accounts";
static const P2PTEMPLATES = "p2p_templates";
static const DEPOSITS = "deposits";
static const LOANS = "loans";
static const CLIENT_NAME = "client_name";
static const CARDS_OPERATIONS = "client_name";

 static const Set<String>  MINI_BOX_NAME = {HiveBoxName.CLIENT_CARDS,HiveBoxName.ACCOUNTS,HiveBoxName.CLIENT_NAME,HiveBoxName.DEPOSITS,HiveBoxName.LOANS,HiveBoxName.P2PTEMPLATES,HiveBoxName.TRANSACTIONS,};

  HiveBoxName._init();

}