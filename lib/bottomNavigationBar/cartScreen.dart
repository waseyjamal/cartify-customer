import 'package:cached_network_image/cached_network_image.dart';
import 'package:cartify/controller/cartController.dart';
import 'package:cartify/route/routeName.dart';
import 'package:cartify/screen/dropDown.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import '../controller/historyController.dart';
import '../orders/shippingAddressScreen.dart';

class cartScreen extends StatefulWidget {
  const cartScreen({super.key});

  @override
  State<cartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<cartScreen> {
  CartController cartController = Get.put(CartController());
  dropDown dropdown = Get.put(dropDown());
  final historycontroller = Get.find<historyController>();

  @override
  void initState() {
    super.initState();
    cartController.fetchCartItem();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        title: Center(
          child: Text(
            'Cart',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: size.width * 0.055,
            ),
          ),
        ),
        
        
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: size.height * 0.052,
              color: const Color.fromARGB(255, 241, 241, 241),
              child: Row(
                children: [
                  SizedBox(
                    width: size.width * 0.8,
                    child: Row(
                      children: [
                        Obx(
                          () => Transform.scale(
                            scale: 0.95,
                            child: Checkbox(
                              value: cartController.checkboxStates.values.every(
                                (isChecked) => isChecked,
                              ),
                              onChanged: (value) {
                                for (var item in cartController.cartItems) {
                                  String cartItemId = item['CartItemID'];
                                  cartController.toggleCheckbox(
                                    cartItemId,
                                    value!,
                                  );
                                }
                              },
                              activeColor: Colors.red,
                              checkColor: Colors.white,
                              side: const BorderSide(
                                color: Colors.black,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        Obx(
                          () => Text(
                            "${cartController.selectedItemCount.value}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: size.width * 0.029,
                            ),
                          ),
                        ),
                        Text("/"),
                        Obx(
                          () => Text(
                            "${cartController.cartItems.length}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Colors.black54,
                              fontSize: size.width * 0.029,
                            ),
                          ),
                        ),
                        SizedBox(width: size.width * 0.01),
                        Text(
                          "ITEMS SELECTED",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                          ),
                        ),
                        SizedBox(width: size.width * 0.011),
                        SizedBox(
                          width: size.width * 0.26,
                          child: Obx(
                            () => Text(
                              "(${cartController.totalPrice.value.toString()})",
                              maxLines: 1,
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                              
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: size.width * 0.014),
                  InkWell(
                    onTap: () {
                      cartController.deleteSelectedItems();

                      Fluttertoast.showToast(
                        msg: 'Product deleted Successfully',
                        toastLength: Toast.LENGTH_SHORT,
                        gravity: ToastGravity.TOP,
                        backgroundColor: Colors.green,
                        textColor: Colors.white,
                      );
                    },
                    child: Icon(Icons.delete_outline),
                  ),
                  SizedBox(width: size.width * 0.018),
                  Icon(Icons.favorite_outline_sharp),
                ],
              ),
            ),
            Obx(() {
              if (cartController.isLoading.value) {
                return Center(child: CircularProgressIndicator());
              }
              if (cartController.cartItems.isEmpty) {
                return Center(child: Text("No items in your cart"));
              }

              return ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: cartController.cartItems.length,
                itemBuilder: (context, index) {
                  var item = cartController.cartItems[index];
                  String cartItemId = item['CartItemID'];

                  return SafeArea(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Stack(
                          children: [
                            Container(
                              height: size.height * 0.18,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 12),
                                    child: SizedBox(
                                      width: size.width * 0.303,
                                      height: size.height * 0.16,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl:
                                            item['ImageURL'] ??
                                            "https://via.placeholder.com/150",
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: size.width * 0.1),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            top: 10,
                                          ),
                                          child: SizedBox(
                                            width: size.width * 0.48,
                                            height: size.height * 0.065,
                                            child: Center(
                                              child: Text(
                                                '${item['Name'] ?? "(Right Aligned 3 Seater, Right Alighned Chaise)"}',
                                                maxLines: 3,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4, height: 8),
                                        Container(
                                          height: size.height / 30,
                                          width: size.width / 4.5,
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                              left: 8,
                                              right: 8,
                                            ),
                                            child: dropDown(),
                                          ),
                                        ),
                                        SizedBox(height: 8),
                                        Row(
                                          children: [
                                            Text('${item['Price'] ?? "0.00"}'),
                                            SizedBox(width: 8),
                                            Text(
                                              '1,20,899',
                                              style: TextStyle(
                                                decoration:
                                                    TextDecoration.lineThrough,
                                              ),
                                            ),
                                            SizedBox(width: 8),
                                            ClipPath(
                                              clipper: SlightSlantClipper(),
                                              child: Container(
                                                width: 50,
                                                height: 15,
                                                color: Colors.red,
                                                alignment: Alignment.center,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        right: 4,
                                                      ),
                                                  child: Text(
                                                    "17% OFF",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 10,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Positioned(
                              child: Obx(
                                () => Transform.scale(
                                  scale: 0.95,
                                  child: Checkbox(
                                    value: cartController.isChecked(cartItemId),
                                    onChanged: (value) {
                                      cartController.toggleCheckbox(
                                        cartItemId,
                                        value!,
                                      );
                                    },
                                    activeColor: Colors.red,
                                    checkColor: Colors.white,
                                    side: const BorderSide(
                                      color: Colors.black,
                                      width: 1.5,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: 7),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            }),
            Container(
              height: size.height / 25,
              decoration: BoxDecoration(color: Colors.white),
            ),
            Container(
              height: size.height / 4.5,
              decoration: BoxDecoration(color: Colors.white),
              child: Padding(
                padding: const EdgeInsets.only(left: 12),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Price Details',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: size.height / 50),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Price (item)"), Text("₹2343")],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Discount"),
                          Text("₹343", style: TextStyle(color: Colors.green)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Coupons for you"),
                          Text("₹154", style: TextStyle(color: Colors.grey)),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Platform Fee"), Text("₹5")],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [Text("Delivery Charge"), Text("₹80")],
                      ),
                    ),
                    SizedBox(height: size.height / 100),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(color: Colors.black, height: 0.5),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        right: 12,
                        top: 5,
                        bottom: 5,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Total Amount"),
                          Obx(
                            () => Text(
                              "(${cartController.totalPrice.value.toString()})",
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(color: Colors.black, height: 0.5),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Container(
          child: ElevatedButton(
            onPressed: () {
              var selectedItems =
                  cartController.cartItems.where((item) {
                    String cartItemId = item['CartItemID'];
                    return cartController.isChecked(cartItemId);
                  }).toList();

              double totalPrice = selectedItems.fold(0.0, (sum, item) {
                double price =
                    item['Price'] is String
                        ? double.parse(item['Price'])
                        : item['Price'];
                return sum + price;
              });

              Get.to(
                shippingAddressScreen(
                  selectedItems: selectedItems,
                  totalPrice: totalPrice,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 223, 122, 122),
              minimumSize: Size(double.infinity, 45),
            ),
            child: Text(
              'Proceed to Checkout',
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}

// another class

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
