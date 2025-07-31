class Api {
  //base Url
  static const String mainAppUrl = "http://192.168.10.32:3333/";
  //end points
  //Socket Url
  static const String socketUrl = "http://192.168.10.32:3334/";
  static const String baseUrl = "${mainAppUrl}api/";
  static const String baseImageUrl = "${mainAppUrl}uploads/";
  static const String doServerRegisterApiCall = "${baseUrl}auth/register";
  static const String doServerSendCodeApiCall =
      "${baseUrl}auth/sendVerificationCode";
  static const String doServerVerifyCodeApiCall = "${baseUrl}auth/verifyCode";
  static const String doServerCreatePasswordApiCall =
      "${baseUrl}auth/createNewPassword";
  static const String doServerLoginApiCall = "${baseUrl}auth/login";
  static const String doServerGetCountriesApiCall = "${mainAppUrl}getCountries";
  static const String doServerGetLanguagesApiCall = "${mainAppUrl}getLanguages";
  static const String doServerAddDataApiCall = "${baseUrl}auth/adddata";
  static const String doServerCheckTokenApiCall = "${baseUrl}auth/checkToken";
  //CHAT
  static const String doServerGetAllChatsApiCall = "${baseUrl}chats";
  static const String doServerCreateOrGetChatsApiCall =
      "${baseUrl}chats/createorgetchat/";
  static const String doServerGetChatMessagesApiCall = "${baseUrl}chats/";
  static const String doServerSendMessageApiCall =
      "${baseUrl}chats/sendMessage";
}
