// ignore_for_file: unused_local_variable, non_constant_identifier_names, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:sizer/sizer.dart';
import 'dart:convert';
import 'methods.dart';

// ignore: must_be_immutable
class Cate extends StatefulWidget {
  // ignore: non_constant_identifier_names
  String Query;
  // ignore: non_constant_identifier_names, use_key_in_widget_constructors
  Cate({required this.Query});
  @override
  _State createState() => _State();

  @override
  noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _State extends State<Cate> {
  @override
  Widget build(BuildContext context) {
    List<MyNewsQueryModel> newsList = <MyNewsQueryModel>[];
    bool isLoading = true;

    getNews(String Query) async {
      String url = "";
      if (Query == "Top Stories" ||
          Query == "Headlines" ||
          Query == "Sprots News") {
        url =
            "https://newsapi.org/v2/everything?q=Query&from=2021-10-05&to=2021-10-05&sortBy=popularity&apiKey=d4459bea8a1948c8af4d1284ccb160af";
      } else {
        url =
            "https://newsapi.org/v2/everything?q=Query&from=2021-10-05&to=2021-10-05&sortBy=popularity&apiKey=d4459bea8a1948c8af4d1284ccb160af";
      }

      Response response = await get(Uri.parse(url));
      Map data = jsonDecode(response.body);
      setState(() {
        data["articles"].forEach((element) {
          MyNewsQueryModel newsQueryModel = MyNewsQueryModel();
          newsQueryModel = MyNewsQueryModel.fromMap(element);
          newsList.add(newsQueryModel);
          setState(() {
            isLoading = false;
          });
        });
      });
    }

    // ignore: unused_element
    void initState() {
      super.initState();
      getNews(widget.Query);
    }

    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              widget.Query,
              style: TextStyle(fontSize: 3.5.h, fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
              child: isLoading
                  ? CircularProgressIndicator()
                  : ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: newsList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: 1.h, vertical: 1.5.h),
                          child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(1.h)),
                            child: Stack(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(1.h),
                                    child: Image.network(
                                        newsList[index].newsImage)),
                                Positioned(
                                    left: 0,
                                    bottom: 0,
                                    right: 0,
                                    child: Container(
                                        padding: EdgeInsets.fromLTRB(
                                            1.h, 1.5.h, 1.h, 0.5.h),
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(1.h),
                                            gradient: LinearGradient(
                                                colors: [
                                                  Colors.black.withOpacity(0),
                                                  Colors.black
                                                ],
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter)),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              newsList[index].newsHeading,
                                              style: TextStyle(
                                                  fontSize: 2.h,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.white),
                                            ),
                                            Text(
                                                newsList[index]
                                                            .newsDescription
                                                            .length >
                                                        50
                                                    ? "${newsList[index].newsDescription.substring(0, 55)}...."
                                                    : newsList[index]
                                                        .newsDescription,
                                                style: TextStyle(
                                                    fontSize: 1.5.h,
                                                    color: Colors.white))
                                          ],
                                        ))),
                              ],
                            ),
                          ),
                        );
                      }),
            ),
          ],
        ),
      ),
    );
  }
}
