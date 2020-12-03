import 'package:flutter/material.dart';

class SearchBox extends StatelessWidget {
  final double kDefaultPadding = 5.0;
  final ValueChanged onChanged;
  final ValueChanged onSubmitted;
  final TextEditingController textController;
  final bool audioFocus;

  const SearchBox(
      {Key key,
      this.onChanged,
      this.onSubmitted,
      this.textController,
      this.audioFocus})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(kDefaultPadding),
      padding: EdgeInsets.symmetric(
        horizontal: kDefaultPadding,
        vertical: kDefaultPadding / 4, // 5 top and bottom
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.4),
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextField(
        controller: this.textController,
        autofocus: this.audioFocus,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          icon: Icon(Icons.search),
          hintText: 'Search',
          hintStyle: TextStyle(color: Colors.white),
          suffixIcon: IconButton(
            icon: Icon(
              Icons.cancel,
              color: Color(0xFFE0E0E0),
              size: 25.0,
            ),
            onPressed: () {
              this.textController.clear();
            },
          ),
        ),
      ),
    );
  }
}
