import 'dart:convert';

import 'package:eastern_trust/data/repo/tickets/ticket_list_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/core/utils/my_color.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/utils/url.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/model/withdraw/withdraw_history_response_model.dart';
import 'package:eastern_trust/data/repo/withdraw/withdraw_history_repo.dart';
import 'package:eastern_trust/views/components/file_download_dialog/download_dialogue.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';

class TicketListController extends GetxController {

  TicketListRepo ticketListRepo;
  TicketListController({required this.ticketListRepo});

  bool isLoading = true;
  List<Ticket> ticketList = [];
  String nextPageUrl = "";
  int page=1;

  Future<void> loadInitialTicketData() async{
    page=1;
    loadTicketData();
  }

  Future<void> loadTicketData() async{
    isLoading = true;
    await loadTicketListData();
    isLoading = false;
    update();
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  String getStatusFromCode(int code) {
    switch (code) {
      case 0:
        return MyStrings.open;
      case 1:
        return MyStrings.answered;
      case 2:
        return MyStrings.customerReply;
      case 3:
        return MyStrings.closed;
      default:
        return ' ';
    }
  }

  Color getStatusColorFromCode(int code) {
    switch (code) {
      case 0:
        return MyColor.greenSuccessColor;
      case 1:
        return MyColor.purpleColor;
      case 2:
        return MyColor.pendingColor;
      case 3:
        return MyColor.colorBlack2;
      default:
        return Colors.black;
    }
  }

  String getPriorityFromCode(int code) {
    switch (code) {
      case 1:
        return MyStrings.low;
      case 2:
        return MyStrings.medium;
      case 3:
        return MyStrings.high;
      default:
        return ' ';
    }
  }

  Color getPriorityColorFromCode(int code) {
    switch (code) {
      case 1:
        return MyColor.colorBlack2;
      case 2:
        return MyColor.pendingColor;
      case 3:
        return MyColor.redCancelTextColor;
      default:
        return Colors.black;
    }
  }

  Future<void> loadTicketListData() async{


    ResponseModel responseModel = await ticketListRepo.getTicketListData(page);
    if(responseModel.statusCode == 200){
      page=page+1;
      print("page =====> $page");
      TicketListModel model = responseFromJson(responseModel.responseJson);
      nextPageUrl = model.data.ticketData.nextPageUrl ?? "";
      if(model.status.toString().toLowerCase() == "success"){
        List<Ticket>? ticketListModel = model.data.ticketData.data;
        if(ticketListModel.isNotEmpty){
          ticketList.addAll(ticketListModel);
        }
      }
      else{
        CustomSnackBar.error(errorList: model.hasMessage() ? model.message.success : [MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }
  }

}