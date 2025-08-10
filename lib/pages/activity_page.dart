import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Activity',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Today section
          _buildSectionHeader('Today'),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'sarah_wilson',
            action: 'liked your photo',
            time: '2h',
            hasImage: true,
            onTap: () {
              Fluttertoast.showToast(msg: "View post feature coming soon!");
            },
          ),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'mike_chen',
            action: 'started following you',
            time: '4h',
            hasFollowButton: true,
            onTap: () {
              Fluttertoast.showToast(msg: "Profile feature coming soon!");
            },
          ),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'emma_davis',
            action: 'commented on your post: "Amazing shot! 📸"',
            time: '6h',
            hasImage: true,
            onTap: () {
              Fluttertoast.showToast(msg: "View comment feature coming soon!");
            },
          ),
          
          const SizedBox(height: 20),
          
          // This week section
          _buildSectionHeader('This Week'),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'alex_johnson',
            action: 'liked your photo',
            time: '2d',
            hasImage: true,
            onTap: () {
              Fluttertoast.showToast(msg: "View post feature coming soon!");
            },
          ),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'lisa_brown',
            action: 'started following you',
            time: '3d',
            hasFollowButton: true,
            onTap: () {
              Fluttertoast.showToast(msg: "Profile feature coming soon!");
            },
          ),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'david_kim',
            action: 'liked your photo',
            time: '5d',
            hasImage: true,
            onTap: () {
              Fluttertoast.showToast(msg: "View post feature coming soon!");
            },
          ),
          _buildActivityItem(
            avatar: 'images/Avatar.png',
            username: 'rachel_green',
            action: 'commented on your post: "Love this! 💕"',
            time: '6d',
            hasImage: true,
            onTap: () {
              Fluttertoast.showToast(msg: "View comment feature coming soon!");
            },
          ),
          
          const SizedBox(height: 20),
          
          // Suggestions section
          _buildSectionHeader('Suggested for you'),
          _buildSuggestionItem(
            avatar: 'images/Avatar.png',
            username: 'photography_pro',
            subtitle: 'Followed by sarah_wilson + 12 others',
            onFollow: () {
              Fluttertoast.showToast(msg: "Follow feature coming soon!");
            },
          ),
          _buildSuggestionItem(
            avatar: 'images/Avatar.png',
            username: 'nature_lover',
            subtitle: 'Followed by mike_chen + 8 others',
            onFollow: () {
              Fluttertoast.showToast(msg: "Follow feature coming soon!");
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildActivityItem({
    required String avatar,
    required String username,
    required String action,
    required String time,
    bool hasImage = false,
    bool hasFollowButton = false,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage(avatar),
              onBackgroundImageError: (exception, stackTrace) {},
              child: const Icon(Icons.person, size: 24),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                          text: username,
                          style: const TextStyle(fontWeight: FontWeight.w600),
                        ),
                        TextSpan(text: ' $action'),
                      ],
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    time,
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ),
            if (hasFollowButton)
              OutlinedButton(
                onPressed: () {
                  Fluttertoast.showToast(msg: "Follow feature coming soon!");
                },
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
                ),
                child: const Text('Follow'),
              ),
            if (hasImage)
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Icon(
                  Icons.image,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestionItem({
    required String avatar,
    required String username,
    required String subtitle,
    required VoidCallback onFollow,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage(avatar),
            onBackgroundImageError: (exception, stackTrace) {},
            child: const Icon(Icons.person, size: 24),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  username,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          FilledButton(
            onPressed: onFollow,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              backgroundColor: Colors.blue,
            ),
            child: const Text(
              'Follow',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}