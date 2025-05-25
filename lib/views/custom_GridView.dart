import 'package:cartify/controller/getDataController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../route/routeName.dart';

// ignore: must_be_immutable
class CustomGridView extends StatefulWidget {
  const CustomGridView({super.key});

  @override
  State<CustomGridView> createState() => _CustomGridViewState();
}

class _CustomGridViewState extends State<CustomGridView> {
  // final List<Item> items;
  Getcontroller getcontroller = Get.put(Getcontroller());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      return GridView.builder(
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: size.width * 0.012,
          mainAxisSpacing: size.height * 0.008,
          childAspectRatio: 0.89,
        ),

        itemCount: getcontroller.filterProducts.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              print(
                "Image URL: ${getcontroller.filterProducts[index]['ImageURL']}",
              );

              Get.toNamed(
                Routename.viewProduct,
                arguments: {
                  'index': index,
                  'data': getcontroller.filterProducts[index],
                },
              );
            },
            child: Container(
              padding: EdgeInsets.all(size.width * 0.013),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(size.width * 0.014),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 7,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: size.height * 0.1425,
                        width: size.width,
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl:
                              "${getcontroller.filterProducts[index]['ImageURL'] ?? ""}",
                          placeholder:
                              (context, url) => Center(
                                child: SizedBox(
                                  width: size.width * 0.06,
                                  height: size.height * 0.03,
                                  child: CircularProgressIndicator(
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                          errorWidget: (context, url, error) {
                            print(
                              "Error loading image: $error",
                            ); 
                            return Icon(Icons.error, color: Colors.red);
                          },
                        ),
                      ),
                      Positioned(
                        // top: 1,
                        // left: 1,
                        child: ClipPath(
                          clipper: SlightSlantClipper(),
                          child: Container(
                            width: size.width * 0.092,
                            height: size.height * 0.017,
                            color: Colors.red,
                            alignment: Alignment.center,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 4),
                              child: Text(
                                "17% OFF",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: size.width * 0.0197,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: size.height * 0.013),
                  Text(
                    '${getcontroller.filterProducts[index]["Product Name"]}',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: size.width * 0.028,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: size.height * 0.018),
                  Row(
                    children: [
                      Text(
                        '₹99,999',
                        style: TextStyle(
                          fontSize: size.width * 0.0235,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 5),
                      Text(
                        '₹${getcontroller.filterProducts[index]["Price"]}',
                        style: TextStyle(
                          fontSize: size.width * 0.03,
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(width: 5),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      );
    });
  }
}

class SlightSlantClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(size.width, 0); // Top-right corner
    path.lineTo(size.width - 6, size.height); // Slight slope (only 20px lower)
    path.lineTo(0, size.height); // Bottom-left
    path.lineTo(0, 0); // Top-left
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
