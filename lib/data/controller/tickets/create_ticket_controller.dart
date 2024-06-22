import 'dart:convert';

import 'package:eastern_trust/data/repo/tickets/create_ticket_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/core/helper/shared_preference_helper.dart';
import 'package:eastern_trust/core/utils/my_strings.dart';
import 'package:eastern_trust/core/route/route.dart';
import 'package:eastern_trust/data/model/auth/login_response_model.dart';
import 'package:eastern_trust/data/model/global/response_model/response_model.dart';
import 'package:eastern_trust/data/repo/auth/login_repo.dart';
import 'package:eastern_trust/views/components/snackbar/show_custom_snackbar.dart';
import 'dart:io';


class CreateTicketController extends GetxController{

  CreateTicketRepo createTicketRepo;
  CreateTicketController({required this.createTicketRepo});

  bool isLoading = true;
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  String? priority;
  List<File>? selectedFilesData = [];
  bool submitLoading = false;
  File? imageFile;

  void clearData() {
    isLoading = false;
  }

  Future<void> submitTicket() async {

    submitLoading = true;
    update();

    CreateTicketData ticketData=CreateTicketData(
        subjectStr: subjectController.text,
        priorityStr: priority.toString(),
        messageStr: messageController.text,
        selectedFilesData: selectedFilesData
    );

    print('ticket data ==> $ticketData');

    bool b= await createTicketRepo.submitCreateTicket(ticketData);

    if(b){
      // Get.offAllNamed(RouteHelper.homeScreen);
      // return;
    }

    submitLoading = false;
    update();

  }
}

class CreateTicketData {
  final String subjectStr;
  final String priorityStr;
  final String messageStr;
  final List<File>? selectedFilesData;

  CreateTicketData({
    required this.subjectStr,
    required this.priorityStr,
    required this.messageStr,
    this.selectedFilesData,
  });
}