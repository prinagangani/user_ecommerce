import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:user_ecommerce/screen/home/modal/home_modal.dart';
import 'package:user_ecommerce/utils/firebase_helper.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blueGrey,
          title: Text("Cart screen"),
        ),
        body: StreamBuilder(
            stream: FireBaseHelper.fireBaseHelper.readData(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                List<HomeModal> cartList = [];
                QuerySnapshot? snapdata = snapshot.data;
                for (var x in snapdata!.docs) {
                  Map data = x.data() as Map;
                  String name = data['name'];
                  String price = data['price'];
                  String quantity = data['quantity'];
                  String rate = data['rate'];
                  String description = data['description'];
                  String image = data['image'];
                  String docId = x.id;
                  print(docId);

                  HomeModal homemodal = HomeModal(
                      name: name,
                      docId: docId,
                      price: price,
                      quantity: quantity,
                      rate: rate,
                      description: description,
                      image: image);
                  cartList.add(homemodal);
                }
                return Stack(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: cartList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                height: 100,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      color: Colors.blueGrey,
                                    )),
                                child: Row(
                                  // mainAxisAlignment: MainAxisAlignment.spaceAround,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(5),
                                        height: 95,
                                        width: 90,
                                        child: Image.network(
                                          "${cartList[index].image}",
                                          fit: BoxFit.cover,
                                        )),
                                    SizedBox(
                                      width: 22,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "${cartList[index].name}",
                                          style: TextStyle(fontSize: 17),
                                        ),
                                        SizedBox(height: 7),
                                        Text("\$ ${cartList[index].price}",
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: Colors.orange)),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 50),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: Center(
                                                  child: Icon(
                                                    Icons.add,
                                                    size: 17,
                                                    color: Colors.orange,
                                                  ),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueGrey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(12)),
                                              ),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text("1"),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Container(
                                                height: 25,
                                                width: 25,
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      bottom: 14),
                                                  child: Center(
                                                      child: Icon(
                                                    Icons.minimize,
                                                    size: 17,
                                                    color: Colors.orange,
                                                  )),
                                                ),
                                                decoration: BoxDecoration(
                                                    color: Colors.blueGrey.shade300,
                                                    borderRadius:
                                                        BorderRadius.circular(12)),
                                              ),
                                            ],
                                          ),
                                          SizedBox(height: 9),
                                         InkWell(
                                           onTap: () {
                                             print("${cartList[index].docId}");
                                             FireBaseHelper.fireBaseHelper.delete("${cartList[index].docId}");
                                           },
                                           child: Container(
                                             child: Center(child: Text("Delete",style: TextStyle(color: Colors.red,fontSize: 13),)),
                                             height: 25,width: 60,decoration: BoxDecoration(border: Border.all(color: Colors.blueGrey.shade500,width: 1.5),borderRadius: BorderRadius.circular(6)),
                                           ),
                                         )
                                        ],
                                      ),
                                    )
                                  ],
                                )),
                          );
                        },
                      ),
                    ),
                    Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: const EdgeInsets.all(13),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('/buy');
                            },
                            child: Container(
                              height: 35,
                              width: 200,
                              child: Center(child: Text("Place Order",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,wordSpacing: 1,letterSpacing: 2,color: Colors.white),)),
                              decoration: BoxDecoration(color: Colors.blueGrey.shade500,borderRadius: BorderRadius.circular(15)),
                            ),
                          ),
                        )),
                  ],
                );
              }
              return CircularProgressIndicator();
            }),
      ),
    );
  }
}
