import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';
import '../../../core/utils/colors.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _messageController = TextEditingController();
  final TextEditingController _searchController = TextEditingController();
  bool _drawerExpanded = true;

  String? _selectedChatId;
  Map<String, dynamic>? _selectedChat;

  @override
  void initState() {
    super.initState();
    // Select first chat by default
    final chats = SelectionService.getChats();
    if (chats.isNotEmpty) {
      _selectedChatId = chats.first['id'];
      _selectedChat = chats.first;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop && _drawerExpanded)
              SizedBox(width: 280, child: const AppDrawer()),

            Expanded(
              child: Column(
                children: [
                  HeaderPage(
                    title: 'Messages',
                    scaffoldKey: _scaffoldKey,
                    isDesktop: isDesktop,
                    drawerExpanded: _drawerExpanded,
                    onToggleDrawer: () {
                      setState(() {
                        _drawerExpanded = !_drawerExpanded;
                      });
                    },
                    showSearchField: false,
                    showNotifications: true,
                  ),

                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? context.xl : context.md,
                      ),
                      child: Column(
                        children: [
                          SizedBox(height: context.spaceBtwSections),

                          // Main content
                          Expanded(
                            child: isDesktop
                                ? _buildDesktopChat(context)
                                : _buildMobileChat(context),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopChat(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Chat list (30%)
        Expanded(
          flex: 3,
          child: Card(
            elevation: 4,
            child: Column(
              children: [
                // Header
                Container(
                  padding: EdgeInsets.all(context.md),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search a conversation...',
                      prefixIcon: Icon(Icons.search, size: 20),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                  ),
                ),

                // Chat list
                Expanded(
                  child: ListView.builder(
                    padding: EdgeInsets.all(context.sm),
                    itemCount: SelectionService.getChats().length,
                    itemBuilder: (context, index) {
                      final chat = SelectionService.getChats()[index];
                      final isSelected = chat['id'] == _selectedChatId;

                      return ListTile(
                        onTap: () {
                          setState(() {
                            _selectedChatId = chat['id'];
                            _selectedChat = chat;
                          });
                        },
                        leading: CircleAvatar(
                          backgroundColor: isSelected
                              ? Colors.blue
                              : Colors.grey.shade200,
                          child: chat['type'] == 'project'
                              ? Icon(
                                  Icons.group,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                )
                              : Icon(
                                  Icons.person,
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.grey,
                                ),
                        ),
                        title: Text(
                          chat['title'],
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
                          ),
                        ),
                        subtitle: Text(chat['lastMessage'] ?? ''),
                        trailing: chat['unreadCount'] > 0
                            ? CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.red,
                                child: Text(
                                  chat['unreadCount'].toString(),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              )
                            : null,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: context.md),

        // Chat zone (70%)
        Expanded(
          flex: 7,
          child: _selectedChat != null
              ? _buildChatZone(context, _selectedChat!)
              : _buildNoChatSelected(context),
        ),
      ],
    );
  }

  Widget _buildMobileChat(BuildContext context) {
    if (_selectedChat != null) {
      return _buildChatZone(context, _selectedChat!);
    }

    // Chat list view (mobile)
    return Card(
      elevation: 4,
      child: Column(
        children: [
          // Header
          Container(
            padding: EdgeInsets.all(context.md),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search a conversation...',
                prefixIcon: Icon(Icons.search, size: 20),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ),

          // Chat list
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(context.sm),
              itemCount: SelectionService.getChats().length,
              itemBuilder: (context, index) {
                final chat = SelectionService.getChats()[index];

                return ListTile(
                  onTap: () {
                    setState(() {
                      _selectedChatId = chat['id'];
                      _selectedChat = chat;
                    });
                  },
                  leading: CircleAvatar(
                    backgroundColor: Colors.grey.shade200,
                    child: chat['type'] == 'project'
                        ? Icon(Icons.group, color: Colors.grey)
                        : Icon(Icons.person, color: Colors.grey),
                  ),
                  title: Text(chat['title']),
                  subtitle: Text(chat['lastMessage'] ?? ''),
                  trailing: chat['unreadCount'] > 0
                      ? CircleAvatar(
                          radius: 12,
                          backgroundColor: Colors.red,
                          child: Text(
                            chat['unreadCount'].toString(),
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        )
                      : null,
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNoChatSelected(BuildContext context) {
    return Card(
      elevation: 4,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_bubble_outline,
              size: 80,
              color: Colors.grey.shade400,
            ),
            SizedBox(height: context.md),
            Text(
              'Select a conversation',
              style: TextStyle(
                fontSize: context.fontSizeMd,
                color: Colors.grey.shade600,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildChatZone(BuildContext context, Map<String, dynamic> chat) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    final messages = SelectionService.getChatMessages(chat['id']);

    return Card(
      elevation: 4,
      child: Column(
        children: [
          // Chat header
          Container(
            padding: EdgeInsets.all(context.md),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                if (!isDesktop)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _selectedChat = null;
                        _selectedChatId = null;
                      });
                    },
                    icon: Icon(Icons.arrow_back),
                  ),

                CircleAvatar(
                  child: chat['type'] == 'project'
                      ? Icon(Icons.group, color: Colors.blue)
                      : Icon(Icons.person, color: Colors.blue),
                ),
                SizedBox(width: context.sm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chat['title'],
                      style: TextStyle(
                        fontSize: context.fontSizeMd,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (chat['type'] == 'project')
                      Text(
                        '${chat['memberCount']} members',
                        style: TextStyle(fontSize: context.fontSizeSm),
                      ),
                  ],
                ),
                Spacer(),
                IconButton(onPressed: () {}, icon: Icon(Icons.info_outline)),
              ],
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(context.md),
              reverse: true,
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                return _buildMessageBubble(message, context);
              },
            ),
          ),

          // Send zone
          Container(
            padding: EdgeInsets.all(context.md),
            decoration: BoxDecoration(
              border: Border(top: BorderSide(color: Colors.grey.shade300)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _messageController,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 12,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.sm),
                IconButton(
                  onPressed: _sendMessage,
                  icon: Icon(Icons.send, color: AppColors.primary),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(
    Map<String, dynamic> message,
    BuildContext context,
  ) {
    final isMe = message['isMe'] ?? false; // project_chat_scr
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Container(
      margin: EdgeInsets.only(bottom: context.sm),
      child: Row(
        mainAxisAlignment: isMe
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe)
            CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),

          SizedBox(width: 8),

          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth:
                  MediaQuery.of(context).size.width * (isDesktop ? 0.4 : 0.6),
            ),
            child: Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: isMe ? AppColors.chatBubbleSent : AppColors.darkGrey,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (!isMe)
                    Text(
                      message['sender'] ?? '',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),

                  SizedBox(height: 4),

                  Text(message['message'] ?? ''),

                  SizedBox(height: 4),

                  Text(message['time'] ?? '', style: TextStyle(fontSize: 10)),
                ],
              ),
            ),
          ),

          SizedBox(width: 8),

          if (isMe)
            CircleAvatar(radius: 16, child: Icon(Icons.person, size: 16)),
        ],
      ),
    );
  }

  void _sendMessage() {
    if (_messageController.text.trim().isNotEmpty && _selectedChat != null) {
      // Send message
      print(
        'Message sent to ${_selectedChat!['title']}: ${_messageController.text}',
      );
      _messageController.clear();
    }
  }
}
