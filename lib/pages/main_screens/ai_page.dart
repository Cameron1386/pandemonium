import 'dart:io';
import 'dart:typed_data';
import 'package:dash_chat_2/dash_chat_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'package:image_picker/image_picker.dart';

class AiPage extends StatefulWidget {
  const AiPage({super.key});

  @override
  State<AiPage> createState() => _AiPageState();
}

class _AiPageState extends State<AiPage> {
  final Gemini gemini = Gemini.instance;
  List<ChatMessage> messages = [];

  final ChatUser currentUser = ChatUser(
    firstName: 'Baby Panda',
    id: '0',
  );

  final ChatUser geminiUser = ChatUser(
    firstName: 'Elder Panda',
    id: '1',
    profileImage:
        'https://img.freepik.com/free-vector/cute-fluffy-panda-face_1284-37906.jpg',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Elder Panda',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFF283048), // Darker blue-gray
                Color(0xFF859398), // Light gray-blue
              ],
            ),
          ),
        ),
        leading: const SizedBox(width: 16), // Add a space box to the left
      ),
      backgroundColor: const Color(0xFF0D1B2A), // Dark background color
      body: _buildChatUI(),
    );
  }

  Widget _buildChatUI() {
    return Container(
      color: const Color(0xFF0D1B2A), // Deep dark background
      padding: const EdgeInsets.all(8.0),
      child: DashChat(
        inputOptions: InputOptions(
  inputDecoration: InputDecoration(
    filled: true,
    fillColor: const Color(0xFF1B263B), // Input box background color
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(30.0),
      borderSide: BorderSide.none,
    ),
    contentPadding: const EdgeInsets.symmetric(
      vertical: 15.0,
      horizontal: 20.0,
    ),
    hintText: 'Type your message...',
    hintStyle: const TextStyle(color: Colors.white60), // Hint text color
  ),
  inputTextStyle: const TextStyle(color: Colors.white), // Set input text color here
  trailing: [
    IconButton(
      onPressed: _sendMediaMessage,
      icon: const Icon(Icons.image, color: Colors.tealAccent),
    ),
  ],
),


        messageOptions: MessageOptions(
          currentUserContainerColor: const Color(0xFF283048), // User message background
          currentUserTextColor: Colors.tealAccent, // User message text color
          containerColor: const Color(0xFF1B263B), // Bot message background
          textColor: Colors.white, // Bot message text color
        ),
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages,
        messageListOptions: const MessageListOptions(), // Default message list options
      ),
    );
  }

  void _sendMessage(ChatMessage chatMessage) {
    setState(() {
      messages = [chatMessage, ...messages];
    });
    try {
      final String question = chatMessage.text;
      List<Uint8List>? images;

      if (chatMessage.medias?.isNotEmpty ?? false) {
        images = [
          File(chatMessage.medias!.first.url).readAsBytesSync(),
        ];
      }

      gemini.streamGenerateContent(
        question,
        images: images,
      ).listen((event) {
        String response = event.content?.parts?.fold(
              "",
              (previous, current) => "$previous ${current.text}",
            ) ??
            "";

        if (messages.isNotEmpty && messages.first.user == geminiUser) {
          final lastMessage = messages.removeAt(0);
          lastMessage.text += response;
          setState(() {
            messages = [lastMessage, ...messages];
          });
        } else {
          final message = ChatMessage(
            user: geminiUser,
            createdAt: DateTime.now(),
            text: response,
          );
          setState(() {
            messages = [message, ...messages];
          });
        }
      });
    } catch (e) {
      print(e);
    }
  }

  void _sendMediaMessage() async {
    final picker = ImagePicker();
    final file = await picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      final chatMessage = ChatMessage(
        user: currentUser,
        createdAt: DateTime.now(),
        text: "Describe this picture?",
        medias: [
          ChatMedia(
            url: file.path,
            fileName: "",
            type: MediaType.image,
          ),
        ],
      );
      _sendMessage(chatMessage);
    }
  }
}
