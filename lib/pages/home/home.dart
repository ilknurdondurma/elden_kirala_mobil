import 'package:elden_kirala/services/fetch-data.dart';
import 'package:flutter/material.dart';
import '../../models/product-model/product-model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late Future<List<ProductModel>> futureProducts;

  @override
  void initState() {
    super.initState();
    futureProducts = FetchDataFromJson().getProduct();
    futureProducts.then((value) {
      setState(() {}); // Trigger a rebuild once the future completes
    }).catchError((error) {
      print("Error fetching products: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Product List'),
      ),
      body: Center(
        child: FutureBuilder<List<ProductModel>>(
          future: futureProducts,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text("Error: ${snapshot.error}");
            } else if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(snapshot.data![index].name ?? ''),
                  );
                },
              );
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }
}


