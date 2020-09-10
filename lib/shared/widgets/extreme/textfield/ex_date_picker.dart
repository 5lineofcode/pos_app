import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class DatePickerConfig {
  static DateTime blankStartDate = DateTime.parse("0000-01-01");
  static DateTime blankEndDate = DateTime.parse("9999-12-31");

  static DateTime getFirstDateOfMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, 1);
  }

  static DateTime getLastDateOfMonth() {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month + 1, 0);
  }

  static DateTime getFirstDateByMonth(DateTime time) {
    return DateTime(time.year, time.month, 1);
  }

  static DateTime getLastDateByMonth(DateTime time) {
    return DateTime(time.year, time.month + 1, 0);
  }
}

class ExDatePicker extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final String value;
  final DateTime initialDate;
  final BuildContext context;
  final String dateFormat;
  final DateTime firstDate;
  final double labelFontSize;

  final bool enableDatePicker;
  final bool enablePreviousFilter;
  final bool enableNextFilter;
  final dynamic onChanged;

  ExDatePicker({
    @required this.id,
    @required this.label,
    @required this.context,
    this.icon = FontAwesomeIcons.calendarAlt,
    this.value,
    this.labelFontSize,
    this.initialDate,
    this.firstDate,
    this.enableDatePicker = true,
    this.dateFormat = "d MMM y",
    this.onChanged,
    this.enableNextFilter = false,
    this.enablePreviousFilter = false,
  });

  @override
  ExDatePickerState createState() => ExDatePickerState();
}

class ExDatePickerState extends State<ExDatePicker> {
  String customInitialDate;
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    Input.datePickerController[widget.id] = this;

    if (widget.value == null) {
      Input.set(widget.id, DateTime.now().toString());
    } else {
      Input.set(widget.id, DateTime.parse(widget.value.toString()));

      selectedDate = DateTime.parse(widget.value.toString());
      setInitialDate(selectedDate.toString());
    }
  }

  void setValue(newValue) {
    setState(() {
      selectedDate = DateTime.parse(newValue.toString());

      Input.set(
          "${widget.id}_displayField",
          DateFormat(widget.dateFormat)
              .format(DateTime.parse(newValue.toString()))
              .toString());

      Input.set(widget.id, newValue.toString());
    });
  }

  setInitialDate(String newInitialDate) {
    customInitialDate = newInitialDate;
  }

  getValue() {
    var currentValue = Input.get(widget.id);
    return currentValue;
  }

  String getDisplayValue() {
    var currentValue = Input.get(widget.id);
    return DateFormat(widget.dateFormat).format(DateTime.parse(currentValue));
  }

  getInitialDate() {
    var initialDate = DateTime.now();

    if (customInitialDate != null) {
      initialDate = DateTime.parse(customInitialDate);
    }

    if (widget.initialDate != null) {
      initialDate = DateTime.parse(widget.initialDate.toString());
    }

    return initialDate;
  }

  Future selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        
        initialDate: getInitialDate() ?? DateTime.now(),
        
        
        
        
        firstDate: widget.firstDate ?? DatePickerConfig.blankStartDate,
        lastDate: DatePickerConfig.blankEndDate,
        builder: (context, child) {
          return Center(
            child: SizedBox(
              width: 500,
              height: 600,
              child: child,
            ),
          );
        });

    debugPrint(picked.toString());

    if (picked != null && picked != selectedDate) {
      if (selectedDate == null) {
        selectedDate = DateTime.now();
      }

      setState(() {
        selectedDate = picked;
        Input.set(widget.id, selectedDate.toString());
        Input.datePickerController[widget.id].setValue(selectedDate.toString());
        Input.set("${widget.id}_displayField",
            Input.datePickerController[widget.id].getDisplayValue());
      });

      setInitialDate(selectedDate.toString());
      if (widget.onChanged != null) {
        widget.onChanged();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    getDisplayField() {
      String displayField = "";

      if (selectedDate != null) {
        if (selectedDate == DatePickerConfig.blankStartDate ||
            selectedDate == DatePickerConfig.blankEndDate) {
          displayField = "-";
        } else {
          displayField = DateFormat(widget.dateFormat)
              .format(DateTime.parse(selectedDate.toString()));
        }
      } else {
        displayField = widget.initialDate == null
            ? "--  Select Date  --"
            : DateFormat(widget.dateFormat)
                .format(DateTime.parse(getInitialDate().toString()));
      }

      return displayField;
    }

    getLabel() {
      return Container(
        padding: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
          top: 4.0,
          bottom: 4.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: Text(
          trans(widget.label),
          style: TextStyle(
            color: Theme.of(context).textTheme.bodyText1.color,
            fontSize: widget.labelFontSize ??
                Theme.of(context).textTheme.bodyText1.fontSize,
            fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
          ),
        ),
      );
    }

    getTextField() {
      return Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[300],
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(4.0)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: InkWell(
                    onTap: () {
                      selectDate(context);
                    },
                    child: Container(
                      height: 40,
                      padding: EdgeInsets.symmetric(horizontal: 10.0),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        getDisplayField(),
                        style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.bodyText2.fontSize,
                          fontFamily:
                              Theme.of(context).textTheme.bodyText2.fontFamily,
                          color: widget.initialDate == null
                              ? Colors.grey[600]
                              : Theme.of(context).textTheme.bodyText2.color,
                        ),
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    selectDate(context);
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      widget.icon,
                      color: Theme.of(context).textTheme.bodyText1.color,
                    ),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    showMoreAction() {
      List<Widget> filterWidgets = [];

      if (widget.enableNextFilter) {
        filterWidgets.addAll([
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: "Next Week",
              type: Colors.orange[300],
              onPressed: () {
                var time = DateTime.now().add(Duration(days: 7));
                setValue(time);
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: "Next Month",
              type: Colors.orange[300],
              onPressed: () {
                var time = DateTime.now().add(Duration(days: 30));
                setValue(time);
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: "Next 3-Month",
              type: Colors.orange[300],
              onPressed: () {
                var time = DateTime.now().add(Duration(days: 120));
                setValue(time);
                Navigator.pop(context);
              },
            ),
          ),
        ]);
      }

      if (widget.enablePreviousFilter) {
        filterWidgets.addAll([
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: "Previous Week",
              type: Colors.red[300],
              onPressed: () {
                var time = DateTime.now().add(Duration(days: -7));
                setValue(time);
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: "Last Month",
              type: Colors.red[300],
              onPressed: () {
                var time = DateTime.now().add(Duration(days: -30));
                setValue(time);
                Navigator.pop(context);
              },
            ),
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            child: ExButton(
              label: "3 Month Ago",
              type: Colors.red[300],
              onPressed: () {
                var time = DateTime.now().add(Duration(days: -120));
                setValue(time);
                Navigator.pop(context);
              },
            ),
          ),
        ]);
      }
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              padding: EdgeInsets.all(10.0),
              child: Wrap(
                children: filterWidgets,
              ),
            );
          });
    }

    getCustomButtons() {
      return Container(
        margin: EdgeInsets.only(top: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            ExSmallButton(
              label: "Today",
              type: ButtonType.warning,
              onPressed: () {
                setValue(DateTime.now());
              },
            ),
            Container(
              width: 4.0,
            ),
            ExSmallButton(
              label: "...",
              width: 45,
              type: ButtonType.warning,
              onPressed: () => showMoreAction,
            ),
          ],
        ),
      );
    }

    return Container(
      child: Column(
        children: <Widget>[
          getLabel(),
          getTextField(),
          if (widget.enableNextFilter || widget.enablePreviousFilter)
            getCustomButtons(),
        ],
      ),
    );
  }
}
