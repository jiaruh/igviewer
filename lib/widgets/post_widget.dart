import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../network/image_model.dart';

class PostWidget extends StatefulWidget {
  final APIImage image;

  const PostWidget({super.key, required this.image});

  @override
  State<PostWidget> createState() => _PostWidgetState();
}

class _PostWidgetState extends State<PostWidget> {
  bool isLiked = false;
  bool isSaved = false;
  int likeCount = 0;

  @override
  void initState() {
    super.initState();
    // Generate random like count
    likeCount = (widget.image.hashCode % 1000).abs() + 10;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Post header
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: const AssetImage('images/Avatar.png'),
                  onBackgroundImageError: (exception, stackTrace) {},
                  child: const Icon(Icons.person, size: 20),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'jiaru_huang',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        'Just now',
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const FaIcon(FontAwesomeIcons.ellipsis, size: 16),
                  onPressed: () {
                    _showPostOptions(context);
                  },
                ),
              ],
            ),
          ),
          // Post image
          GestureDetector(
            onDoubleTap: () {
              setState(() {
                if (!isLiked) {
                  isLiked = true;
                  likeCount++;
                }
              });
            },
            child: CachedNetworkImage(
              imageUrl: widget.image.url,
              width: double.infinity,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                height: 300,
                color: Colors.grey[200],
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
              errorWidget: (context, url, error) => Container(
                height: 300,
                color: Colors.grey[200],
                child: const Center(
                  child: FaIcon(
                    FontAwesomeIcons.image,
                    size: 64,
                    color: Colors.grey,
                  ),
                ),
              ),
            ),
          ),
          // Post actions
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isLiked = !isLiked;
                      likeCount += isLiked ? 1 : -1;
                    });
                  },
                  child: FaIcon(
                    isLiked ? FontAwesomeIcons.solidHeart : FontAwesomeIcons.heart,
                    color: isLiked ? Colors.red : Colors.black,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Comments feature coming soon!");
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.comment,
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                GestureDetector(
                  onTap: () {
                    Fluttertoast.showToast(msg: "Share feature coming soon!");
                  },
                  child: const FaIcon(
                    FontAwesomeIcons.paperPlane,
                    size: 24,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      isSaved = !isSaved;
                    });
                    Fluttertoast.showToast(
                      msg: isSaved ? "Post saved!" : "Post unsaved!",
                    );
                  },
                  child: FaIcon(
                    isSaved ? FontAwesomeIcons.solidBookmark : FontAwesomeIcons.bookmark,
                    size: 24,
                  ),
                ),
              ],
            ),
          ),
          // Like count
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              '$likeCount likes',
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          // Caption
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: RichText(
              text: const TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                children: [
                  TextSpan(
                    text: 'jiaru_huang ',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: 'Beautiful moment captured! 📸 #photography #nature',
                  ),
                ],
              ),
            ),
          ),
          // View comments
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: "Comments feature coming soon!");
              },
              child: const Text(
                'View all 23 comments',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 14,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showPostOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.link),
              title: const Text('Copy Link'),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Link copied!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.shareFromSquare),
              title: const Text('Share'),
              onTap: () {
                Navigator.pop(context);
                Fluttertoast.showToast(msg: "Share feature coming soon!");
              },
            ),
            ListTile(
              leading: const FaIcon(FontAwesomeIcons.flag),
              title: const Text('Report'),
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