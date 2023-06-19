import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:user_ecommerce/screen/home/controller/home_controller.dart';
import 'package:user_ecommerce/screen/home/modal/home_modal.dart';
import 'package:user_ecommerce/utils/firebase_helper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Home"),
          backgroundColor: Colors.blueGrey,
          actions: [
            IconButton(onPressed: () {
                Get.toNamed('/cart');
            }, icon: Icon(Icons.shopping_cart)),
          ],
        ),
        drawer: Drawer(
          child: Column(children: [
            Container(
              height: 230,
              width: double.infinity,
              color: Colors.blueGrey.shade100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 70 ,
                    backgroundImage: NetworkImage(homeController.data['img']==null?'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTKrPq0NZUYi-PCxk1Q2RrNJ7rDQW3C46QFiw&usqp=CAU':'${homeController.data['img']}'),
                  ),
                  Text(
                    "Prina Gangani",
                    style: TextStyle(fontSize: 22),
                  ),
                  Text("prinagangani@gmail.com"),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text(
                "Home",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_cart),
              title: Text(
                "Cart",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: Icon(Icons.shopping_bag_outlined),
              title: Text(
                "Orders",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text(
                "Profile",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text(
                "Settings",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text(
                "About Us",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: Icon(Icons.help),
              title: Text(
                "Help",
                style: TextStyle(fontSize: 19),
              ),
            ),
            ListTile(
              leading: IconButton(
                  onPressed: () {
                    bool? msg = FireBaseHelper.fireBaseHelper.logout();
                    if (msg = true) {
                      Get.offNamed('/signin');
                      Get.snackbar("success", "$msg");
                    }
                  },
                  icon: Icon(Icons.logout)),
              title: Text(
                "Logout",
                style: TextStyle(fontSize: 19),
              ),
            ),
          ]),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 40,
                    width: 250,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(3),
                      border: Border.all(width: 1.3, color: Colors.grey),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.only(left: 25, top: 9),
                      child: Text(
                        "Search",
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey.shade100,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Icon(Icons.search),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                        color: Colors.blueGrey.shade100,
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(child: Text("All",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  Container(
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.blueGrey,width: 1.3),
                        borderRadius: BorderRadius.circular(16)),
                    child: Center(child: Text("Running",style: TextStyle(fontWeight: FontWeight.bold,),)),
                  ),
                  Container(
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),border: Border.all(color: Colors.blueGrey,width: 1.3)),
                    child: Center(child: Text("Air force",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                  Container(
                    height: 35,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),border: Border.all(color: Colors.blueGrey,width: 1.3)),
                    child: Center(child: Text("Jordan",style: TextStyle(fontWeight: FontWeight.bold),)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder(
                stream: FireBaseHelper.fireBaseHelper.read(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text("${snapshot.error}");
                  } else if (snapshot.hasData) {
                    List<HomeModal> dataList = [];
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
                      dataList.add(homemodal);
                    }
                    return GridView.builder(
                      itemCount: dataList.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2, mainAxisExtent: 280),
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                              Get.toNamed('/second',arguments: dataList[index]);
                            },
                            child: Container(
                              margin: EdgeInsets.all(10),
                              height: 90,
                              width: 100,
                              decoration: BoxDecoration(
                                // color: Colors.blueGrey.shade50,
                                borderRadius: BorderRadius.circular(12),
                                // border: Border.all(width: 1.3,color: Colors.blueGrey)
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.network("${dataList[index].image}",),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 20),
                                    child: Text("${dataList[index].name}",style: TextStyle(fontSize: 17),),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 50),
                                    child: Text("\$ ${dataList[index].price}",style: TextStyle(color: Colors.orange,fontWeight: FontWeight.bold),),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    );
                    // return ListView.builder(itemBuilder: (context, index) {
                    //   return ListTile(
                    //     title: Text("${dataList[index].name}"),
                    //     subtitle: Text("${dataList[index].price}"),
                    //   );
                    // },itemCount: dataList.length,);
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
