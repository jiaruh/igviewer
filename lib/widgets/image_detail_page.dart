import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../network/image_model.dart';

class ImageDetailPage extends StatefulWidget {
  final APIImage image;

  const ImageDetailPage({super.key, required this.image});

  @override
  State<ImageDetailPage> createState() => _ImageDetailPageState();
}

class _ImageDetailPageState extends State<ImageDetailPage> {
  bool isLiked = false;
  bool isSaved = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        foregroundColor: Colors.white,
        title: const Row(
          children: [
            CircleAvatar(
              radius: 16,
              backgroundImage: AssetImage('images/Avatar.png'),
              child: Icon(Icons.person, size: 20),
            ),
            SizedBox(width: 12),
            Text(
              'jiaru_huang',
              style: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.ellipsis),
            onPressed: () {
              _showImageOptions(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Image
          Expanded(
            child: Center(
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: widget.image.url,
                  fit: BoxFit.contain,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(color: Colors.white),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: FaIcon(
                      FontAwesomeIcons.image,
                      size: 64,
                      color: Colors.grey,
                    ),
                  ),
                ),
              ),
            ),
          ),
          // Bottom actions
          Container(
            color: Colors.black,
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                    });
                    Fluttertoast.showToast(
                      msg: isLiked ? "Liked!" : "Unliked!",
                    );
                  },
                  child: FaIcon(
                    isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                    color: isLiked ? Colors.red : Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Comments feature coming soon!");
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.comment,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const SizedBox(width: 20),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Share feature coming soon!");
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                    Fluttertoast.showToast(
                      msg: isSaved ? "Saved!" : "Unsaved!",
                    );
                  },
                  child: FaIcon(
                    isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                    color: Colors.white,
                    size: 28,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _showImageOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.grey[900],
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.download, color: Colors.white),
              title: const Text('Download', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Download feature coming soon!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.link, color: Colors.white),
              title: const Text('Copy Link', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Link copied!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.shareFromSquare, color: Colors.white),
              title: const Text('Share', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Share feature coming soon!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.flag, color: Colors.white),
              title: const Text('Report', style: TextStyle(color: Colors.white)),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Report submitted!");
              },
            ),
          ],
        ),
      ),
    );
  }
}