import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ExTable extends StatefulWidget {
  final List columns;
  final List items;

  ExTable({
    @required this.columns,
    @required this.items,
  });
  @override
  _ExTableState createState() => _ExTableState();
}

class _ExTableState extends State<ExTable> {
  int selectedIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          padding: EdgeInsets.all(8.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Expanded(
                child: ExTextField(
                  id: "nama",
                  label: "Search",
                  hintText: "Search",
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.tune),
              ),
            ],
          ),
        ),
        Table(
          border: TableBorder.all(
            color: Colors.grey[300],
            width: 1.0,
          ),
          children: [
            TableRow(
              children: [
                for (var column in widget.columns)
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      column["text"],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      "Action",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            for (var item in widget.items)
              TableRow(
                children: [
                  for (var column in item)
                    Container(
                      padding: EdgeInsets.all(8.0),
                      child: Text(column["text"]),
                    ),
                  Container(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: <Widget>[
                        ExButton(
                          label: "Approve",
                          type: ButtonType.success,
                          onPressed: () {},
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        ExButton(
                          label: "Reject",
                          type: ButtonType.danger,
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
          ],
        ),
        Container(
          child: Column(
            children: <Widget>[
              Text("Showing 1 to 10 of 57 entries"),
              Row(
                children: <Widget>[
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(0.0))),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    margin: EdgeInsets.only(right: 2.0),
                    child: Center(
                      child: Text(
                        "Prev",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                  for (var i = 1; i <= 7; i++)
                    InkWell(
                      onTap: () {
                        setState(() {
                          selectedIndex = i;
                        });
                      },
                      child: Container(
                        height: 30.0,
                        decoration: BoxDecoration(
                            color: i == selectedIndex
                                ? Theme.of(context).primaryColor
                                : Colors.transparent,
                            border: Border.all(
                              color: Colors.grey[300],
                              width: 1.0,
                            ),
                            borderRadius:
                                BorderRadius.all(Radius.circular(0.0))),
                        padding: EdgeInsets.symmetric(horizontal: 8.0),
                        margin: EdgeInsets.only(right: 2.0),
                        child: Center(
                          child: Text(
                            i <= 6 ? i.toString() : "...",
                            style: TextStyle(
                              fontSize: 14.0,
                              color: i == selectedIndex ? Colors.white : null,
                            ),
                          ),
                        ),
                      ),
                    ),
                  Container(
                    height: 30.0,
                    decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey[300],
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.all(Radius.circular(0.0))),
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Center(
                      child: Text(
                        "Next",
                        style: TextStyle(
                          fontSize: 10.0,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
