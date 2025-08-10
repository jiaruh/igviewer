import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AddPostPage extends StatelessWidget {
  const AddPostPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Create',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(height: 40),
            // Camera option
            _buildOptionCard(
              icon: FontAwesomeIcons.camera,
              title: 'Camera',
              subtitle: 'Take a new photo',
              onTap: () {
                Fluttertoast.showToast(msg: "Camera feature coming soon!");
              },
            ),
            const SizedBox(height: 20),
            // Gallery option
            _buildOptionCard(
              icon: FontAwesomeIcons.images,
              title: 'Gallery',
              subtitle: 'Choose from your photos',
              onTap: () {
                Fluttertoast.showToast(msg: "Gallery feature coming soon!");
              },
            ),
            const SizedBox(height: 20),
            // Story option
            _buildOptionCard(
              icon: FontAwesomeIcons.plus,
              title: 'Story',
              subtitle: 'Share a moment',
              onTap: () {
                Fluttertoast.showToast(msg: "Story feature coming soon!");
              },
            ),
            const SizedBox(height: 20),
            // Reel option
            _buildOptionCard(
              icon: FontAwesomeIcons.video,
              title: 'Reel',
              subtitle: 'Create a short video',
              onTap: () {
                Fluttertoast.showToast(msg: "Reel feature coming soon!");
              },
            ),
            const Spacer(),
            // Info text
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.blue[200]!),
              ),
              child: Row(
                children: [
                  const FaIcon(
                    FontAwesomeIcons.circleInfo,
                    color: Colors.blue,
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This is a demo app. Photo upload features will be available in the full version.',
                      style: TextStyle(
                        color: Colors.blue[800],
                        fontSize: 14,
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

  Widget _buildOptionCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: FaIcon(
                  icon,
                  size: 24,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      subtitle,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[600],
                      ),
                    ),
                  ],
                ),
              ),
              const FaIcon(
                FontAwesomeIcons.chevronRight,
                size: 16,
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ),
    );
  }
}