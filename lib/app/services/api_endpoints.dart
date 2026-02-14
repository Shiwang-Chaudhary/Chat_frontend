class ApiEndpoints {
  //POST
  static String login = "auth/login";
  static String createOrGetChatRoom = "chat/createOrGet";
  static String sendMessage = "chat/sendMessage";
  static String createGroupChat = "chat/createGroupChat";
  //GET
  static String signUp = "auth/register";
  static String getMessage = "chat/getMessage"; //isme /chatid bhi dalni h end m
  static String getAllChats =
      "chat/getAllChats"; // "?isGroup=false" for personal chats and "?isGroup=true" for groupChats
  static String searchUsers = "chat/searchUsers";
  static String getGroupChats = "chat/getAllChats?isGroup=true";
  static String searchGroups = "chat/searchGroups";
  static String getFriendsLocation = "location/friendLocation";
  //PATCH
  static String addMembers = "chat/addMembers";
  //DELETE
  static String removeMember = "chat/removeMember";
}
