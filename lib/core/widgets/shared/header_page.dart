import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/responsive/responsive_extensions.dart';
import '../../../state/auth_controller.dart';

class HeaderPage extends StatelessWidget {
  final String title;
  final GlobalKey<ScaffoldState> scaffoldKey;
  final bool isDesktop;
  final bool isDashboard;
  final bool drawerExpanded;
  final VoidCallback? onToggleDrawer;

  final bool showSearchField;
  final TextEditingController? searchController;
  final ValueChanged<String>? onSearchChanged;
  final String searchHint;

  final bool showNotifications;
  final List<Widget>? actions;

  const HeaderPage({
    super.key,
    required this.title,
    required this.scaffoldKey,
    required this.isDesktop,
    required this.drawerExpanded,
    this.isDashboard = false,
    this.onToggleDrawer,
    this.showSearchField = false,
    this.searchController,
    this.onSearchChanged,
    this.searchHint = 'Search...',
    this.showNotifications = false,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();
    final userData = authController.getMockUserData();
    final userName = userData['name']?.split(' ')[0] ?? 'User';

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isDesktop ? context.xl : context.md,
        vertical: context.sm,
      ),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Theme.of(context).dividerColor, width: 1),
        ),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final bool isMobile = constraints.maxWidth < 768;

          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Left side: Menu button and title
              Flexible(
                child: Row(
                  children: [
                    IconButton(
                      onPressed: () {
                        if (isDesktop) {
                          onToggleDrawer?.call();
                        } else {
                          scaffoldKey.currentState?.openDrawer();
                        }
                      },
                      icon: Icon(
                        isDesktop
                            ? (drawerExpanded ? Icons.menu_open : Icons.menu)
                            : Icons.menu,
                      ),
                    ),
                    SizedBox(width: isMobile ? context.xs : context.md),
                    Flexible(
                      child: isDashboard
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                if (!isMobile)
                                  Text(
                                    'Dashboard',
                                    style: context.titleLargeStyle.copyWith(
                                      fontSize: context.fontSizeLg * 1.5,
                                      fontWeight: FontWeight.w700,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                if (isMobile)
                                  Text(
                                    'Dashboard',
                                    style: TextStyle(
                                      fontSize: context.fontSizeMd,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                                if (!isMobile)
                                  Text(
                                    'Welcome back, $userName! 👋',
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                  ),
                              ],
                            )
                          : Text(
                              title,
                              style: TextStyle(
                                fontSize: isMobile
                                    ? context.fontSizeMd
                                    : context.fontSizeLg,
                                fontWeight: FontWeight.bold,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                            ),
                    ),
                  ],
                ),
              ),

              // Right side: Search, notifications, avatar, and custom actions
              Flexible(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (showSearchField) ...[
                      if (isMobile)
                        IconButton(
                          onPressed: () {
                            // Open search dialog or expand search on mobile
                            _showSearchDialog(context);
                          },
                          icon: Icon(Icons.search),
                        )
                      else
                        Container(
                          constraints: BoxConstraints(
                            maxWidth: constraints.maxWidth * 0.3,
                            minWidth: 100,
                          ),
                          child: TextField(
                            controller: searchController,
                            decoration: InputDecoration(
                              hintText: searchHint,
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 8,
                              ),
                              isDense: true,
                            ),
                            onChanged: onSearchChanged,
                          ),
                        ),
                      if (!isMobile) SizedBox(width: context.md),
                    ],

                    if (showNotifications) ...[
                      IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.notifications),
                      ),
                      SizedBox(width: context.xs),
                    ],

                    // Custom actions
                    if (actions != null && !isMobile) ...actions!,

                    // User avatar - always visible
                    GestureDetector(
                      onTap: () => Get.toNamed('/my_profile'),
                      child: CircleAvatar(
                        radius: isMobile ? 16 : 18,
                        backgroundImage: NetworkImage(userData['avatar'] ?? ''),
                        child: userData['avatar'] == null
                            ? Icon(Icons.person)
                            : null,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void _showSearchDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Search'),
          content: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: searchHint,
              border: OutlineInputBorder(),
            ),
            autofocus: true,
            onChanged: onSearchChanged,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Search'),
            ),
          ],
        );
      },
    );
  }
}
