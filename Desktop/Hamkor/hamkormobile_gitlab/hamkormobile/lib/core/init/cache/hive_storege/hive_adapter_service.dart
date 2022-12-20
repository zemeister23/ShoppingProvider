import 'package:hive/hive.dart';
import 'package:mobile/models/acounts_model.dart';
import 'package:mobile/models/cards_operations_model.dart';
import 'package:mobile/models/client_cards_model.dart';
import 'package:mobile/models/client_name_model.dart';
import 'package:mobile/models/deposits_model.dart';
import 'package:mobile/models/loans_model.dart';
import 'package:mobile/models/p2p_template_model.dart';
import 'package:mobile/models/transactions_model.dart';

class HiveAdapterService{

 static final HiveAdapterService _instance = HiveAdapterService._init();
  static HiveAdapterService get instance => _instance;
  
   addAdapter()async{
   try {
    Hive.registerAdapter(ClientCardsModelAdapter());
    Hive.registerAdapter(DataAdapter());
    Hive.registerAdapter(CardAdapter());
    Hive.registerAdapter(TransactionModelAdapter());
    Hive.registerAdapter(TransactionsDatumAdapter());
    Hive.registerAdapter(ReceiverAdapter());
    Hive.registerAdapter(AccountsDatumAdapter());
    Hive.registerAdapter(AccountsModelAdapter());
    Hive.registerAdapter(P2PTemplatesModelAdapter());
    Hive.registerAdapter(P2pTemplatesDatumAdapter());
    Hive.registerAdapter(P2pReceiverAdapter());
    Hive.registerAdapter(DepositsmodelAdapter());
    Hive.registerAdapter(DepositsDatumAdapter());
    Hive.registerAdapter(LoansModelAdapter());
    Hive.registerAdapter(LoansDatummAdapter());
    Hive.registerAdapter(ClientNameDataAdapter());
    Hive.registerAdapter(ClientNameModelAdapter());
    Hive.registerAdapter(CardsOperationsModelAdapter());
    Hive.registerAdapter(StoryDatumAdapter());
    Hive.registerAdapter(HistoryOperationAdapter());

} catch (e) {
     
   }
  }
  HiveAdapterService._init();
}