import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  final Function(String) onSearch;

  SearchBarWidget({required this.onSearch});

  @override
  _SearchBarWidgetState createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Color.fromRGBO(14, 20, 33, 1),
        ),
        padding: EdgeInsets.symmetric(horizontal: 22, vertical: 11),
        child: Row(
          children: <Widget>[
            Icon(Icons.search, color: Colors.white),
            SizedBox(width: 16),
            Expanded(
              child: TextField(
                controller: _controller,
                style: TextStyle(color: Colors.white),
                cursorColor: Colors.white,
                decoration: InputDecoration(
                  hintText: "Search City...",
                  hintStyle: TextStyle(color: Color.fromRGBO(103, 107, 115, 1)),
                  border: InputBorder.none,
                ),
                onSubmitted: (text) {
                  widget.onSearch(text);
                  _controller.clear();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
