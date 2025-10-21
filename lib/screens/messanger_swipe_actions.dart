import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'dart:ui';

class MessangerSwipeActions extends StatelessWidget {
  const MessangerSwipeActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const _CustomAppBar(),
      body: const _ChatList(),
      bottomNavigationBar: const _BottomNavBar(),
    );
  }
}

class _CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _CustomAppBar();

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          color: Colors.white.withOpacity(0.8),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 20,
                        backgroundImage:
                            AssetImage('assets/images/287_286.png'),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'Chats',
                          style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.w700,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      _AppBarActionButton(
                        icon: Icons.camera_alt_outlined,
                        onPressed: () {},
                      ),
                      const SizedBox(width: 12),
                      _AppBarActionButton(
                        icon: Icons.edit_outlined,
                        onPressed: () {},
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  const _SearchBar(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(112.0);
}

class _AppBarActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _AppBarActionButton({required this.icon, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.04),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, color: Colors.black, size: 22),
      ),
    );
  }
}

class _SearchBar extends StatelessWidget {
  const _SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 36,
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          hintStyle: GoogleFonts.lato(
            color: const Color(0xFF8E8E93),
            fontSize: 17,
            letterSpacing: -0.41,
          ),
          prefixIcon: const Icon(Icons.search, color: Color(0xFF8E8E93)),
          filled: true,
          fillColor: Colors.black.withOpacity(0.05),
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class _ChatList extends StatelessWidget {
  const _ChatList({super.key});

  @override
  Widget build(BuildContext context) {
    final List<_Story> stories = [
      _Story(name: 'Your story', hasIcon: true),
      _Story(
          name: 'Joshua',
          imageUrl: 'assets/images/287_264.png',
          isOnline: true),
      _Story(
          name: 'Martin',
          imageUrl: 'assets/images/287_269.png',
          isOnline: true),
      _Story(
          name: 'Karen',
          imageUrl: 'assets/images/287_274.png',
          isOnline: true),
      _Story(name: 'Martha', imageUrl: 'assets/images/287_279.png'),
    ];

    final List<_Chat> chats = [
      _Chat(
        imageUrl: 'assets/images/287_242.png',
        name: 'Martin Randolph',
        message: 'You: What’s man!',
        time: '9:40 AM',
        isRead: true,
      ),
      _Chat(
        imageUrl: 'assets/images/287_207.png',
        name: 'Andrew Parker',
        message: 'You: Ok, thanks!',
        time: '9:25 AM',
        isRead: true,
      ),
      _Chat(
        imageUrl: 'assets/images/287_217.png',
        name: 'Maisy Humphrey',
        message: 'Have a good day, Jacob!',
        time: 'Fri',
        isRead: true,
      ),
      _Chat(
        imageUrl: 'assets/images/287_227.png',
        name: 'Karen Castillo',
        message: 'You: Ok, See you in To…',
        time: 'Fri',
        isRead: true,
      ),
      _Chat(
        imageUrl: 'assets/images/287_251.png',
        name: 'Joshua Lawrence',
        message: 'The business plan loo…',
        time: 'Thu',
        isRead: false,
      ),
      _Chat(
        imageUrl: 'assets/images/287_310.png',
        name: 'Pixsellz',
        message: 'Make design process easier…',
        time: '',
        isAd: true,
        adImageUrl: 'assets/images/287_317.png',
      ),
      _Chat(
        imageUrl: 'assets/images/287_237.png',
        name: 'Maximillian Jacobson',
        message: 'Messenger UI',
        time: 'Thu',
        isRead: false,
      ),
    ];

    return ListView(
      padding: EdgeInsets.zero,
      children: [
        _StoriesSection(stories: stories),
        ...chats.map((chat) => _ChatListItem(chat: chat)).toList(),
      ],
    );
  }
}

class _StoriesSection extends StatelessWidget {
  final List<_Story> stories;
  const _StoriesSection({required this.stories});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 106,
      color: Colors.white,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        scrollDirection: Axis.horizontal,
        itemCount: stories.length,
        itemBuilder: (context, index) {
          final story = stories[index];
          return Padding(
            padding: const EdgeInsets.only(right: 18.0),
            child: Column(
              children: [
                Stack(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: story.hasIcon
                          ? Colors.black.withOpacity(0.04)
                          : Colors.transparent,
                      backgroundImage: story.imageUrl != null
                          ? AssetImage(story.imageUrl!)
                          : null,
                      child: story.hasIcon
                          ? const Icon(Icons.add, color: Colors.black)
                          : null,
                    ),
                    if (story.isOnline)
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 18,
                          height: 18,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFF5AD439),
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 7),
                Text(
                  story.name,
                  style: GoogleFonts.lato(
                    fontSize: 13,
                    color: Colors.black.withOpacity(0.35),
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

class _ChatListItem extends StatelessWidget {
  final _Chat chat;
  const _ChatListItem({required this.chat});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(chat.name),
      startActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFFF0F0F0),
            foregroundColor: Colors.black,
            icon: Icons.menu,
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFFF0F0F0),
            foregroundColor: Colors.black,
            icon: Icons.notifications_none,
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFFFE294D),
            foregroundColor: Colors.white,
            icon: Icons.delete_outline,
          ),
        ],
      ),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFF0084FF),
            foregroundColor: Colors.white,
            icon: Icons.camera_alt,
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFFF0F0F0),
            foregroundColor: Colors.black,
            icon: Icons.videocam,
          ),
          SlidableAction(
            onPressed: (_) {},
            backgroundColor: const Color(0xFFF0F0F0),
            foregroundColor: Colors.black,
            icon: Icons.call,
          ),
        ],
      ),
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: () => context.go('/messanger_chats'),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundImage: AssetImage(chat.imageUrl),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            chat.name,
                            style: GoogleFonts.lato(
                              fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          if (chat.isAd) ...[
                            const SizedBox(width: 5),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 4, vertical: 1),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.2),
                                borderRadius: BorderRadius.circular(3),
                              ),
                              child: Text('Ad',
                                  style: GoogleFonts.lato(
                                      color: Colors.white,
                                      fontSize: 11,
                                      fontWeight: FontWeight.bold)),
                            )
                          ]
                        ],
                      ),
                      const SizedBox(height: 2),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              chat.message,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                          ),
                          if (chat.time.isNotEmpty)
                            Text(
                              ' · ${chat.time}',
                              style: GoogleFonts.lato(
                                fontSize: 14,
                                color: Colors.black.withOpacity(0.5),
                              ),
                            ),
                        ],
                      ),
                      if (chat.isAd)
                        Text(
                          'View More',
                          style: GoogleFonts.lato(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF0084FF),
                          ),
                        ),
                    ],
                  ),
                ),
                if (chat.isAd && chat.adImageUrl != null)
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.asset(chat.adImageUrl!,
                          width: 60, height: 60, fit: BoxFit.cover),
                    ),
                  ),
                if (chat.isRead)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.check_circle_outline,
                        color: Color(0xFFC2C6CD), size: 16),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
  const _BottomNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final String currentPath = GoRouterState.of(context).uri.toString();
    int currentIndex = 0;
    if (currentPath == '/messanger_chats') {
      currentIndex = 1;
    }

    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) {
        if (index == 0) {
          context.go('/messanger_swipe_actions');
        } else if (index == 1 || index == 2) {
          context.go('/messanger_chats');
        }
      },
      items: [
        const BottomNavigationBarItem(
          icon: Icon(Icons.chat_bubble),
          label: 'Chats',
        ),
        BottomNavigationBarItem(
          icon: Stack(
            clipBehavior: Clip.none,
            children: [
              const Icon(Icons.people_alt_outlined),
              Positioned(
                right: -8,
                top: -4,
                child: Container(
                  padding: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: const Color(0xFF5AD439).withOpacity(0.16),
                  ),
                  child: Text('2',
                      style: GoogleFonts.lato(
                          color: const Color(0xFF5AD439),
                          fontSize: 10,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
          label: 'People',
        ),
        const BottomNavigationBarItem(
          icon: Icon(Icons.explore_outlined),
          label: 'Discover',
        ),
      ],
      selectedItemColor: Colors.black,
      unselectedItemColor: Colors.grey,
      showUnselectedLabels: false,
      showSelectedLabels: false,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white.withOpacity(0.8),
      elevation: 0,
    );
  }
}

class _Story {
  final String name;
  final String? imageUrl;
  final bool isOnline;
  final bool hasIcon;

  _Story({
    required this.name,
    this.imageUrl,
    this.isOnline = false,
    this.hasIcon = false,
  });
}

class _Chat {
  final String imageUrl;
  final String name;
  final String message;
  final String time;
  final bool isRead;
  final bool isAd;
  final String? adImageUrl;

  _Chat({
    required this.imageUrl,
    required this.name,
    required this.message,
    required this.time,
    this.isRead = false,
    this.isAd = false,
    this.adImageUrl,
  });
}