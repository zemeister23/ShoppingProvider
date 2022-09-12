import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/core/base/state/base_state.dart';
import 'package:mobile/core/base/view/base_view.dart';
import 'package:mobile/core/components/loading/loading_page.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/offerta_model.dart';
import 'package:mobile/provider/4_oferta_provider.dart';
import 'package:mobile/widgets/appbar/default_appbar.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:provider/provider.dart';
class ViewOffertaScreen extends StatefulWidget {
  const ViewOffertaScreen({ Key? key }) : super(key: key);
  @override
  State<ViewOffertaScreen> createState() => _ViewOffertaScreenState();
}
class _ViewOffertaScreenState extends BaseState<ViewOffertaScreen> {
  @override
  void initState() {
    Provider.of<OfertaProvider>(context,listen: false).checkbox = false;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return BaseView(
      viewModal: ViewOffertaScreen,
      onPageBuilder: (BuildContext context,widget) { 
        return  Scaffold(
        backgroundColor: ColorConst.instance.kBackgroundColor,
        appBar:DefaultAppbar.getAppBar("oferta".locale, null, context, true), 
        body: FutureBuilder<OffertaModel>(
          future: context.ofertaPr.getOferta(),
        builder: (BuildContext context ,AsyncSnapshot snap){
          if(!snap.hasData){
            return LoadingPage(true);
          }
          else if(snap.hasError){
             return Center(child: Text("EROR"),);
          }
          else{
            return  Column(  
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [  
              Expanded(
                flex: 4,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
              Text("oferta".locale,
              style:context.theme.headline1,
              //textAlign: TextAlign.center,
              ),
              SizedBox(height: context.h * 0.02,),
              Text(GetStorageService.instance.box.read(GetStorageService.instance.ofertaText.toString()),
              style: context.theme.bodyText1,
                    ),
                      ],
                    ),
                  ),
                )),
            
          
            ],
          );
    
      
          }
      
        },
    
        ),

   ); 
      },
    );
  }

}   
