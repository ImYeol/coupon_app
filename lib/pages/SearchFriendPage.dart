import 'package:cached_network_image/cached_network_image.dart';
import 'package:coupon_app/components/SearchBox.dart';
import 'package:coupon_app/model/FriendResult.dart';
import 'package:flutter/material.dart';

class SearchFriendPage extends StatefulWidget {
  SearchFriendPage({Key key}) : super(key: key);

  @override
  _SearchFriendPageState createState() => _SearchFriendPageState();
}

class _SearchFriendPageState extends State<SearchFriendPage> {
  final myController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      color: Colors.black87,
      child: getBody(context),
    ));
  }

  @override
  void initState() {
    super.initState();
    //myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    myController.dispose();
    super.dispose();
  }

  Widget getBody(BuildContext context) {
    return SafeArea(
        child: Column(
      children: [
        // search box
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: [
            IconButton(
              icon: Icon(
                Icons.arrow_back,
                color: Color(0xFFE0E0E0),
                size: 25.0,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            Expanded(
                child: SearchBox(
              onChanged: (value) {
                //print(value);
              },
              onSubmitted: (value) {
                print("onSubmitted : $value");
              },
              textController: myController,
              audioFocus: true,
            )),
          ],
        ),
        // search result view
        SizedBox(
          height: 80.0,
        ),
        getProfileInfo("https://i.imgur.com/iQkzaTO.jpg", "yeol12342134234")
      ],
    ));
  }

  Widget getProfileInfo(String imageUrl, String name) {
    return imageUrl == null
        ? Center(
            child: Text(
            "There is no result",
            style: TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ))
        : Center(
            child: Column(
              children: [
                Container(
                  width: 100.0,
                  height: 100.0,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: CachedNetworkImageProvider(imageUrl),
                      )),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Text(
                  "$name",
                  style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  height: 10.0,
                ),
                // Add button
                Container(
                  height: 50.0,
                  width: 150.0,
                  child: RaisedButton(
                    onPressed: () {},
                    child: Text(
                      "ADD",
                      style: TextStyle(color: Colors.white, fontSize: 30.0),
                    ),
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          );
  }
}
