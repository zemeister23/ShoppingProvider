import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/search/components/my_search_widget.dart';
import 'package:smart_farm/size_config.dart';

class SearchResultsPage extends StatefulWidget {
  const SearchResultsPage({Key? key}) : super(key: key);

  @override
  State<SearchResultsPage> createState() => _SearchResultsPageState();
}

class _SearchResultsPageState extends State<SearchResultsPage>
    with TickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: getProportionateScreenWidth(14.0),
                vertical: getProportionateScreenHeight(12.0),
              ),
              child: const MySeachWiget(
                onPage: true,
                readOnly: false,
                onFilter: false,
              ),
            ),
            TabBar(
              labelColor: Colors.black,
              indicatorColor: Colors.black,
              unselectedLabelColor: kPrimaryBorderColor,
              controller: _tabController,
              tabs: List.generate(
                3,
                (index) {
                  return Tab(
                    child: Text(
                      kProducts[index],
                      style: const TextStyle(
                        fontSize: 16.0,
                      ),
                    ),
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
