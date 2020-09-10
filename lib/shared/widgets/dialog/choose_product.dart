import 'package:flutter/material.dart';

class ChooseProductDialog extends StatelessWidget {
  const ChooseProductDialog({
    @required this.title,
    @required this.subtitle,
    @required this.onLeaveClicked,
    @required this.onSafetyClicked,
    Key key,
  }) : super(key: key);

  final String title, subtitle;
  final Function() onLeaveClicked;
  final Function() onSafetyClicked;

  dialogContent(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          
          padding: EdgeInsets.all(50),
          margin: EdgeInsets.only(top: 10, right: 10),
          decoration: new BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(7),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10.0,
                offset: const Offset(0.0, 10.0),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min, 
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 15.0),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 20.0),
                child: Text(
                  subtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(height: 15),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Container(
                              width: 370,
                              height: 377,
                              child: Column(
                                children: <Widget>[
                                  Image.asset(
                                    'assets/images/lms_step.jpg',
                                  ),
                                  Container(height: 10),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "ESS Gaji.id",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Your Staff Leaves Process",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                        "View, Apply, Approve Staff Leaves with one click"),
                                  ),
                                  Container(height: 10),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Owned",
                              style: TextStyle(
                                  color: Colors.green,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 10),
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Column(
                        children: <Widget>[
                          Card(
                            child: Container(
                              width: 370,
                              height: 377,
                              child: Column(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Image.asset(
                                      'assets/images/biz_safe_3.png',
                                    ),
                                  ),
                                  Container(height: 17),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "SAFETY MVP",
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      "Your bizSafe L3 Processes",
                                      style: TextStyle(
                                        fontSize: 17,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                        "Create, Approve, Automate your Risk Assessment, Attendee List and more with one click"),
                                  ),
                                  Container(height: 10),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              "Buy Now!",
                              style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        Positioned(
          right: 0,
          child: Container(
            height: 30,
            padding: const EdgeInsets.only(left: 10.0),
            child: FittedBox(
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                elevation: 0.0,
                backgroundColor: Colors.green,
                child: Icon(
                  Icons.close,
                  size: 27,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          elevation: 0.0,
          backgroundColor: Colors.transparent,
          child: dialogContent(context),
        ),
      ],
    );
  }
}
