import 'package:flutter/foundation.dart';
import 'package:pos_app/core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:pull_to_refresh/pull_to_refresh.dart';

class MagicList extends StatefulWidget {
  final dynamic onLoading;
  final dynamic onItemBuilder;
  final dynamic dataSource;
  final dynamic filterContent;
  final dynamic onReset;

  final bool disableRefresh;
  final bool enableSearch;
  final bool enableFilter;

  MagicList({
    this.onLoading,
    @required this.onItemBuilder,
    @required this.dataSource,
    this.filterContent,
    this.disableRefresh = false,
    this.enableSearch = false,
    this.enableFilter = false,
    this.onReset,
  });

  @override
  MagicListState createState() => MagicListState();
}

class ExtremeRefresher {
  static Map<String, MagicListState> instances = {};
  static void add(String id, MagicListState els) {
    instances[id] = els;
  }

  static void refresh(String id) {
    instances[id].refresh();
  }

  static void remove(String id) {
    instances[id] = null;
  }
}

class MagicListState extends State<MagicList> {
  bool loading = true;
  int page = 1;
  var items = [];
  RefreshController refreshController =
      RefreshController(initialRefresh: false);

  void refresh() async {
    setState(() {
      loading = true;
    });
    onRefresh();
  }

  Future _onLoading(int page) async {
    if (widget.onLoading != null) {
      return await widget.onLoading(1);
    }

    return await https
        .get("${AppSession.baseUrl}${widget.dataSource}", headers: {
      "X-Auth-Token": AppSession.accessToken,
    });
  }

  void onRefresh() async {
    var newItems = await _onLoading(1);
    if (newItems is ApiResponse) {
      handleApiResponse(newItems);
      return;
    }

    items = newItems;
    refreshController.refreshCompleted();
    loading = false;
    if (this.mounted) setState(() {});
  }

  void onLoading() async {
    page++;
    var newItems = await _onLoading(page);
    if (newItems is ApiResponse) {
      handleApiResponse(newItems);
      return;
    }
  }

  void handleApiResponse(ApiResponse response) {
    if (response.status == ApiStatus.success) {
      items = response.data["data"];
      refreshController.loadComplete();
      loading = false;
      if (mounted) setState(() {});
    } else {
      loading = false;
      if (mounted) setState(() {});
    }
    return;
  }

  @override
  void initState() {
    super.initState();

    onRefresh();
    ExtremeRefresher.add(widget.dataSource, this);
    Input.set("search", "%");

    var search = Input.get("search");
    if (search == "%" || search == "" || search == null) {
      searchTextEditingController.text = "";
    } else {
      searchTextEditingController.text = search;
    }
  }

  @override
  void dispose() {
    super.dispose();
    ExtremeRefresher.remove(widget.dataSource);
  }

  getListView() {
    if (loading == false && items.isEmpty) {
      return Center(child: Text(trans("No Data")));
    }

    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return widget.onItemBuilder(context, index, items);
      },
    );
  }

  TextEditingController searchTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    getContent() {
      if (loading) {
        return Center(
          child: CircularProgressIndicator(),
        );
      } else {
        return Theme(
          data: Theme.of(context).copyWith(
            highlightColor: Colors.orange,
          ),
          child: Scrollbar(
            child: Padding(
              padding: const EdgeInsets.all(0.0),
              child: SmartRefresher(
                enablePullDown: false,
                enablePullUp: false,
                header: WaterDropHeader(),
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text(trans("Scroll Down to See More Data"));
                    } else if (mode == LoadStatus.loading) {
                      body = CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed!Click retry!");
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("Release to load more");
                    } else {
                      body = Text("No more Data");
                    }
                    return Container(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: refreshController,
                onRefresh: onRefresh,
                onLoading: onLoading,
                child: getListView(),
              ),
            ),
          ),
        );
      }
    }

    return Container(
      child: getContent(),
    );
  }
}
