import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_ecommerce/screen/home/modal/home_modal.dart';
import 'package:user_ecommerce/utils/firebase_helper.dart';

class BuyScreen extends StatefulWidget {
  const BuyScreen({Key? key}) : super(key: key);

  @override
  State<BuyScreen> createState() => _BuyScreenState();
}

class _BuyScreenState extends State<BuyScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blueGrey,
            title: Text("Buy Your Product"),
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
                          child: Center(child: Text("Buy Now",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,wordSpacing: 1,letterSpacing: 2,color: Colors.white),)),
                          decoration: BoxDecoration(color: Colors.blueGrey.shade500,borderRadius: BorderRadius.circular(15)),
                        ),
                      ),
                    )),
              ],
            );
          }
          return CircularProgressIndicator();
        }),
        )
    );
  }
}
