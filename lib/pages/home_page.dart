import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../network/image_model.dart';
import '../network/image_request.dart';
import '../widgets/story_widget.dart';
import '../widgets/post_widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'IGViewer',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const FaIcon(FontAwesomeIcons.paperPlane),
            onPressed: () {
              Fluttertoast.showToast(msg: "Messages feature coming soon!");
            },
          ),
        ],
      ),
      body: FutureBuilder<Response<List<APIImage>>>(
        future: ImageService.create().getWorkingImages(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const FaIcon(
                    FontAwesomeIcons.triangleExclamation,
                    size: 64,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error loading posts',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Please check your connection and try again',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          final images = snapshot.data?.body ?? [];
          if (images.isEmpty) {
            return const Center(
              child: Text('No posts available'),
            );
          }

          return CustomScrollView(
            slivers: [
              // Stories section
              const SliverToBoxAdapter(
                child: StoriesWidget(),
              ),
              // Posts section
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return PostWidget(image: images[index]);
                  },
                  childCount: images.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}