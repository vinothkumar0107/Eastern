import 'dart:convert';

import 'package:eastern_trust/data/repo/tickets/ticket_list_repo.dart';
import 'package:eastern_trust/views/screens/tickets/reply_ticket.dart';
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
import 'package:eastern_trust/data/repo/tickets/reply_ticket_repo.dart';
import 'dart:io';


class ReplyTicketController extends GetxController{

  ReplyTicketRepo replyTicketRepo;
  VoidCallback onReplyComplete;
  ReplyTicketController({required this.replyTicketRepo, required this.onReplyComplete});

  bool isLoading = true;
  String ticketId = "";
  String id = "";
  ReplyTicketData replyModel = ReplyTicketData();
  TextEditingController messageController = TextEditingController();
  bool submitLoading = false;
  bool closeLoading = false;
  List<File>? selectedFilesData = [];
  List<String> selectedFiles = [];


  Future<void> getViewTicketData() async{
    isLoading = true;
    await loadViewTicket();
    isLoading = false;
    update();
  }

  Future<void> loadViewTicket() async{

    ResponseModel responseModel = await replyTicketRepo.getViewTicket(ticketId: ticketId);
    if(responseModel.statusCode == 200){
      ViewReplyTicketModel model = responseFromReplyTicket(responseModel.responseJson);
      if(model.status.toString().toLowerCase() == "success"){
        replyModel = model.data;
      }
      else{
        CustomSnackBar.error(errorList: [responseModel.message].isNotEmpty ? [responseModel.message] : [MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }
  }

  Future<void> submitTicket() async {

    submitLoading = true;
    update();

    ReplyData ticketData=ReplyData(
        ticketId: id.toString(),
        messageStr: messageController.text,
        selectedFilesData: selectedFilesData
    );
    bool b= await replyTicketRepo.submitReply(ticketData);
    if(b){
      // Get.offAllNamed(RouteHelper.homeScreen);
      submitLoading = false;
      update();
      getViewTicketData();
      clearData();
      return;
    }

    submitLoading = false;
    update();

  }

  Future<void> closeTicket() async{
    closeLoading = true;
    await closeTicketFunc();
    closeLoading = false;
    update();
  }

  Future<void> closeTicketFunc() async{
    ResponseModel responseModel = await replyTicketRepo.closeTicket(ticketId: ticketId);
    if(responseModel.statusCode == 200){
      CloseTicketModel model = responseFromJsonCloseTicket(responseModel.responseJson);
      if(model.status.toString().toLowerCase() == "success"){
        Get.offAllNamed(RouteHelper.ticketScreen);
        CustomSnackBar.success(successList: [model.message.success.first.last].isNotEmpty ? [model.message.success.first.last] : [MyStrings.success], duration: 3);
      }
      else{
        CustomSnackBar.error(errorList: [responseModel.message].isNotEmpty ? [responseModel.message] : [MyStrings.somethingWentWrong]);
      }
    }
    else{
      CustomSnackBar.error(errorList: [responseModel.message],);
    }
  }

  void clearData() {
    isLoading = false;
    messageController.text = "";
    selectedFiles.clear();
    selectedFilesData?.clear();
    onReplyComplete();
  }

}

class ReplyData {
  final String ticketId;
  final String messageStr;
  final List<File>? selectedFilesData;

  ReplyData({
    required this.ticketId,
    required this.messageStr,
    this.selectedFilesData,
  });
}