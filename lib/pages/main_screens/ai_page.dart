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
    profileImage: const AssetImage('lib/images/panda.png').assetName,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Elder Panda'),
        backgroundColor: Colors.deepPurple,
        
      ),
      body: _buildChatUI(),
    );
  }

  Widget _buildChatUI() {
    return Container(
      color: Colors.grey[200],
      padding: const EdgeInsets.all(8.0),
      child: DashChat(
        inputOptions: InputOptions(
          inputDecoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 10.0,
              horizontal: 20.0,
            ),
            hintText: 'Type your message...',
          ),
          trailing: [
            IconButton(
              onPressed: _sendMediaMessage,
              icon: const Icon(Icons.image),
              color: Colors.deepPurple,
            ),
          ],
        ),
        messageOptions: MessageOptions(
          currentUserContainerColor: Colors.deepPurple[50],
          currentUserTextColor: Colors.deepPurple,

        ),
        currentUser: currentUser,
        onSend: _sendMessage,
        messages: messages,
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
              (previous, current) => "$previous ${current.text}"
            ) ?? "";

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
