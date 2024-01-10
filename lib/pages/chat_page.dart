import 'package:algi/components/consts.dart';
import 'package:chat_gpt_sdk/chat_gpt_sdk.dart';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final _openAI = OpenAI.instance.build(
    token: OPENAI_API_KEY,
    baseOption: HttpSetup(
      receiveTimeout: const Duration(
        seconds: 4,
      ),
    ),
    enableLog: true,
  );

  final ChatUser _currentUser =
      ChatUser(id: "1", firstName: "algi", lastName: "Fz");

  final ChatUser _gptChatUser =
      ChatUser(id: "2", firstName: "chat", lastName: "GPT");

  List<ChatMessage> _messages = <ChatMessage>[];
  List<ChatUser> _typingUsers = <ChatUser>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(
          255,
          0,
          0,
          0,
        ),
        title: const Text(
          'ChatGPT',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: DashChat(
        currentUser: _currentUser,
        messageOptions: const MessageOptions(
          currentUserContainerColor: Colors.black,
          containerColor: Color.fromARGB(
            0,
            166,
            126,
            1,
          ),
          textColor: Colors.black,
        ),
        onSend: (ChatMessage m) {
          getChatResponse(m);
        },
        messages: _messages,
      ),
    );
  }

  Future<void> getChatResponse(ChatMessage m) async {
    setState(() {
      _messages.insert(0, m);
      _typingUsers.add(_gptChatUser);
    });

      List<Messages> _messagesHistory = _messages.reversed.map((m) {
        if (m.user == _currentUser) {
          return Messages(role: Role.user, content: m.text);
        } else {
          return Messages(role: Role.assistant, content: m.text);
        }
      }).toList();

      final request = ChatCompleteText(
        model: GptTurbo0301ChatModel(),
        messages: _messagesHistory,
        maxToken: 200,
      );

      final response = await _openAI.onChatCompletion(request: request);

      for (var element in response!.choices) {
        if (element.message != null) {
          setState(() {
            _messages.insert(
              0,
              ChatMessage(
                  user: _gptChatUser,
                  createdAt: DateTime.now(),
                  text: element.message!.content),
            );
          });
        }
      }

      setState(() {
        _typingUsers.remove(_gptChatUser);
      });
    }
}