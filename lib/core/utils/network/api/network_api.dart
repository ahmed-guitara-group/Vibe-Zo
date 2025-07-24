class Api {
  //base Url
  static const String mainAppUrl = "http://10.5.50.6:3333/";
  //end points
  static const String baseUrl = "${mainAppUrl}api/";
  static const String doServerRegisterApiCall = "${baseUrl}auth/register";
  static const String doServerSendCodeApiCall =
      "${baseUrl}auth/sendVerificationCode";
  static const String doServerVerifyCodeApiCall = "${baseUrl}auth/verifyCode";
}
