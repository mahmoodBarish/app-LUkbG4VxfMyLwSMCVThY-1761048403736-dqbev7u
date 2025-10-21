import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:ui';

class MessangerChats extends StatelessWidget {
  const MessangerChats({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _CustomAppBar(),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
              child: _SearchBar(),
            ),
          ),
          const SliverToBoxAdapter(
            child: _StoriesSection(),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final chat = _chatData[index];
                return _ChatItem(chat: chat);
              },
              childCount: _chatData.length,
            ),
          ),
        ],
      ),
      bottomNavigationBar: const _CustomBottomNavBar(),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          padding: EdgeInsets.only(top: topPadding, left: 16, right: 16),
          color: Colors.white.withOpacity(0.8),
          child: Column(
            children: [
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const CircleAvatar(
                          radius: 20,
                          backgroundImage:
                              AssetImage('assets/images/287_84.png'),
                        ),
                        const SizedBox(width: 12),
                        Text(
                          'Chats',
                          style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        _AppBarButton(
                            icon: Icons.camera_alt_outlined,
                            onPressed: () {}),
                        const SizedBox(width: 12),
                        _AppBarButton(
                            icon: Icons.edit_outlined, onPressed: () {}),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(64);
}

class _AppBarButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _AppBarButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.04),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.black, size: 22),
        onPressed: onPressed,
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.lato(
            color: const Color(0xFF8E8E93),
            fontSize: 17,
            letterSpacing: -0.41,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8E8E93)),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
        ),
      ),
    );
  }
}

class _StoriesSection extends StatelessWidget {
  const _StoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.only(left: 16),
        itemCount: _storyData.length,
        itemBuilder: (context, index) {
          final story = _storyData[index];
          return Padding(
            padding: const EdgeInsets.only(right: 18),
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    if (story.isAddStory)
                      Container(
                        width: 52,
                        height: 52,
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.04),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.add, color: Colors.black),
                      )
                    else
                      CircleAvatar(
                        radius: 26,
                        backgroundImage: AssetImage(story.imagePath),
                      ),
                    if (story.isOnline)
                      Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                          color: const Color(0xFF5AD439),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 3),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  story.name,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.5),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ChatItem extends StatelessWidget {
  final Chat chat;
  const _ChatItem({required this.chat});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => context.go('/messanger_swipe_actions'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage(chat.imagePath),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chat.name,
                    style: GoogleFonts.lato(
                      fontSize: 17,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                      letterSpacing: -0.4,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    chat.message,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      color: Colors.black.withOpacity(0.5),
                      letterSpacing: -0.15,
                    ),
                  ),
                ],
              ),
            ),
            if (chat.isRead)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(Icons.done_all, color: Colors.grey, size: 16),
              ),
          ],
        ),
      ),
    );
  }
}

class _CustomBottomNavBar extends StatelessWidget {
  const _CustomBottomNavBar();

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.toString();

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20.0, sigmaY: 20.0),
        child: Container(
          height: 86 + MediaQuery.of(context).padding.bottom,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.8),
            border: const Border(
              top: BorderSide(color: Color(0x4D3C3C43), width: 0.5),
            ),
          ),
          child: Padding(
            padding:
                EdgeInsets.only(bottom: MediaQuery.of(context).padding.bottom),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildNavItem(
                  context: context,
                  icon: Icons.chat_bubble,
                  path: '/messanger_chats',
                  isActive: currentPath == '/messanger_chats',
                ),
                _buildNavItemWithBadge(
                  context: context,
                  icon: Icons.people_alt,
                  path: '/people',
                  isActive: currentPath == '/people',
                  count: 2,
                ),
                _buildNavItem(
                  context: context,
                  icon: Icons.explore_outlined,
                  path: '/explore',
                  isActive: currentPath == '/explore',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required BuildContext context,
    required IconData icon,
    required String path,
    required bool isActive,
  }) {
    return IconButton(
      onPressed: () => context.go(path),
      icon: Icon(icon, color: isActive ? Colors.black : Colors.grey[400]),
      iconSize: 28,
      padding: const EdgeInsets.only(top: 12),
    );
  }

  Widget _buildNavItemWithBadge({
    required BuildContext context,
    required IconData icon,
    required String path,
    required bool isActive,
    required int count,
  }) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          onPressed: () => context.go(path),
          icon: Icon(icon, color: isActive ? Colors.black : Colors.grey[400]),
          iconSize: 28,
          padding: const EdgeInsets.only(top: 12),
        ),
        Positioned(
          top: 10,
          right: 18,
          child: Container(
            padding: const EdgeInsets.all(2),
            decoration: BoxDecoration(
              color: const Color(0xFF5AD439).withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
            child: Center(
              child: Text(
                '$count',
                style: GoogleFonts.lato(
                  color: const Color(0xFF5AD439),
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class Story {
  final String name;
  final String imagePath;
  final bool isOnline;
  final bool isAddStory;

  Story({
    required this.name,
    this.imagePath = '',
    this.isOnline = false,
    this.isAddStory = false,
  });
}

final List<Story> _storyData = [
  Story(name: 'Your story', isAddStory: true),
  Story(name: 'Joshua', imagePath: 'assets/images/287_62.png', isOnline: true),
  Story(name: 'Martin', imagePath: 'assets/images/287_67.png', isOnline: true),
  Story(name: 'Karen', imagePath: 'assets/images/287_72.png', isOnline: true),
  Story(name: 'Martha', imagePath: 'assets/images/287_77.png', isOnline: true),
];

class Chat {
  final String name;
  final String message;
  final String imagePath;
  final bool isRead;

  Chat({
    required this.name,
    required this.message,
    required this.imagePath,
    this.isRead = false,
  });
}

final List<Chat> _chatData = [
  Chat(
    name: 'Martin Randolph',
    message: 'You: What’s man! · 9:40 AM',
    imagePath: 'assets/images/287_10.png',
    isRead: true,
  ),
  Chat(
    name: 'Andrew Parker',
    message: 'You: Ok, thanks! · 9:25 AM',
    imagePath: 'assets/images/287_19.png',
    isRead: true,
  ),
  Chat(
    name: 'Karen Castillo',
    message: 'You: Ok, See you in To… · Fri',
    imagePath: 'assets/images/287_29.png',
    isRead: true,
  ),
  Chat(
    name: 'Maisy Humphrey',
    message: 'Have a good day, Maisy! · Fri',
    imagePath: 'assets/images/287_44.png',
    isRead: true,
  ),
  Chat(
    name: 'Joshua Lawrence',
    message: 'The business plan loo… · Thu',
    imagePath: 'assets/images/287_39.png',
  ),
  Chat(
    name: 'Pixsellz',
    message: 'Make design process easier…',
    imagePath: 'assets/images/287_108.png',
  ),
  Chat(
    name: 'Maximillian Jacobson',
    message: 'Messenger UI · Thu',
    imagePath: 'assets/images/287_5.png',
  ),
];