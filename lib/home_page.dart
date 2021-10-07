// ignore_for_file: avoid_print, avoid_unnecessary_containers, duplicate_ignore, non_constant_identifier_names

import 'dart:convert';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:ansar_news/category.dart';
import 'package:ansar_news/methods.dart';
import 'package:sizer/sizer.dart';
import 'newsview.dart';
import 'category.dart';


// ignore: use_key_in_widget_constructors
class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

// ignore: unnecessary_new
TextEditingController searchcontroller = new TextEditingController();

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    getNews("tech");
    getNewsFromSource("TechCrunch");
  }

  // ignore: annotate_overrides
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.redAccent[700],
            title: Text(
              'MY NEWS APP',
              style: TextStyle(color: Colors.white),
            )),
        // ignore: avoid_unnecessary_containers
        body: Container(
          child: SingleChildScrollView(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  // This is Search Area || This is Search Area || This is Search Area
                  TextField(
                    controller: searchcontroller,
                    textInputAction: TextInputAction.search,
                    onSubmitted: (value) {
                      if (value == "") {
                        print("Blank Search Plz Try Again");
                      } else {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Cate(Query: value)));
                      }
                    },
                    decoration: InputDecoration(
                      hintText: "Search........",
                      fillColor: Colors.white,
                      focusColor: Colors.white,
                    ),
                  ),
                  Container(
                      color: Colors.deepOrangeAccent[400],
                      height: 6.h,
                      child: ListView.builder(
                        itemCount: navBarItems.length,
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          Cate(Query: navBarItems[index])));
                            },
                            child: Container(
                              alignment: Alignment.center,
                              height: 6.h,
                              padding: EdgeInsets.symmetric(
                                  horizontal: 2.h, vertical: 1.h),
                              margin: EdgeInsets.symmetric(
                                horizontal: 0.2.h,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.deepOrangeAccent[400],
                                borderRadius: BorderRadius.circular(5.h),
                              ),
                              child: Center(
                                  child: Text(
                                navBarItems[index],
                                style: TextStyle(
                                    color: Colors.white, fontSize: 2.2.h),
                              )),
                            ),
                          );
                        },
                      )),
                  Loading
                      // ignore: sized_box_for_whitespace
                      ? Container(
                          height: 10.h,
                          child: Center(child: CircularProgressIndicator()))
                      : Container(
                          margin: EdgeInsets.symmetric(vertical: 3.h),
                          child: CarouselSlider(
                            options:
                                CarouselOptions(height: 22.h, autoPlay: true),
                            items: newsListSlider.map((instance) {
                              return Builder(builder: (BuildContext context) {
                                return Container(
                                    // This is inkwell area where Webviews is working
                                    child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              Newsview(instance.newsUrl))),
                                  child: Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      child: Stack(children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1.h),
                                            child: Image.network(
                                              instance.newsImage,
                                              fit: BoxFit.fitHeight,
                                              width: double.infinity,
                                            )),
                                        Positioned(
                                            left: 0,
                                            right: 0,
                                            bottom: 0,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          1.h),
                                                  gradient: LinearGradient(
                                                      colors: [
                                                        Colors.black26
                                                            .withOpacity(0),
                                                        Colors.black
                                                      ],
                                                      begin:
                                                          Alignment.topCenter,
                                                      end: Alignment
                                                          .bottomCenter)),
                                              child: Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 0.5.h,
                                                      vertical: 1.h),
                                                  child: Container(
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal: 10),
                                                      child: Text(
                                                        instance.newsHeading,
                                                        style: TextStyle(
                                                            fontSize: 1.8.h,
                                                            color: Colors.black,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ))),
                                            )),
                                      ])),
                                ));
                              });
                            }).toList(),
                          ),
                        ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 2.h, vertical: 2.h),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Recent News',
                          style: TextStyle(
                              fontSize: 3.5.h,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
                    child: Loading
                        ? CircularProgressIndicator()
                        : ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: newsList.length,
                            itemBuilder: (context, index) {
                              return Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 1.h, vertical: 1.5.h),
                                child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Newsview(
                                              newsList[index].newsUrl))),
                                  child: Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(1.h)),
                                    child: Stack(
                                      children: [
                                        ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(1.h),
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
                                                        BorderRadius.circular(
                                                            1.h),
                                                    gradient: LinearGradient(
                                                        colors: [
                                                          Colors.black
                                                              .withOpacity(0),
                                                          Colors.black
                                                        ],
                                                        begin:
                                                            Alignment.topCenter,
                                                        end: Alignment
                                                            .bottomCenter)),
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      newsList[index]
                                                          .newsHeading,
                                                      style: TextStyle(
                                                          fontSize: 2.h,
                                                          fontWeight:
                                                              FontWeight.bold,
                                                          color: Colors.black),
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
                                                            color:
                                                                Colors.white))
                                                  ],
                                                )))
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            }),
                  ),
                  Container(
                      width: 40.h,
                      height: 5.h,
                      margin:
                          EdgeInsets.symmetric(horizontal: 1.h, vertical: 2.h),
                      child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Cate(Query: "Google")));
                          },
                          child: Center(
                            child: Text('Show More'),
                          ))),
                  SizedBox(
                    height: 2.h,
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  List<MyNewsQueryModel> newsListSlider = <MyNewsQueryModel>[];
  List<MyNewsQueryModel> newsList = <MyNewsQueryModel>[];
  List<String> navBarItems = [
    'Top Stories',
    'Headlines',
    'Popular News',
    'Sports News',
  ];
  bool Loading = true;

  getNews(String Query) async {
    String url =
        "https://newsapi.org/v2/everything?q=Query&from=2021-10-05&to=2021-10-05&sortBy=popularity&apiKey=d4459bea8a1948c8af4d1284ccb160af";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        MyNewsQueryModel newsQueryModel = MyNewsQueryModel();
        newsQueryModel = MyNewsQueryModel.fromMap(element);
        newsList.add(newsQueryModel);
        setState(() {
          Loading = false;
        });
      });
    });
  }

  getNewsFromSource(String source) async {
    String url =
        "https://newsapi.org/v2/everything?q=Query&from=2021-10-05&to=2021-10-05&sortBy=popularity&apiKey=d4459bea8a1948c8af4d1284ccb160af";
    Response response = await get(Uri.parse(url));
    Map data = jsonDecode(response.body);
    setState(() {
      data["articles"].forEach((element) {
        MyNewsQueryModel newsQueryModel = MyNewsQueryModel();
        newsQueryModel = MyNewsQueryModel.fromMap(element);
        newsListSlider.add(newsQueryModel);
        setState(() {
          Loading = false;
        });
      });
    });
  }
}
