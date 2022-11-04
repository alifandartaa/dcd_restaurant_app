import 'package:dcd_restaurant_app/api/api_service.dart';
import 'package:dcd_restaurant_app/provider/search_provider.dart';
import 'package:dcd_restaurant_app/shared/styles.dart';
import 'package:dcd_restaurant_app/widgets/search_item.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatefulWidget {
  static const routeName = '/search_page';

  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    TextEditingController editingController = TextEditingController();
    return ChangeNotifierProvider(
      create: (_) => SearchProvider(apiService: ApiService()),
      child: Consumer<SearchProvider>(builder: (context, state, _) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
            child: ListView(
              // crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: TextField(
                    onSubmitted: (value) {
                      state.searchByQuery(value);
                    },
                    autofocus: true,
                    controller: editingController,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.send,
                    style: const TextStyle(color: textColor),
                    decoration: InputDecoration(
                      hintText: 'Search by name',
                      prefixIcon: const Icon(Icons.search),
                      fillColor: const Color(0xffF6F7FB),
                      filled: true,
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  'Result Search',
                  style: myTextTheme.bodyText1?.copyWith(
                    fontSize: 30,
                  ),
                  textAlign: TextAlign.start,
                ),
                const SizedBox(
                  height: 18,
                ),
                Consumer<SearchProvider>(builder: (context, state, _) {
                  if (state.state == ResultSearchState.loading) {
                    return const Center(child: CircularProgressIndicator());
                  } else {
                    if (state.state == ResultSearchState.hasData) {
                      return SizedBox(
                        height: MediaQuery.of(context).size.height * 0.7,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: state.result?.restaurants.length,
                            itemBuilder: (context, index) {
                              var restaurant = state.result?.restaurants[index];
                              return SearchItem(restaurant: restaurant);
                            }),
                      );
                    } else if (state.state == ResultSearchState.noData) {
                      return Center(
                        child: Material(
                          child: Text(state.message),
                        ),
                      );
                    } else {
                      return const Material(
                          child: Center(child: Text('No Internet Connection')));
                    }
                  }
                }),
              ],
            ),
          ),
        );
      }),
    );
  }
}
