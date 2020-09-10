import 'package:double_back_to_close_app/double_back_to_close_app.dart';
import 'package:flutter/foundation.dart';

import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ExScaffold extends StatefulWidget {
  final String title;
  final List<Widget> actions;

  final Widget floatingActionButton;
  final Widget drawer;
  final String backgroundImageAssetUrl;
  final dynamic binaryBackgroundImage;
  final double height;
  final Widget headerContent;
  final Widget body;
  final Widget bottomNavigationBar;

  final bool resizeToAvoidBottomPadding;
  final bool resizeToAvoidBottomInset;
  final bool hideAppBar;
  final bool disableTranslation;
  final bool forceFullWidth;
  final bool doubleTapToClose;
  final double backgroundOpacity;
  final bool scrollableCoverScaffold;
  final PreferredSizeWidget bottom;

  final TabController tabController;

  final Color backgroundColor;

  ExScaffold({
    this.title = "",
    this.actions,
    this.floatingActionButton,
    this.drawer,
    this.backgroundImageAssetUrl,
    this.binaryBackgroundImage,
    this.height = 200.0,
    this.headerContent,
    this.body,
    this.bottomNavigationBar,
    this.bottom,
    this.resizeToAvoidBottomPadding = false,
    this.resizeToAvoidBottomInset = false,
    this.hideAppBar = false,
    this.disableTranslation = false,
    this.forceFullWidth = false,
    this.tabController,
    this.backgroundColor,
    this.doubleTapToClose = false,
    this.backgroundOpacity = 0.3,
    this.scrollableCoverScaffold = false,
  });

  @override
  ExScaffoldState createState() => ExScaffoldState();
}

class ExScaffoldState extends State<ExScaffold> {
  double headerHeight = 80.0;
  bool isOverlayVisible = false;
  Widget overlayWidget = Container();

  show(Widget assignedOverlayWidget) {
    overlayWidget = assignedOverlayWidget;
    isOverlayVisible = true;
    if (this.mounted) setState(() {});
  }

  hide() {
    overlayWidget = Container();
    isOverlayVisible = false;
    if (this.mounted) setState(() {});
  }

  getOverlay() {
    if (!isOverlayVisible) {
      return Container();
    }
    return overlayWidget;
  }

  bool isNormalScaffold() {
    return widget.headerContent == null &&
        widget.backgroundImageAssetUrl == null &&
        widget.binaryBackgroundImage == null;
  }

  bool isHasBackgroundCover() {
    return widget.backgroundImageAssetUrl == null &&
        widget.binaryBackgroundImage == null;
  }

  getWebBody() {
    return Stack(
      children: <Widget>[
        Row(
          children: <Widget>[
            Spacer(),
            getBodyWithContraint(),
            Spacer(),
          ],
        ),
      ],
    );
  }

  getMobileBody() {
    return Container(
      color: Colors.grey[200],
      child: Stack(
        children: <Widget>[
          widget.body,
        ],
      ),
    );
  }

  getBody() {
    if (kIsWeb) {
      return getWebBody();
    } else {
      return getMobileBody();
    }
  }

  getAppBar() {
    if (widget.hideAppBar) {
      return null;
    }
    return ExAppBar.getAppBar(
      context: context,
      title: trans(widget.title),
      actions: widget.actions,
      bottom: widget.bottom,
    );
  }

  getBottomNavigationBar() {
    if (widget.bottomNavigationBar == null) {
      return null;
    }
    return Container(
      height: 70.0,
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.center,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: !kIsWeb || widget.forceFullWidth
                    ? MediaQuery.of(context).size.width
                    : 960.0,
              ),
              child: widget.bottomNavigationBar,
            ),
          ),
        ],
      ),
    );
  }

  getMobileScaffold() {
    return Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: getAppBar(),
      bottomNavigationBar: getBottomNavigationBar(),
      backgroundColor: Colors.transparent,
      body: getBody(),
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  getDoubleTappedBody() {
    return DoubleBackToCloseApp(
      snackBar: const SnackBar(
        content: Text('Tap back again to leave'),
      ),
      child: getBody(),
    );
  }

  getDoubleTabToCloseContainer() {
    return Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: getAppBar(),
      bottomNavigationBar: getBottomNavigationBar(),
      backgroundColor: Colors.transparent,
      body: widget.doubleTapToClose ? getDoubleTappedBody() : getBody(),
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  getNormalScaffold() {
    return WillPopScope(
      onWillPop: () {
        if (ExOverlayState.isOverlayShown) {
          debugPrint("Cant back from here");
          return Future.value(false);
        }
        return Future.value(true);
      },
      child: Stack(
        children: <Widget>[
          Container(
            color: Colors.grey[100],
            height: MediaQuery.of(context).size.height,
            child: getDoubleTabToCloseContainer(),
          ),
        ],
      ),
    );
  }

  getBodyContainerBasedOnPlatform() {
    return Align(
      alignment: Alignment.center,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: !kIsWeb || widget.forceFullWidth
              ? MediaQuery.of(context).size.width
              : 960.0,
        ),
        child: getBody(),
      ),
    );
  }

  getMainBackgroundScaffold() {
    return Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(widget.height - 35.0),
        child: AppBar(
          title: Text(
            trans(widget.title),
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 10.0,
          actions: widget.actions,
          bottom: widget.bottom,
        ),
      ),
      bottomNavigationBar: getBottomNavigationBar(),
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            getBodyContainerBasedOnPlatform(),
          ],
        ),
      ),
      drawer: widget.drawer,
      floatingActionButton: widget.floatingActionButton,
    );
  }

  getDefaultBackgroundCover() {
    return Container(
      height: widget.height,
      color: Theme.of(context).primaryColor,
    );
  }

  getBackgroundCover() {
    if (this.isHasBackgroundCover()) {
      return getDefaultBackgroundCover();
    }

    return Container(
      width: MediaQuery.of(context).size.width,
      height: widget.height,
      child: widget.backgroundImageAssetUrl != null
          ? Image.asset(
              widget.backgroundImageAssetUrl,
              fit: BoxFit.cover,
            )
          : Image.memory(
              widget.binaryBackgroundImage,
              fit: BoxFit.cover,
            ),
      color: Colors.red,
    );
  }

  getBackgroundBlackOpacity() {
    return Opacity(
      opacity: widget.backgroundOpacity,
      child: Container(
        color: Colors.black,
        width: MediaQuery.of(context).size.width,
        height: widget.height,
      ),
    );
  }

  getCoveredScaffoldTitle() {
    return Container(
      height: 90,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: Text(
            trans(widget.title),
            style: TextStyle(
              fontSize: 16.0,
            ),
          ),
          backgroundColor: Colors.transparent,
          elevation: 10.0,
          actions: widget.actions,
        ),
      ),
    );
  }

  getBodyWithContraint() {
    return Container(
      constraints: BoxConstraints(
        maxWidth:
            !widget.forceFullWidth ? 960.0 : MediaQuery.of(context).size.width,
      ),
      child: widget.body,
    );
  }

  getCoveredScaffold() {
    if (widget.scrollableCoverScaffold) {
      return getScrollableCoveredScaffold();
    }

    var coveredStack = Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      bottomNavigationBar: getBottomNavigationBar(),
      body: Container(
        child: Column(
          children: <Widget>[
            if (!kIsWeb)
              Container(
                child: Stack(
                  children: <Widget>[
                    getBackgroundCover(),
                    getBackgroundBlackOpacity(),
                    getHeaderContentContainer(),
                    getCoveredScaffoldTitle(),
                  ],
                ),
              ),
            if (kIsWeb)
              Container(
                child: Stack(
                  children: <Widget>[
                    getBackgroundCover(),
                    getBackgroundBlackOpacity(),
                    getHeaderContentContainer(),
                    getCoveredScaffoldTitle(),
                  ],
                ),
              ),
            Expanded(
              child: getBody(),
            ),
          ],
        ),
      ),
    );

    return coveredStack;
  }

  getScrollableCoveredScaffold() {
    var coveredStack = Scaffold(
      resizeToAvoidBottomPadding: widget.resizeToAvoidBottomPadding,
      resizeToAvoidBottomInset: widget.resizeToAvoidBottomInset,
      bottomNavigationBar: getBottomNavigationBar(),
      body: SingleChildScrollView(
        reverse: true,
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: <Widget>[
            Container(
              child: Stack(
                children: <Widget>[
                  getBackgroundCover(),
                  getBackgroundBlackOpacity(),
                  getHeaderContentContainer(),
                  getCoveredScaffoldTitle(),
                ],
              ),
            ),
            getBody(),
          ],
        ),
      ),
    );

    return coveredStack;
  }

  getHeaderContentContainer() {
    return Positioned(
      top: 90,
      left: 0,
      bottom: 0,
      right: 0,
      child: Container(
        child: widget.headerContent,
      ),
    );
  }

  static ExScaffoldState instance;
  @override
  void initState() {
    super.initState();
    headerHeight = widget.bottom == null ? 80.0 : 130.0;
  }

  @override
  Widget build(BuildContext context) {
    instance = this;

    if (isNormalScaffold()) {
      return getNormalScaffold();
    } else {
      return getCoveredScaffold();
    }
  }
}

showOverlay(Widget assignedOverlayWidget) {
  if (ExOverlayState.isOverlayShown) {
    hideOverlay();
  }
  ExScaffoldState.instance.show(assignedOverlayWidget);
  ExOverlayState.isOverlayShown = true;
}

showAlert(Widget assignedOverlayWidget) {
  if (ExOverlayState.isOverlayShown) {
    hideOverlay();
  }
  ExScaffoldState.instance.show(
    Positioned(
      left: 0,
      top: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Colors.red,
        child: Center(
          child: assignedOverlayWidget,
        ),
      ),
    ),
  );
  ExOverlayState.isOverlayShown = true;
}

hideOverlay() {
  ExScaffoldState.instance.hide();
  ExOverlayState.isOverlayShown = false;
}

class ExOverlayState {
  static bool isOverlayShown = false;
}
