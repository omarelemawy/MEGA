import 'package:flutter/material.dart';

class CoursesSearch extends SearchDelegate {
  CoursesSearch()
      : super(
            searchFieldLabel: 'search_course',
            searchFieldStyle: TextStyle(
                color: Colors.grey,
                fontSize: 18,
                fontFamily: 'Cairo-SemiBold'));
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = '';
          close(context, null);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.arrow_back_ios),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return query.isEmpty
        ? Container()
        :Container() /*FutureBuilder(
            future: ,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                var data = snapshot.data as List<CouresesModels>;
                return (snapshot.data == null || data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(getTranslated(context, "searchFiled")!),
                        ),
                      )
                    : ListView.builder(
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: (data[i].image_path == null)
                                      ? Container(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        )
                                      : customCachedNetworkImage(
                                          context: context,
                                          url: data[i].image_path,
                                        )),
                            ),
                            title: Text(data[i].name!),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CategoriesCoursesPageView(
                                    courses: data[i],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
              } else {
                return Center(
                  child: SpinKitChasingDots(
                    color: customColor,
                    size: 20,
                  ),
                );
              }
            },
          )*/;
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return query.isEmpty
        ? Container()
        :Container() /*FutureBuilder(
            future: HomeDaTaApi.cursesSearch(query),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.hasData) {
                return (snapshot.data == null || snapshot.data.isEmpty)
                    ? Container(
                        child: Center(
                          child: Text(getTranslated(context, "searchFiled")!),
                        ),
                      )
                    : ListView.builder(
                        itemCount: snapshot.data.length,
                        itemBuilder: (context, i) {
                          return ListTile(
                            leading: Container(
                              height: 50,
                              width: 50,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                              ),
                              child: Center(
                                  child: (snapshot.data[i].image_path == null)
                                      ? Container(
                                          child: Icon(
                                            Icons.image,
                                            color: Colors.lightBlueAccent,
                                          ),
                                        )
                                      : customCachedNetworkImage(
                                          context: context,
                                          url: snapshot.data[i].image_path,
                                        )),
                            ),
                            title: Text(snapshot.data[i].name!),
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => CategoriesCoursesPageView(
                                    courses: snapshot.data[i],
                                  ),
                                ),
                              );
                            },
                          );
                        },
                      );
              } else {
                return Center(
                  child: SpinKitChasingDots(
                    color: customColor,
                    size: 20,
                  ),
                );
              }
            },
          )*/;
  }
}
