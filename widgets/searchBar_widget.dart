import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget searchBar() {
  return Container(
    margin: EdgeInsets.symmetric(
      horizontal: 10,
      vertical: 10,
    ),
    height: 40,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(20),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.2),
          offset: Offset(0, 0),
          spreadRadius: 1,
          blurRadius: 4,
        )
      ],
    ),
    child: TextField(
      textAlign: TextAlign.start,
      decoration: InputDecoration(
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        errorBorder: InputBorder.none,
        contentPadding:
            EdgeInsets.only(left: 15, bottom: 12, top: 12, right: 15),
        hintText: "Search",
        suffixIcon: Icon(
          Icons.search,
          color: Colors.grey.withOpacity(0.7),
        ),
      ),
      maxLines: 1,
    ),
  );
}
