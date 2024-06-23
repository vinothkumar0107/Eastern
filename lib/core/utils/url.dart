
class UrlContainer{

  // static const String domainUrl = 'https://script.viserlab.com/viserbank/demo/';
  static const String domainUrl = 'https://easterntrusts.com/';
 // static const String domainUrl = 'https://url8.viserlab.com/viserbankv2.5/';
  static const String baseUrl = '${domainUrl}api/';
  static const String assetViewBaseUrl = 'https://easterntrusts.com/assets/support/';

  static const String registrationEndPoint = 'register';
  static const String loginEndPoint = 'login';
  static const String userDashboardEndPoint = 'user/home';
  static const String userLogoutEndPoint = 'logout';
  static const String userDeleteEndPoint = 'delete';
  static const String forgetPasswordEndPoint = 'password/email';
  static const String passwordVerifyEndPoint = 'password/verify-code';
  static const String resetPasswordEndPoint = 'password/reset';
  static const String referralEndPoint = "referees";
  static const String verify2FAUrl = 'verify-g2fa';

  static const String verifyEmailEndPoint = 'verify-email';
  static const String verifySmsEndPoint = 'verify-mobile';
  static const String resendVerifyCodeEndPoint = 'resend-verify/';
  static const String authorizationCodeEndPoint = 'authorization';

  static const String dashBoardEndPoint = 'dashboard';
  static const String airtimeCountryEndPoint = 'airtime/countries';
  static const String operatorEndPoint = 'airtime/operators';
  static const String airtimeApplyEndPoint = 'airtime/apply';
  static const String depositHistoryUrl = 'deposit/history';
  static const String depositMethodUrl = 'deposit/methods';
  static const String depositInsertUrl = 'deposit/insert';
  static const String transactionEndpoint = 'transactions';

  static const String otherBankBeneficiaryUrl = 'beneficiary/other';
  static const String myBankBeneficiaryUrl = 'beneficiary/own';
  static const String otherBankTransferUrl = 'other/transfer/request/';
  static const String myBankTransferUrl = 'own/transfer/request/';
  static const String checkAccountUrl = 'beneficiary/account-number/check?';

  static const String transferHistoryUrl = 'transfer/history';
  static const String wireTransferFormUrl = 'wire-transfer';
  static const String wireTransferRequestUrl = 'wire-transfer/request';
  static const String wireTransferConfirmUrl = 'wire-transfer/confirm/';

  static const String addWithdrawRequestUrl = 'apply';
  static const String withdrawMethodUrl = 'withdraw-method';
  static const String withdrawRequestConfirm = 'withdraw-request/confirm';
  static const String withdrawHistoryUrl = 'withdraw/history';
  static const String withdrawStoreUrl = 'withdraw/store/';
  static const String withdrawConfirmScreenUrl = 'withdraw/preview/';

  static const String kycFormUrl = 'kyc-form';
  static const String kycSubmitUrl = 'kyc-submit';
  static const String notificationEndPoint = 'notification/history';
  static const String notificationReadEndPoint='notification/detail/';

  static const String generalSettingEndPoint='general-setting';
  static const String privacyPolicyEndPoint='policy-pages';
  static const String faqEndPoint='faq';

  static const String getProfileEndPoint='user-info';
  static const String updateProfileEndPoint='profile-setting';
  static const String profileCompleteEndPoint='user-data-submit';

  static const String changePasswordEndPoint ='change-password';
  static const String countryEndPoint ='get-countries';

  static const String deviceTokenEndPoint     = 'get/device/token';
  static const String languageUrl             = 'language/';
  static const String balanceTransfer         = 'balance-transfer';

  static const String fdrPlanUrl = 'fdr/plans';
  static const String fdrListUrl = 'fdr/list';
  static const String fdrApplyUrl = 'fdr/apply/';
  static const String fdrPreviewUrl = 'fdr/preview/';
  static const String fdrConfirmUrl = 'fdr/confirm/';
  static const String fdrCloseUrl = 'fdr/close/';
  static const String fdrInstalmentUrl = 'fdr/instalment/logs/';

  static const String dpsPlanUrl = 'dps/plans';
  static const String dpsListUrl = 'dps/list';
  static const String dpsApplyUrl = 'dps/apply/';
  static const String dpsPreviewUrl = 'dps/preview/';
  static const String dpsConfirmUrl = 'dps/confirm/';
  static const String dpsCloseUrl = 'dps/close/';
  static const String dpsInstalmentUrl = 'dps/instalment/logs/';
  static const String dpsWithdrawUrl = 'dps/withdraw/';

  static const String loanPlanUrl = 'loan/plans';
  static const String loanListUrl = 'loan/list';
  static const String loanApplyUrl = 'loan/apply/';
  static const String loanConfirmUrl = 'loan/confirm/';
  static const String loanInstalmentUrl = 'loan/instalment/logs/';

  //otp
  static const String submitOtpUrl = 'check/otp/';
  static const String resendOtpUrl = 'resend/otp/';

  //Tickets
  static const String createTicketUrl = 'ticket/create';
  static const String getTicketListUrl = 'ticket';
  static const String viewTicketUrl = 'ticket/view';
  static const String replyTicketUrl = 'ticket/reply';
  static const String closeTicketUrl = 'ticket/close';

}