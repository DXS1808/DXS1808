import 'package:flutter/material.dart';
import 'package:todo/config/constants/constants.dart';
import 'package:todo/data_sources/local_storage/boxes.dart';
import 'package:todo/model/user_profile.dart';
import 'package:todo/presentation/view/task_screen/user_item.dart';

class SearchItem extends SearchDelegate {
  List<UserProfile> users;

  SearchItem(this.users);



  @override
  TextInputAction get textInputAction => TextInputAction.done;


  @override
  // TODO: implement searchFieldStyle
  TextStyle? get searchFieldStyle => const TextStyle(
    fontFamily: Constants.kFontFamily,
    fontWeight: FontWeight.w400,
    fontSize: 15
  );

  @override
  String get searchFieldLabel => "Enter a search...";

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
        },
        icon: const Icon(Icons.clear),
      ),
    ];
    // TODO: implement buildActions
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      onPressed: () {
        close(context, []);
      },
      icon: const Icon(Icons.arrow_back),
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<UserProfile> matchQuery = [];
    for (var user in users) {
      if (user.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: (context, index) {
        var result = matchQuery[index];
        return UserItem(result);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<UserProfile> matchQuery = [];
    for (var user in users) {
      if (user.name.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(user);
      }
    }
    return matchQuery.isEmpty
        ? Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.grey.withOpacity(0.8),
                ),
                Text(
                  "No data",
                  style: TextStyle(
                      fontSize: 20,
                      fontFamily: Constants.kFontFamily,
                      color: Colors.grey.withOpacity(0.8)),
                )
              ],
            ),
          )
        : ListView.builder(
            itemCount: matchQuery.length,
            itemBuilder: (context, index) {
              var result = matchQuery[index];
              return UserItem(result);
            },
          );
  }
}
