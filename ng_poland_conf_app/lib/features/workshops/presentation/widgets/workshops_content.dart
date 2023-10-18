import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../domains/entities/workshop.dart';

class WorkshopsContent extends StatelessWidget {
  final Workshop workshop;

  const WorkshopsContent({
    Key? key,
    required this.workshop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: InkWell(
        borderRadius: const BorderRadius.all(
          Radius.circular(25),
        ),
        onTap: () {
          // Navigator.of(context).pushNamed(
          //   Presenter.routeName,
          //   arguments: {
          //     'speaker': _workshopsItems[index].speaker,
          //   },
          // );
        },
        // child: Hero(
        //     tag: workshop.title, // workshop.speaker.photoFileUrl,
        //     child: Container()
        //     // CachedNetworkImage(
        //     //   progressIndicatorBuilder: (context, url, downloadProgress) => Image.asset('assets/images/person.png'),
        //     //   imageUrl: 'http:${_workshopsItems[index].speaker.photoFileUrl}',
        //     //   errorWidget: (context, url, dynamic error) {
        //     //     return Image.asset('assets/images/person.png');
        //     //   },
        //     //   imageBuilder: (context, imageProvider) => Container(
        //     //     width: 50,
        //     //     height: 50,
        //     //     decoration: BoxDecoration(
        //     //       shape: BoxShape.circle,
        //     //       image: DecorationImage(
        //     //         image: imageProvider,
        //     //       ),
        //     //     ),
        //     //   ),
        //     // ),
        //     ),
      ),
      title: Text(
        workshop.title,
      ),
      // subtitle: Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     SizedBox(
      //       height: MediaQuery.of(context).size.height * 0.010,
      //     ),
      //     // RichText(
      //     //   text: TextSpan(
      //     //     children: [
      //     //       TextSpan(
      //     //         text: workshop.speaker.name,
      //     //         style: TextStyle(color: _darkMode ? Theme.of(context).textTheme.bodyText1.color.withOpacity(0.7) : Theme.of(context).primaryColor, fontSize: 13),
      //     //         recognizer: TapGestureRecognizer()
      //     //           ..onTap = () {
      //     //             Navigator.of(context).pushNamed(
      //     //               Presenter.routeName,
      //     //               arguments: {
      //     //                 'speaker': _workshopsItems[index].speaker,
      //     //               },
      //     //             );
      //     //           },
      //     //       ),
      //     //     ],
      //     //   ),
      //     // ),
      //   ],
      // ),
    );
  }
}
