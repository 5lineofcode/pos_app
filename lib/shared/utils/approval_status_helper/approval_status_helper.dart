import 'package:flutter/material.dart';

class ApprovalStatus {
  final int id;
  final String approvalStatusName;
  final Color backgroundColor;
  final Color textColor;

  ApprovalStatus({
    this.id,
    this.approvalStatusName,
    this.backgroundColor,
    this.textColor,
  });
}

class ApprovalStatusHelper {
  static ApprovalStatus getValue(int approvalStatusId) {
    if (approvalStatusId == 1) {
      return ApprovalStatus(
        id: approvalStatusId,
        approvalStatusName: "Pending",
        backgroundColor: Colors.yellow[900],
        textColor: Colors.white,
      );
    } else if (approvalStatusId == 2) {
      return ApprovalStatus(
        id: approvalStatusId,
        approvalStatusName: "Approved",
        backgroundColor: Colors.green[500],
        textColor: Colors.white,
      );
    } else {
      return ApprovalStatus(
        id: approvalStatusId,
        approvalStatusName: "Rejected",
        backgroundColor: Colors.red[500],
        textColor: Colors.white,
      );
    }
  }
}
