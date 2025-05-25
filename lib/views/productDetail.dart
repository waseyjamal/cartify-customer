// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:ecom/controller/cartController.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/controller/cartController.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

import '../controller/getDataController.dart';

class viewProduct extends StatefulWidget {
  const viewProduct({super.key});

  @override
  State<viewProduct> createState() => _viewProductState();
}

class _viewProductState extends State<viewProduct> {
  final Getcontroller getdatacontroller = Get.put(Getcontroller());
  CartController cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // product data is passed to this screen via Get.arguments when navigating to it.
    final arguments = Get.arguments;  
    
    final selectedProduct = arguments['data'];

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: StreamBuilder(
            stream: getdatacontroller.getProductData(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              } else if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                final product = selectedProduct;

                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Card(
                        elevation: 3,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(20),
                              bottomRight: Radius.circular(20)),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            imageUrl: "${product['ImageURL'] ?? ""}",
                            placeholder: (context, url) => Transform.scale(
                              scaleX: 0.5,
                              scaleY: 0.5,
                              child: CircularProgressIndicator(
                                color: Colors.blue,
                                strokeWidth: 12,
                              ),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: SizedBox(
                          width: size.width,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "${product['Product Name'] ?? "Name Not found"}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    Text('MRP'),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      '₹1,20,899',
                                      style: TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      "₹${product['Price'] ?? "N/A"}",
                                      style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 5,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(bottom: 2),
                                      child: ClipPath(
                                        clipper: SlightSlantClipper(),
                                        child: Container(
                                          width: 58,
                                          height: 18,
                                          color: Colors.red,
                                          alignment: Alignment.center,
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.only(right: 4),
                                            child: Text(
                                              "17% OFF",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 11,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            child: Card(
                              elevation: 5,
                              child: Container(
                                height: size.height / 6.5,
                                width: size.width,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 5),
                                      child: Text(
                                        "Product details",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    Divider(
                                      thickness: 1,
                                    ),
                                    Text(
                                      "${product['Discription']}" ?? "",
                                      maxLines: 4,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          // SizedBox(
                          //   height: size.height/15,
                          //   child: dropDown(),
                          // )
                          SizedBox(
                            height: 70,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: InkWell(
                              onTap: () {
                                cartController.addtoCart(
                                  "${product['ImageURL'] ?? ""}",
                                  "${product['Product Name'] ?? "Name Not found"}",
                                  "${product['Price'] ?? "N/A"}",
                                );
                                Fluttertoast.showToast(
                                  msg: 'Added Successfully',
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.TOP,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                );
                              },
                              child: Container(
                                height: size.height / 18,
                                width: size.width,
                                decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(255, 238, 218, 43),
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                    child: Text(
                                  'Add to Cart',
                                  style: TextStyle(
                                      // fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 17),
                                )),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 12,
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              height: size.height / 18,
                              width: size.width,
                              decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 236, 150, 36),
                                  borderRadius: BorderRadius.circular(50)),
                              child: Center(
                                  child: Text(
                                'Buy Now',
                                style: TextStyle(
                                    // fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 17),
                              )),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                );
              } else {
                return Center(
                  child: Text("No product data available"),
                );
              }
            }),
            
      ),
      
    );
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
