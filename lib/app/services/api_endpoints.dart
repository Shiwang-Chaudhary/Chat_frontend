class ApiEndpoints{
  static String login = "auth/login";
  static String signUp = "auth/register";
  static String createOrGetChatRoom = "chat/createOrGet";
  static String sendMessage = "chat/sendMessage";
  static String getMessage = "chat/getMessage"; //isme /chatid bhi dalni h end m
  static String getAllChats = "chat/getAllChats"; // "?isGroup=false" for personal chats and "?isGroup=true" for groupChats
  static String searchUsers = "chat/searchUsers";
  static String createGroupChat = "chat/createGroupChats";
  static String getGroupChats = "chat/getAllChats?isGroup=true";
}