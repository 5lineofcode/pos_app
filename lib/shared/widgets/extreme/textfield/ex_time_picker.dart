import 'package:flutter/material.dart';
import 'package:pos_app/core.dart';

class ExTimePicker extends StatefulWidget {
  final String id;
  final String label;
  final IconData icon;
  final String value;
  final BuildContext context;
  final String dateFormat;
  final initialDate;

  final bool enableDatePicker;
  final bool startWithBlankValue;

  ExTimePicker({
    @required this.id,
    @required this.label,
    @required this.context,
    this.icon = FontAwesomeIcons.clock,
    this.value,
    this.enableDatePicker = true,
    this.dateFormat = "hh:mm",
    this.initialDate,
    this.startWithBlankValue = false,
  });

  @override
  ExTimePickerState createState() => ExTimePickerState();
}

class ExTimePickerState extends State<ExTimePicker> {
  String customInitialDate;
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    Input.timePickerController[widget.id] = this;

    if (widget.value == null) {
      Input.set(widget.id, DateTime.now().toString());

      if (!widget.startWithBlankValue) {
        selectedDate = DateTime.now();
      }
    } else {
      Input.set(widget.id, widget.value);
      selectedDate = DateTime.parse(widget.value.toString());
    }
  }

  Future selectDate(BuildContext context) async {
    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(DateTime.now()),
    );

    if (time == null) return;

    var now = DateTime.now();

    selectedDate = DateTime(now.year, now.month, now.day, time.hour ?? now.hour,
        time.minute ?? now.minute);

    setState(() {
      Input.set(widget.id, selectedDate.toString());
      Input.timePickerController[widget.id].setValue(selectedDate.toString());
      Input.set("${widget.id}_displayField",
          Input.timePickerController[widget.id].getDisplayValue());
    });
  }

  void setValue(newValue) {
    setState(() {
      selectedDate = DateTime.parse(newValue.toString());
      Input.textEditingController["${widget.id}_displayField"].text =
          DateFormat(widget.dateFormat)
              .format(DateTime.parse(newValue.toString()))
              .toString();
      Input.set(widget.id, newValue.toString());
    });
  }

  setInitialDate(String newInitialDate) {
    customInitialDate = newInitialDate;
  }

  String getValue() {
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
      initialDate = DateTime.parse(widget.initialDate);
    }

    return initialDate;
  }

  @override
  Widget build(BuildContext context) {
    getLabel() {
      return Container(
        padding: EdgeInsets.only(
          left: 4.0,
          right: 4.0,
          top: 4.0,
          bottom: 4.0,
        ),
        width: MediaQuery.of(context).size.width,
        child: Text(trans(widget.label),
            style: TextStyle(
              fontSize: Theme.of(context).textTheme.bodyText1.fontSize,
              fontFamily: Theme.of(context).textTheme.bodyText1.fontFamily,
              color: Theme.of(context).textTheme.bodyText1.color,
            )),
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
                  child: ExTextFieldBase(
                    id: "${widget.id}_displayField",
                    label: null,
                    icon: widget.icon == null ? Icons.search : widget.icon,
                    useBorder: false,
                    useIcon: false,
                    enable: false,
                    value: selectedDate == null
                        ? "-"
                        : DateFormat(widget.dateFormat).format(selectedDate),
                    valueFromController: true,
                    onContainerTap: () {
                      selectDate(context);
                    },
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
                ),
              ],
            ),
          ],
        ),
      );
    }

    return Container(
      padding: EdgeInsets.symmetric(vertical: 3.5),
      child: Column(
        children: <Widget>[
          getLabel(),
          getTextField(),
        ],
      ),
    );
  }
}

class CustomPicker extends CommonPickerModel {
  String digits(int value, int length) {
    return '$value'.padLeft(length, "0");
  }

  CustomPicker({DateTime currentTime, LocaleType locale})
      : super(locale: locale) {
    this.currentTime = currentTime ?? DateTime.now();
    this.setLeftIndex(this.currentTime.hour);
    this.setMiddleIndex(this.currentTime.minute);
    this.setRightIndex(this.currentTime.minute);
  }

  @override
  String leftStringAtIndex(int index) {
    if (index >= 0 && index < 24) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String middleStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String rightStringAtIndex(int index) {
    if (index >= 0 && index < 60) {
      return this.digits(index, 2);
    } else {
      return null;
    }
  }

  @override
  String leftDivider() {
    return "|";
  }

  @override
  String rightDivider() {
    return "|";
  }

  @override
  List<int> layoutProportions() {
    return [1, 2, 1];
  }

  @override
  DateTime finalTime() {
    return currentTime.isUtc
        ? DateTime.utc(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex())
        : DateTime(
            currentTime.year,
            currentTime.month,
            currentTime.day,
            this.currentLeftIndex(),
            this.currentMiddleIndex(),
            this.currentRightIndex());
  }
}
