import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:chopper/chopper.dart';
import '../network/image_model.dart';
import '../network/image_request.dart';
import '../widgets/image_detail_page.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<APIImage> _userPosts = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _loadUserPosts();
  }

  Future<void> _loadUserPosts() async {
    try {
      final response = await ImageService.create().getWorkingImages();
      if (response.body != null) {
        setState(() {
          _userPosts = response.body!;
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'jiaru_huang',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.bars),
            onPressed: () {
              _showProfileMenu(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Profile header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Profile picture and stats
                Row(
                  children: [
                    CircleAvatar(
                      radius: 40,
                      backgroundImage: const AssetImage('images/Avatar.png'),
                      onBackgroundImageError: (exception, stackTrace) {},
                      child: const Icon(Icons.person, size: 48),
                    ),
                    const SizedBox(width: 20),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildStatColumn('${_userPosts.length}', 'Posts'),
                          _buildStatColumn('1.2K', 'Followers'),
                          _buildStatColumn('856', 'Following'),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Bio
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jiaru Huang',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        '📸 Photography enthusiast\n🌍 Travel lover\n💻 Developer',
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.3,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Edit profile feature coming soon!");
                        },
                        child: const Text('Edit Profile'),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () {
                          Fluttertoast.showToast(msg: "Share profile feature coming soon!");
                        },
                        child: const Text('Share Profile'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Tab bar
          TabBar(
            controller: _tabController,
            tabs: const [
              Tab(icon: FaIcon(FontAwesomeIcons.tableCells, size: 20)),
              Tab(icon: FaIcon(FontAwesomeIcons.video, size: 20)),
              Tab(icon: FaIcon(FontAwesomeIcons.bookmark, size: 20)),
            ],
          ),
          // Tab content
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: [
                // Posts grid
                _buildPostsGrid(),
                // Reels (placeholder)
                _buildPlaceholderTab('Reels', FontAwesomeIcons.video),
                // Saved (placeholder)
                _buildPlaceholderTab('Saved Posts', FontAwesomeIcons.bookmark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatColumn(String count, String label) {
    return Column(
      children: [
        Text(
          count,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildPostsGrid() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_userPosts.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const FaIcon(
              FontAwesomeIcons.camera,
              size: 64,
              color: Colors.grey,
            ),
            const SizedBox(height: 16),
            Text(
              'No Posts Yet',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'When you share photos, they\'ll appear on your profile.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: Colors.grey,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(2),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: _userPosts.length,
      itemBuilder: (context, index) {
        final post = _userPosts[index];
        return GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ImageDetailPage(image: post),
              ),
            );
          },
          child: CachedNetworkImage(
            imageUrl: post.thumbnailUrl,
            fit: BoxFit.cover,
            placeholder: (context, url) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: Colors.grey[200],
              child: const Center(
                child: FaIcon(
                  FontAwesomeIcons.image,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildPlaceholderTab(String title, IconData icon) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(
            icon,
            size: 64,
            color: Colors.grey,
          ),
          const SizedBox(height: 16),
          Text(
            title,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 8),
          Text(
            'This feature is coming soon!',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.grey,
            ),
          ),
        ],
      ),
    );
  }

  void _showProfileMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.gear),
              title: const Text('Settings'),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Settings feature coming soon!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.clock),
              title: const Text('Your Activity'),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Activity feature coming soon!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.qrcode),
              title: const Text('QR Code'),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "QR Code feature coming soon!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              title: const Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Logout feature coming soon!");
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}