import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import '../constants/import_packages.dart';

class ImagePage extends StatefulWidget {
  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  int currentIndex = 0;
  PageController? _pageController;
  Color _color = Colors.lightBlue;
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  List<XFile> _listOfImages = [];
  String _myImage = "";

  @override
  Widget build(BuildContext context) {
    _pageController = PageController(initialPage: currentIndex);
    return Scaffold(
      backgroundColor: _color,
      body: PageView(
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        controller: _pageController,
        children: [
          const Text("1"),
          Stack(
            children: [
              SizedBox(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 15.0),
                      height: MediaQuery.of(context).size.width * 0.7,
                      width: MediaQuery.of(context).size.width * 0.9,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: FileImage(
                            File(_listOfImages[index].path),
                          ),
                        ),
                        borderRadius: BorderRadius.circular(12.0),
                        border: Border.all(
                          color: Colors.white,
                          width: 2,
                        ),
                      ),
                    );
                  },
                  itemCount: _listOfImages.length,
                ),
              ),
              Positioned(
                bottom: 50,
                right: 35,
                child: IconButton(
                  icon: Icon(
                    Icons.add_circle_outlined,
                    size: 75.0,
                    color: Colors.white.withOpacity(0.8),
                  ),
                  onPressed: () async {
                    image =
                        await _picker.pickImage(source: ImageSource.gallery);
                    _listOfImages.add(image!);
                    await _uploadToStorage();
                    setState(() {});
                  },
                ),
              ),
            ],
          ),
          const Text("3"),
        ],
      ),
      bottomNavigationBar: bottomMenu(),
    );
  }

  BottomNavigationBar bottomMenu() {
    return BottomNavigationBar(
      onTap: (index) {
        setState(() {
          currentIndex = index;
          _pageController!.jumpToPage(index);
          switch (index) {
            case 0:
              _color = Colors.lightBlue;
              break;
            case 1:
              _color = Colors.black;
              break;
            case 2:
              _color = Colors.greenAccent;
              break;
          }
        });
      },
      currentIndex: currentIndex,
      type: BottomNavigationBarType.shifting,
      selectedItemColor: Colors.white,
      items: const [
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: "Profile",
          backgroundColor: Colors.lightBlue,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.add_a_photo),
          label: "Add Photo",
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: "Settings",
          backgroundColor: Colors.greenAccent,
        ),
      ],
    );
  }

  _uploadToStorage() async {
    final Reference postImageRef =
        FirebaseStorage.instance.ref().child('rasmlar');
    DateTime _timeOfUpload = DateTime.now();

    final UploadTask uploadTask = postImageRef
        .child(_timeOfUpload.toString() + '.png')
        .putFile(File(image!.path));

    var urlOfImage =
        await (await uploadTask.whenComplete(() {})).ref.getDownloadURL();
    _uploadToFirestore(urlOfImage);
    debugPrint(urlOfImage.toString());
  }

  _uploadToFirestore(String url) async {
    CollectionReference ref = FirebaseFirestore.instance.collection('rasmlar');
    var data = {
      'user': "Example User",
      'image': url,
      'time': FieldValue.serverTimestamp(),
    };

    ref.add(data);
  }
}
