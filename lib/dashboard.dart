import 'package:appsteantask/loginpage.dart';
import 'package:appsteantask/videoplayer.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';

class VideoItem {
  final String videoUrl;
  final int id;
  final String imageUrl;
  final String title;
  final Duration duration;

  VideoItem({
    required this.videoUrl,
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.duration,
  });
}


class dashboard extends StatefulWidget {
   final String name;
  final String username;
  final int id;
  final String image;

  const dashboard({
    Key? key,
    required this.name,
    required this.username,
    required this.id,
    required this.image,
  }) : super(key: key);

  @override
  State<dashboard> createState() => _dashboardState();
}

Future<void> _launchUrl(_url) async {
  if (!await launchUrl(_url)) {
    throw Exception('Could not launch $_url');
  }
}


class _dashboardState extends State<dashboard> {
  late TextEditingController _searchController;
  late List<VideoItem> filteredVideos;
  late SharedPreferences _prefs;

  final List<VideoItem> videos = [
    VideoItem(
      id: 01,
      videoUrl:
          'https://videos.pexels.com/video-files/19990812/19990812-uhd_2560_1440_30fps.mp4',
      imageUrl:
          'https://img.freepik.com/free-photo/world-collapse-doomsday-scene-digital-painting_456031-63.jpg?t=st=1713877725~exp=1713881325~hmac=4864b966a8bbb4e895bee02488697d9a55c0e42bb9b5d279050f37afcbf5d81d&w=1380',
      title: 'This is 1st video',
      duration: Duration(minutes: 2, seconds: 30),
    ),
    VideoItem(
      id: 02,
      videoUrl:
          'https://videos.pexels.com/video-files/19807833/19807833-uhd_3840_2160_25fps.mp4',
      imageUrl:
          'https://img.freepik.com/free-photo/cruel-war-scenes-digital-painting_456031-162.jpg?t=st=1713870594~exp=1713874194~hmac=459657b8b22a6995ac27ddc01365eb42429f6818755f33a0a26d3d78ef396bbe&w=1380',
      title: 'This is 2nd video',
      duration: Duration(minutes: 3, seconds: 15),
    ),
    VideoItem(
      id: 03,
      videoUrl:
          'https://videos.pexels.com/video-files/6942639/6942639-hd_1920_1080_25fps.mp4',
      imageUrl:
          'https://img.freepik.com/free-photo/apocalyptic-destruction-war-zone-landscape_23-2150985678.jpg?t=st=1713878704~exp=1713882304~hmac=a5e9c09cf0b045ec91ddce9b49ab63ef4d2bdfa03a011f059f46bad737083497&w=900',
      title: 'This is 3rd video',
      duration: Duration(minutes: 2, seconds: 45),
    ),
    VideoItem(
      id: 04,
      videoUrl:
          'https://videos.pexels.com/video-files/20144591/20144591-uhd_3840_2160_24fps.mp4',
      imageUrl:
          'https://img.freepik.com/free-photo/futuristic-moon-background_23-2150930864.jpg?t=st=1713878765~exp=1713882365~hmac=2853c01e192001790e0e74bd5ba7dbe5a30212a860806a9b29281a7142ceab6d&w=900',
      title: 'This is 4th video',
      duration: Duration(minutes: 3, seconds: 07),
    ),
  ];
  @override
  void initState() {
    super.initState();
    filteredVideos = videos;
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
    _initPrefs();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _initPrefs() async {
    _prefs = await SharedPreferences.getInstance();
  }

    Future<bool> _isVideoDownloaded(int id) async {
    final downloadedIds = _prefs.getStringList('downloadedIds') ?? [];
    return downloadedIds.contains(id.toString());
  }

  void _toggleDownloadStatus(int id) async {
    final downloadedIds = _prefs.getStringList('downloadedIds') ?? [];
    if (downloadedIds.contains(id.toString())) {
      downloadedIds.remove(id.toString());
    } else {
      downloadedIds.add(id.toString());
    }
    await _prefs.setStringList('downloadedIds', downloadedIds);
    setState(() {});
  }
    void _clearPrefs() async {
    await _prefs.clear();
  }

  void _onSearchChanged() {
    setState(() {
      filteredVideos = videos.where((video) {
        final query = _searchController.text.toLowerCase();
        return video.title.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Color.fromARGB(255, 35, 103, 158),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          onPressed: () => print("hello"),
                          icon: Icon(
                            Icons.notifications,
                            color: Colors.white,
                          ),
                        ),
                        IconButton(
                          onPressed: (){
                             _clearPrefs();
                            Get.offAll(Loginpage());
                          },
                          icon: Icon(Icons.logout, color: Colors.white),
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: SizedBox(
                          width: 150,
                          height: 150,
                          child: Image.network(
                            "${widget.image}",
                            fit: BoxFit.fitWidth,
                          ),
                        ),
                      ),
                    ),
                    Text(
                      "Hello ${widget.name}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      "Developer",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              decoration: InputDecoration(
                                hintText: 'Search...',
                                filled: true,
                                fillColor: Color.fromRGBO(255, 255, 255, 1),
                                border: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)),
                                ),
                                hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                                contentPadding:
                                    EdgeInsets.symmetric(vertical: 8),
                                prefixIcon: Icon(Icons.search,
                                    color: const Color.fromARGB(255, 0, 0, 0)),
                              ),
                              style: TextStyle(color: Colors.black),
                            ),
                          ),
                          IconButton(
                            onPressed: () {
                              // Add filter functionality here
                            },
                            icon: Icon(Icons.filter_list, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    )
                  ],
                ),
              ),
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredVideos.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Get.to(videoplayer(), arguments: filteredVideos[index]);
                      print("Video URL: ${filteredVideos[index].videoUrl}");
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.all(16.0),
                        child: Row(
                          children: [
                            SizedBox(
                              height: 80,
                              width: 130,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(8.0),
                                child: Image.network(
                                  videos[index].imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    filteredVideos[index].title,
                                    style: TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.alarm),
                                      SizedBox(width: 8.0),
                                      Text(
                                        "${filteredVideos[index].duration.inMinutes}:${filteredVideos[index].duration.inSeconds % 60}",
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                             FutureBuilder<bool>(
                              future: _isVideoDownloaded(filteredVideos[index].id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState == ConnectionState.waiting) {
                                  return CircularProgressIndicator(); // or any other loading indicator
                                } else {
                                  final bool isDownloaded = snapshot.data ?? false;
                                  return IconButton(
                                    onPressed: () {
                                        final Uri _url = Uri.parse(filteredVideos[index].videoUrl);
                                _launchUrl(_url);
                                      _toggleDownloadStatus(filteredVideos[index].id);
                                    },
                                    icon: Icon(
                                      isDownloaded ? Icons.done : Icons.download,
                                      color: isDownloaded ? Colors.green : Colors.blue,
                                    ),
                                  );}})
                            // IconButton(
                            //   onPressed: () {
                            //     // Add download functionality
                            //     final Uri _url =
                            //         Uri.parse(filteredVideos[index].videoUrl);
                            //     _launchUrl(_url);
                            //   },
                            //   icon: Icon(Icons.download),
                            //   color: Colors.blue,
                            // ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
