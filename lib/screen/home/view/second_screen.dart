import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_ecommerce/screen/home/controller/home_controller.dart';
import 'package:user_ecommerce/utils/firebase_helper.dart';

import '../modal/home_modal.dart';

class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  @override
  HomeModal? productData;

  void initState() {
    // TODO: implement initState
    super.initState();
    productData = Get.arguments;
  }

  String dropValue = "4";
  var items = ["4", "5", "6", "7", "8", "9"];

  HomeController? homeController = Get.put(HomeController());

  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Container(
              height: 330,
              width: double.infinity,
              decoration: BoxDecoration(
                  // color: Colors.blueGrey.shade100,
                  ),
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InkWell(
                            onTap: () {
                              Get.toNamed('/home');
                            },
                            child: Icon(Icons.arrow_back, size: 30)),
                        Icon(
                          Icons.favorite,
                          size: 30,
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Container(
                      height: 270,
                      width: double.infinity,
                      child: Image.network(
                        "${productData!.image}",
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${productData!.name}",
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star_outlined,
                          color: Colors.orange,
                          size: 19,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "${productData!.rate}",
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.orange),
                        ),
                      ],
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: Text(
                    "\$ ${productData!.price}",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.orange),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Details",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    Text(
                        "dnfjnjgngjrglrghlkgmdfkglfmnb,fgfdffn\nnjdfndjkdkjsbgk"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              child: Padding(
                padding: const EdgeInsets.only(left: 50),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Color : ",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 17),
                    ),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Container(
                          height: 20,
                          width: 23,
                          decoration: BoxDecoration(
                              color: Colors.blue,
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        SizedBox(width: 7),
                        Container(
                          height: 20,
                          width: 23,
                          decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        SizedBox(width: 7),
                        Container(
                          height: 20,
                          width: 23,
                          decoration: BoxDecoration(
                              color: Colors.orange,
                              borderRadius: BorderRadius.circular(3)),
                        ),
                        SizedBox(width: 7),
                        Container(
                          height: 20,
                          width: 23,
                          decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(3)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(right: 120),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Size :",style:
                  TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    height: 30,
                    width: 150,
                    decoration: BoxDecoration(color: Colors.blueGrey.shade50,),
                    child: Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: DropdownButton(

                        value: dropValue,
                        icon: Padding(
                          padding: const EdgeInsets.only(left: 100),
                          child: Icon(Icons.arrow_downward_outlined,size: 19,),
                        ),
                        items: items.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                      onChanged: (String? newValue) {
                          setState(() {
                            dropValue = newValue!;
                          });
                        }
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 40,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () {
                  // homeController.addData(h1);
                },
                child: InkWell(
                  onTap: () {
                    FireBaseHelper.fireBaseHelper.insert(
                        name: productData!.name,
                        price: productData!.price,
                        quantity: productData!.quantity,
                        description: productData!.description,
                        rate: productData!.rate,
                        image: productData!.image);
                    Get.toNamed('/home');
                  },
                  child: Container(
                    height: 40,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey,
                        borderRadius: BorderRadius.circular(11)),
                    child: Center(
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            letterSpacing: 2),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
