import 'package:eastern_trust/data/repo/tickets/ticket_list_repo.dart';
import 'package:eastern_trust/views/screens/tickets/create_ticket/create_ticket.dart';
import 'package:eastern_trust/views/screens/tickets/reply_ticket.dart';
import 'package:eastern_trust/views/screens/tickets/ticket_screen.dart';
import 'package:get/get.dart';
import 'package:eastern_trust/views/screens/about/faq/faq_screen.dart';
import 'package:eastern_trust/views/screens/about/privacy/privacy_screen.dart';
import 'package:eastern_trust/views/screens/account/change-password/change_password_screen.dart';
import 'package:eastern_trust/views/screens/account/edit-profile/edit_profile_screen.dart';
import 'package:eastern_trust/views/screens/account/profile/my_profile_screen.dart';
import 'package:eastern_trust/views/screens/airtime/airtime_screen.dart';
import 'package:eastern_trust/views/screens/auth/email_verification_page/email_verification_screen.dart';
import 'package:eastern_trust/views/screens/auth/forget-password/forget_password_screen.dart';
import 'package:eastern_trust/views/screens/auth/kyc/kyc.dart';
import 'package:eastern_trust/views/screens/auth/login/login_screen.dart';
import 'package:eastern_trust/views/screens/auth/profile_complete/profile_complete_screen.dart';
import 'package:eastern_trust/views/screens/auth/registration/registration_screen.dart';
import 'package:eastern_trust/views/screens/auth/reset_password/reset_password_screen.dart';
import 'package:eastern_trust/views/screens/auth/sms_verification_page/sms_verification_screen.dart';
import 'package:eastern_trust/views/screens/auth/two_factor_screen/two_factor_verification_screen.dart';
import 'package:eastern_trust/views/screens/auth/verify_forget_password/verify_forget_password_screen.dart';
import 'package:eastern_trust/views/screens/deposits/deposit_webview/deposit_payment_webview.dart';
import 'package:eastern_trust/views/screens/deposits/deposits_screen.dart';
import 'package:eastern_trust/views/screens/deposits/new_deposit/new_deposit_screen.dart';
import 'package:eastern_trust/views/screens/dps/confirm_dps/confirm_dps_screen.dart';
import 'package:eastern_trust/views/screens/dps/dps_screen/dps_screen.dart';
import 'package:eastern_trust/views/screens/dps/my-dps-list-screen/sub-screen/dps_installment_log_screen.dart';
import 'package:eastern_trust/views/screens/fdr/confirm_fdr/confirm_fdr_screen.dart';
import 'package:eastern_trust/views/screens/fdr/fdr_installment_log_screen/fdr_installment_log_screen.dart';
import 'package:eastern_trust/views/screens/fdr/fdr_screen/fdr_screen.dart';
import 'package:eastern_trust/views/screens/home/home_screen.dart';
import 'package:eastern_trust/views/screens/loan/loan_confirm_screen/loan_confirm_screen.dart';
import 'package:eastern_trust/views/screens/loan/loan_installment_log/loan_installment_log_screen.dart';
import 'package:eastern_trust/views/screens/loan/loan_screen/loan_screen.dart';
import 'package:eastern_trust/views/screens/launcher/launcher_screen.dart';
import 'package:eastern_trust/views/screens/menu/menu_screen.dart';
import 'package:eastern_trust/views/screens/notification/notification_screen.dart';
import 'package:eastern_trust/views/screens/operator/select_operator_screen.dart';
import 'package:eastern_trust/views/screens/otp_screen/otp_screen.dart';
import 'package:eastern_trust/views/screens/referral/referral_screen.dart';
import 'package:eastern_trust/views/screens/splash/splash_screen.dart';
import 'package:eastern_trust/views/screens/transaction/transaction_screen.dart';
import 'package:eastern_trust/views/screens/transfer/my_bank_transfer_screen/my_bank_transfer_screen.dart';
import 'package:eastern_trust/views/screens/transfer/transfer_screen/transfer_screen.dart';
import 'package:eastern_trust/views/screens/withdraw/add_withdraw_screen/add_withdraw_method_screen.dart';
import 'package:eastern_trust/views/screens/withdraw/confirm_withdraw_screen/withdraw_confirm_screen.dart';
import 'package:eastern_trust/views/screens/withdraw/withdraw_history/withdraw_screen.dart';

import '../../views/screens/auth/two_factor_screen/two_factor_screen.dart';
import '../../views/screens/transfer/other_bank_transfer_screen/transfer_other_bank_screen.dart';
import '../../views/screens/transfer/transfer_history_screen/transfer_history_screen.dart';
import '../../views/screens/transfer/wire_transfer_screen/wire_transfer_screen.dart';

class RouteHelper{

  static const String splashScreen = "/splash";
  static const String launcherScreen = "/launcher";
  static const String forgotPasswordScreen = "/forgot_password_screen";
  static const String onBoardScreen = "/onboard";
  static const String loginScreen = "/login";
  static const String registrationScreen = "/registration";
  static const String homeScreen = "/home_screen";

  static const String emailVerificationScreen ='/verify_email' ;
  static const String smsVerificationScreen = '/verify_sms';
  static const String forgetPasswordScreen = '/forget_password' ;
  static const String verifyPassCodeScreen = '/verify_pass_code' ;
  static const String resetPasswordScreen = '/reset_pass' ;
  static const String twoFactorVerificationScreen = '/two_fa_screen' ;
  static const String privacyScreen='/privacy_screen';
  static const String twoFactorScreen = '/two_factor_screen' ;

  //account
  static const String profileScreen='/profile';
  static const String editProfileScreen = "/edit_profile";
  static const String profileCompleteScreen='/profile_complete_screen';
  static const String changePasswordScreen='/change_password';

  //notification
  static const String notificationScreen='/notification_screen';

  static const String kycScreen='/kyc_screen';
  static const String menuScreen='/menu_screen';

  //refer screen
  static const String referralScreen = "/referral";


  //deposit
  static const String depositsScreen = "/deposits";
  static const String depositsDetailsScreen = "/deposits_details";
  static const String newDepositScreenScreen = "/deposits_money";



  //Ticket
  static const String ticketScreen = "/ticket";
  static const String createTicketScreen = "/craete_ticket";
  static const String replyTicketScreen = "/reply_ticket";
  static const String depositWebViewScreen = "/deposit_webView";



  //transfer
  static const String transferScreen = "/transfer";
  static const String wireTransferScreen = "/wire_transfer";
  static const String transferHistoryScreen = "/transfer-history";
  static const String myBankTransferScreen = "/viser_bank_transfer_icon";
  static const String otherBankTransferScreen = "/other_bank_transfer_screen";


  //withdraw
  static const String withdrawScreen = "/withdraw";
  static const String addWithdrawMethodScreen = "/withdraw_method";

  static const String withdrawOtpScreen = "/withdraw_otp";
  static const String withdrawConfirmScreenScreen = "/withdraw_preview_screen";

  static const String otpScreen = "/otp_screen";

  static const String fdrScreen = "/fdr_plan_screen";
  static const String fdrConfirmScreen = "/fdr_confirm_screen";
  static const String timerOtpScreen = "/timer_otp";
  static const String fdrDetailsScreen = "/fdr_details_screen";
  static const String fdrInstallmentLogScreen = "/fdr_installment_log_screen";

  //dps screen
  static const String dpsScreen = "/dps_screen";
  static const String dpsConfirmScreen = "/dps_confirm_screen";
  static const String dpsInstallmentLogScreen = "/dps_installment_log_screen";

  //load screen
  static const String loanScreen = "/loan_plan_screen";
  static const String loanConfirmScreen = "/loan_confirm_screen";
  static const String applyLoanScreen = "/apply_loan";
  static const String loanInstallmentLogScreen = "/loan_installment_log_screen";

  //transaction screen
  static const String transactionScreen = "/transaction";

  //airtime screen
  static const String airtimeScreen        = "/airtime_screen";
  static const String selectOperatorScreen = "/select_operator_screen";

  //privacy policy screen
  static const String termsServicesScreen = "/terms_services";
  static const String faqScreen = "/faq-screen";


  static List<GetPage> routes = [

    GetPage(name: launcherScreen,                 page: () => const LauncherScreen()),
    GetPage(name: splashScreen,                   page: () => const SplashScreen()),
    GetPage(name: forgotPasswordScreen,           page: () => const ForgetPasswordScreen()),
    GetPage(name: loginScreen,                    page: () => const LoginScreen()),
    GetPage(name: registrationScreen,             page: () => const RegistrationScreen()),
    GetPage(name: homeScreen,                     page: () => const HomeScreen()),
    GetPage(name: referralScreen,                 page: () => const ReferralScreen()),
    GetPage(name: emailVerificationScreen,        page: () => EmailVerificationScreen(needSmsVerification: Get.arguments[0],isProfileCompleteEnabled: Get.arguments[1],needTwoFactor: Get.arguments[2],)),
    GetPage(name: smsVerificationScreen,          page: () => const SmsVerificationScreen()),
    GetPage(name: forgetPasswordScreen,           page: () => const ForgetPasswordScreen()),
    GetPage(name: verifyPassCodeScreen,           page: () => const VerifyForgetPassScreen()),
    GetPage(name: resetPasswordScreen,            page: () => const ResetPasswordScreen()),
    GetPage(name: profileCompleteScreen,          page: () => const ProfileCompleteScreen()),
    GetPage(name: depositsScreen,                 page: () => const DepositsScreen()),
    GetPage(name: ticketScreen,                   page: () => const TicketScreen()),
    GetPage(name: newDepositScreenScreen,         page: () => const NewDepositScreen()),
    GetPage(name: createTicketScreen,             page: () => const CreateTicketScreen()),

    GetPage(name: replyTicketScreen,               page: () => ReplyTicketScreen(selectedReply: Get.arguments,)),
    GetPage(name: newDepositScreenScreen,         page: () => const NewDepositScreen()),
    GetPage(name: withdrawScreen,                 page: () => const WithdrawScreen()),
    GetPage(name: addWithdrawMethodScreen,        page: () => const AddWithdrawMethod()),
    GetPage(name: withdrawConfirmScreenScreen,    page: () => const WithdrawConfirmScreen()),

    GetPage(name: transferScreen,                 page: () => const TransferScreen()),
    GetPage(name: otherBankTransferScreen,        page: () => const TransferOtherBankScreen()),
    GetPage(name: myBankTransferScreen,           page: () => const MyBankTransferScreen()),
    GetPage(name: wireTransferScreen,             page: () => const WireTransferScreen()),
    GetPage(name: transferHistoryScreen,          page: () => const TransferHistoryScreen()),


    GetPage(name: fdrScreen,                      page: () => const FDRScreen()),
    GetPage(name: fdrInstallmentLogScreen,        page: () => const FDRInstallmentLogScreen()),
    GetPage(name: fdrConfirmScreen,               page: () => const ConfirmFDRScreen()),
    GetPage(name: dpsScreen,                      page: () => const DPSScreen()),
    GetPage(name: dpsInstallmentLogScreen,        page: () => const DPSInstallmentLogScreen()),
    GetPage(name: dpsConfirmScreen,               page: () => const ConfirmDPSScreen()),
    GetPage(name: selectOperatorScreen,               page: () => SelectOperatorScreen(countryId: Get.arguments,)),

    GetPage(name: loanScreen,                     page: () => const LoanScreen()),
    GetPage(name: airtimeScreen,                     page: () => const AirtimeScreen()),
    GetPage(name: loanConfirmScreen,              page: () => const LoanConfirmScreen()),
    GetPage(name: loanInstallmentLogScreen,       page: () => const LoanInstallmentLogScreen()),

    GetPage(name: transactionScreen,              page: () => const TransactionScreen()),
    GetPage(name: editProfileScreen,              page: () => const EditProfileScreen()),
    GetPage(name: changePasswordScreen,           page: () => const ChangePasswordScreen()),
    GetPage(name: menuScreen,                     page: () => const MenuScreen()),
    GetPage(name: profileScreen,                  page: () => const MyProfileScreen()),
    GetPage(name: termsServicesScreen,            page: () => const PrivacyScreen()),
    GetPage(name: notificationScreen,             page: () => const NotificationScreen()),
    GetPage(name: depositWebViewScreen,           page: () => WebViewExample(redirectUrl: Get.arguments)),
    GetPage(name: faqScreen,                      page: () => const FaqScreen()),
    GetPage(name: privacyScreen,                  page: () => const PrivacyScreen()),
    GetPage(name: kycScreen,                      page: () => const KycScreen()),
    GetPage(name: otpScreen,                      page: () => const OtpScreen()),
    GetPage(name: twoFactorVerificationScreen,    page: () => TwoFactorVerificationScreen(isProfileCompleteEnable: Get.arguments)),
    GetPage(name: twoFactorScreen,    page: () => Setup2FAScreen()),


  ];
}