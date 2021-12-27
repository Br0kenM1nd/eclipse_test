import 'package:carousel_slider/carousel_slider.dart';
import 'package:draggable_scrollbar/draggable_scrollbar.dart';
import 'package:eclipse_test5/components/api.dart';
import 'package:eclipse_test5/components/album.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AlbumDetails extends StatefulWidget {
  final Album album;
  const AlbumDetails(this.album, {Key? key}) : super(key: key);

  @override
  State<AlbumDetails> createState() => _AlbumDetailsState();
}

class _AlbumDetailsState extends State<AlbumDetails> {
  ScrollController _semicircleController = ScrollController();
  int activeIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: Image.asset('images/eclipse3.png', fit: BoxFit.fill,),
        title: const Text('Photos'),
      ),
      body: FutureBuilder(
          future: Api().getPhotosList(widget.album.id),
          builder: (_, AsyncSnapshot snapshot) {
            if (snapshot.data == null) {
              return Center(
                child: const CircularProgressIndicator(),
              );
            } else {
              int imagesCnt = snapshot.data.length;
              return DraggableScrollbar.rrect(
                controller: _semicircleController,
                // isAlwaysShown: true,
                // showTrackOnHover: true,
                child: ListView.builder(
                  controller: _semicircleController,
                  itemCount: snapshot.data.length,
                    scrollDirection: Axis.vertical,
                    itemBuilder: (_, i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          alignment: Alignment.bottomLeft,
                          children: [
                            Container(
                              // padding: EdgeInsets.all(kDefaultPadding ),
                              child: SizedBox(
                                width: 500,
                                  child: Image.network(snapshot.data[i].url),
                              ),
                            ),
                            Text(snapshot.data[i].title, style: TextStyle(fontSize: 20, color: Colors.black),),
                          ],
                        ),
                      );
                    }
                ),
              );


              // int imagesCnt = snapshot.data.length;
              // return Column(
              //   children: [
              //     Scrollbar(
              //       child: CarouselSlider.builder(
              //         options: CarouselOptions(
              //           height: 400,
              //           enlargeCenterPage: true,
              //           onPageChanged: (i, reason) =>
              //               setState(() => activeIndex = i),
              //         ),
              //         itemCount: imagesCnt,
              //         itemBuilder: (context, i, realIndex) {
              //           return
              //             Container(
              //               margin: EdgeInsets.symmetric(horizontal: 12),
              //               child: SizedBox(
              //                 width: 500,
              //                 child: Image.network(snapshot.data[i].url),
              //               ),
              //             );
              //         },
              //       ),
              //     ),
              //     const SizedBox(height: 32,),
              //     // Slider(
              //     //   value: slidrIndex,
              //     //   max: imagesCnt.toDouble(),
              //     //   // divisions: 1,
              //     //   // label: slidrIndex.round().toString(),
              //     //   onChanged: (double value) {
              //     //     setState(() {
              //     //       sliderIndex = value;
              //     //     });
              //     //   },
              //     // ),
              //     // buildIndicator(imagesCnt),
              //   ],
              // );
            }
          },

      ),
    );
  }
  Widget buildImage(String urlImage, int i) => Container(
    margin: EdgeInsets.symmetric(horizontal: 24),
    color: Colors.grey,
    width: double.infinity,
    child: Image.network(
      urlImage,
      fit: BoxFit.cover,
    ),
  );

  Widget buildIndicator(int imagesCnt) => AnimatedSmoothIndicator(
    activeIndex: activeIndex,
    count: imagesCnt,
  );
}
