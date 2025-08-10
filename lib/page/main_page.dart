import 'package:cached_network_image/cached_network_image.dart';
import 'package:chopper/chopper.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:igviewer/network/image_model.dart';
import 'package:igviewer/network/image_request.dart';

class PhotoPage extends StatelessWidget {
  const PhotoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.red[50],
        padding: const EdgeInsets.all(15),
        child: FutureBuilder<Response<List<APIImage>>>(
          future: ImageService.create().getWorkingImages().then((response) {
                print('API Response status: ${response.statusCode}');
                print('API Response body length: ${response.body?.length}');
                return response;
              }),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Center(
                child: Text(
                  'Error: ${snapshot.error.toString()}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 18),
                ),
              );
              }

              if (snapshot.hasData) {
                final images = snapshot.data?.body;
                return _buildSimpleList(context, images);
              } else {
                return const Center(
                  child: Text(
                    "No data received",
                    style: const TextStyle(fontSize: 18),
                  ),
                );
              }
            } else {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text("Loading images..."),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

Widget _buildSimpleList(BuildContext context, List<APIImage>? images) {
  if (images == null || images.isEmpty) {
    return const Center(
      child: Text(
        "Empty response 🥲",
        style: TextStyle(fontSize: 16),
      ),
    );
  }
  
  return ListView.builder(
    itemCount: images.length,
    itemBuilder: (ctx, idx) => Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
      elevation: 4,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => FullSpecWidget(url: images[idx].url),
            ),
          );
        },
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TopBarWidget(
                callback: () {
                  Fluttertoast.showToast(msg: "😊 YOU CLICK $idx!");
                },
              ),
            ),
            ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12),
              ),
              child: CachedNetworkImage(
                imageUrl: images[idx].thumbnailUrl,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error_outline),
              ),
            ),
          ],
        ),
      ),
    ),
  );
}

class TopBarWidget extends StatelessWidget {
  final VoidCallback? callback;

  const TopBarWidget({
    this.callback,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          const CircleAvatar(
            backgroundImage: AssetImage('images/Avatar.png'),
            radius: 20,
          ),
          const SizedBox(width: 12),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Jiaru Huang',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "Just now",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: callback,
            icon: const Icon(Icons.more_vert),
          ),
        ],
      ),
    );
  }
}

class FullSpecWidget extends StatelessWidget {
  final String url;

  const FullSpecWidget({
    super.key,
    required this.url,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image Detail'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              child: InteractiveViewer(
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error_outline),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FilledButton.icon(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back),
                label: const Text('Back to Gallery'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
