import 'package:pos_app/core.dart';
import 'package:flutter/material.dart';

class ItemTemplate {
  static createItem(label, value) {
    if (value == null) {
      value = "null";
    }
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(trans(label)),
          Text(
            value,
            style: TextStyle(),
          ),
        ],
      ),
    );
  }

  static String onTimeFormatException(e) {
    return "--:--";
  }

  static getTimeFormat(str) {
    try {
      var hh = str.substring(0, 2);
      var mm = str.substring(2, 4);
      return "$hh:$mm";
    } on Exception catch (_) {
      return onTimeFormatException(e);
    }
  }

  static createSimpleItem(label, value1, value2) {
    if (value1 == "" && value2 == "") {
      return Container();
    }

    List<Widget> contents = [];
    if (value1 != "") {
      contents.add(Container(
        height: 30.0,
        child: Text(
          value1,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    if (value2 != "") {
      contents.add(Container(
        height: 30.0,
        child: Text(
          value2,
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ));
    }

    return Container(
      padding: EdgeInsets.only(
        left: 2.0,
        right: 2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(6.0),
                height: 30.0,
                child: Text(
                  trans(label),
                  style: TextStyle(),
                ),
              ),
            ],
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                if (value1 != "")
                  Container(
                    padding: EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              value1.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                if (value2 != "")
                  Container(
                    padding: EdgeInsets.all(6.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            child: Text(
                              value2.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  static getBottomItemTemplate({
    dynamic item,
    dynamic transactionStatus,
    bool disablePendingApprovalBy,
  }) {
    if (item["NamaPending"] == null) {
      item["NamaPending"] = "";
    }

    if (item["NamaApprove"] == null) {
      item["NamaApprove"] = "";
    }

    if (item["NamaApproveKedua"] == null) {
      item["NamaApproveKedua"] = "";
    }

    if (item["NamaTolak"] == null) {
      item["NamaTolak"] = "";
    }

    String namaPending = item["NamaPending"];
    String namaApprove = item["NamaApprovePertama"];
    String namaApproveKedua = item["NamaApproveKedua"];
    String namaTolak = item["NamaTolak"];

    return Container(
      child: Column(
        children: <Widget>[
          createSimpleItem("Disetujui Oleh", namaApprove, namaApproveKedua),
          createSimpleItem("Ditolak Oleh", "", namaTolak),
          if (disablePendingApprovalBy)
            createSimpleItem("Menunggu Persetujuan", namaPending, ""),
        ],
      ),
    );
  }

  static List<Widget> getTemplate(
    item,
    transactionStatus, {
    bool disablePendingApprovalBy = false,
  }) {
    switch (item["KdJnsAbsensi"]) {
      case "CTP":
        var startDate = Format.getDate(DateTime.parse(item["TanggalAwal"]));
        var endDate = Format.getDate(DateTime.parse(item["TanggalAkhir"]));

        var date;
        if (startDate == endDate) {
          date = startDate;
        } else {
          date = "$startDate - $endDate";
        }

        return [
          createItem("Tanggal", date),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "CHD":
        return [
          createItem(
              "Tanggal", Format.getDate(DateTime.parse(item["TanggalAkhir"]))),
          createItem("Leave  Period", item["PeriodeCuti"]),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "CTG":
        var startDate = Format.getDate(DateTime.parse(item["TanggalAwal"]));
        var endDate = Format.getDate(DateTime.parse(item["TanggalAkhir"]));

        var date;
        if (startDate == endDate) {
          date = startDate;
        } else {
          date = "$startDate - $endDate";
        }

        return [
          createItem(
            "Jenis Cuti Spesial",
            item["NmJnsCutiGratis"],
          ),
          createItem("Tanggal", date),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "IFD":
        var startDate = Format.getDate(DateTime.parse(item["TanggalAwal"]));
        var endDate = Format.getDate(DateTime.parse(item["TanggalAkhir"]));

        var date;
        if (startDate == endDate) {
          date = startDate;
        } else {
          date = "$startDate - $endDate";
        }

        return [
          createItem("Tanggal", date),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "INF":
        var jamAwal = Format.getTimeFormat(item["JamAwl"]);
        var jamAkhir = Format.getTimeFormat(item["JamAkhr"]);
        var tanggalAwal = Format.getDate(DateTime.parse(item["TanggalAwal"]));
        var tanggalAkhir = Format.getDate(DateTime.parse(item["TanggalAkhir"]));

        var formattedTanggalAwal = "$tanggalAwal $jamAwal";
        var formattedTanggalAkhir = " $tanggalAkhir $jamAkhir";

        return [
          createItem(
            "Dari",
            formattedTanggalAwal,
          ),
          createItem(
            "Sampai",
            formattedTanggalAkhir,
          ),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "TFD":
        var startDate = Format.getDate(DateTime.parse(item["TanggalAwal"]));
        var endDate = Format.getDate(DateTime.parse(item["TanggalAkhir"]));
        var jamAwal = getTimeFormat(item["JamAwl"]);
        var jamAkhir = getTimeFormat(item["JamAkhr"]);
        var jumlahJamLembur = Format.number(item["JumlahJamLembur"]).toString();

        var date;
        if (startDate == endDate) {
          date = startDate;
        } else {
          date = "$startDate - $endDate";
        }

        return [
          createItem("Tanggal", date),
          createItem(
            "Jam",
            "$jamAwal - $jamAkhir",
          ),
          createItem(
            "Jam Lembur",
            "$jumlahJamLembur ${trans('jam')}",
          ),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "TNF":
        var jamAwal = Format.getTimeFormat(item["JamAwl"]);
        var jamAkhir = Format.getTimeFormat(item["JamAkhr"]);

        var tanggalAwal = Format.getDate(DateTime.parse(item["TanggalAwal"]));
        var tanggalAkhir = Format.getDate(DateTime.parse(item["TanggalAkhir"]));

        var formattedTanggalAwal = "$tanggalAwal $jamAwal";
        var formattedTanggalAkhir = "$tanggalAkhir $jamAkhir";

        return [
          createItem(
            "Dari",
            formattedTanggalAwal,
          ),
          createItem(
            "Sampai",
            formattedTanggalAkhir,
          ),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      case "SPL":
        var jumlahJamLembur = Format.number(item["JumlahJamLembur"]).toString();

        return [
          createItem(
              "Tanggal", Format.getDate(DateTime.parse(item["TglTransaksi"]))),
          createItem(
            "Periode Lembur",
            item["NamaPeriodeLembur"].toString(),
          ),
          createItem(
            "Jam Lembur",
            "$jumlahJamLembur ${trans('jam')}",
          ),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
      default:
        return [
          createItem(
              "Tanggal", Format.getDate(DateTime.parse(item["TglTransaksi"]))),
          getBottomItemTemplate(
            item: item,
            transactionStatus: transactionStatus,
            disablePendingApprovalBy: disablePendingApprovalBy,
          ),
        ];
        break;
    }
  }

  static getHeaderTemplate(
    item, {
    bool noName = false,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (!noName)
          Expanded(
            child: Container(
              child: Text(
                item["NikNm"],
                style: TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        if (!noName)
          Container(
            width: 10.0,
          ),
      ],
    );
  }

  static getFooterApproveConfirmTemplate(
      me, context, items, item, transactionStatus) {
    return Container(
      height: 36.0,
      padding: EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Container(
            width: 60.0,
            child: OutlineButton(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.0),
                  side: BorderSide(color: Colors.red)),
              onPressed: () {},
              child: Icon(
                FontAwesomeIcons.infoCircle,
                color: Colors.blue[400],
              ),
            ),
          ),
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          
          

          
          
          
          
          
          
          
          
          
          Container(
            width: 10.0,
          ),
          Expanded(
            child: ExButton(
              type: ButtonType.danger,
              label: "Tolak",
              icon: Icons.cancel,
              onPressed: () {},
            ),
          ),
          Container(
            width: 10.0,
          ),
          Expanded(
            child: ExButton(
              type: ButtonType.success,
              label: "Setujui",
              icon: Icons.check,
              onPressed: () {
                ExAlert.showApproveConfirmation(
                    context: context,
                    title: "Konfirmasi",
                    message: "Are you sure to Approve this transaction?",
                    onOk: () {
                      Navigator.pop(context);
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  static getFooterDetailDeleteTemplate(
      me, context, items, item, transactionStatus) {
    return Container(
      height: 36.0,
      padding: EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ExButton(
              type: ButtonType.danger,
              outlineButton: true,
              label: "Detail",
              icon: FontAwesomeIcons.infoCircle,
              iconColor: Colors.blue[400],
              iconSize: 20.0,
              onPressed: () {},
            ),
          ),
          Container(
            width: 10.0,
          ),
          Expanded(
            child: ExButton(
              type: ButtonType.danger,
              label: "Hapus",
              onPressed: () {
                ExAlert.showApproveConfirmation(
                    context: context,
                    title: "Konfirmasi",
                    message:
                        "Apakah anda yakin untuk membatalkan transaksi ini?",
                    onOk: () {
                      Navigator.pop(context);
                      me.setState(() {
                        items.remove(item);
                      });
                    });
              },
            ),
          ),
        ],
      ),
    );
  }

  static getFooterDetailTemplate(me, context, items, item, transactionStatus) {
    return Container(
      height: 36.0,
      padding: EdgeInsets.symmetric(
        horizontal: 0.0,
      ),
      margin: EdgeInsets.only(
        top: 10.0,
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            child: ExButton(
              type: ButtonType.danger,
              outlineButton: true,
              label: "Detail",
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
