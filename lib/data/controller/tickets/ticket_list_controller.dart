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

  Future<void> loadTicketData() async{
    isLoading = true;
    await loadTicketListData();
    isLoading = false;
    update();
  }

  bool hasNext(){
    return nextPageUrl.isNotEmpty && nextPageUrl != 'null' ? true : false;
  }

  String getStatus(int index) {
    String status = ticketList[index].status == 0 ? MyStrings.open
        : ticketList[index].status == 1 ? MyStrings.closed
        : ticketList[index].status == 2 ? MyStrings.customerReply : "";

    return status;
  }

  String getPriority(int index) {
    String status = ticketList[index].priority == 1 ? MyStrings.low :
    ticketList[index].priority == 2 ? MyStrings.medium :
    ticketList[index].priority == 3 ? MyStrings.high : " ";
    return status;
  }

  Color getStatusColor(int index) {
    int status = ticketList[index].status;
    return status == 0 ? MyColor.greenSuccessColor:status == 1 ? MyColor.redCancelTextColor : status == 2 ? MyColor.pendingColor : MyColor.colorGrey;
  }
  Color getPriorityColor(int index) {
    int status = ticketList[index].priority;
    return status == 1 ? MyColor.colorGrey:status == 2 ? MyColor.pendingColor : status == 3 ? MyColor.redCancelTextColor : MyColor.colorGrey;
  }

  Future<void> loadTicketListData() async{


    ResponseModel responseModel = await ticketListRepo.getTicketListData(1);
    print('Response Ticket list == >${responseModel.responseJson}');
    if(responseModel.statusCode == 200){

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