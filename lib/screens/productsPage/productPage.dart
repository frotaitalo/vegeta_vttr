import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:vttr/models/product.dart';
import 'package:vttr/models/product_comment.dart';

class ProductPage extends StatefulWidget {
  final Product product;

  const ProductPage({Key? key, required this.product}) : super(key: key);

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  List<ProductComment> comments = [];
  
  Future<void> getProductComment() async {
    try {
      comments = (await widget.product.comments)!;

      print("Quantidade de comentários do produto: " + comments.length.toString() + " " + widget.product.name);
    }
    catch(e) {
      print("Não foi possível buscar os comentários do produto.");
    }
  }
  
  @override
  void initState() {
    getProductComment();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff000915),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Cabeçalho
              const TopBar(
                text: 'Produtos VTR',
                text2: 'Explore nossa linha de produtos!',
              ),
              const Divider(
                thickness: 2,
                color: Color(0xffA49930),
              ),
              // Cabeçalho
              Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.7,
                    color: const Color(0xffA49930),
                    child: Column(
                      children: [
                        Image.network(
                          widget.product.product_image,
                          fit: BoxFit.fill,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 15),
                          child: Text(
                            widget.product.name,
                            style: const TextStyle(
                              fontWeight: FontWeight.w900,
                              fontSize: 17,
                              fontFamily: 'Rubik',
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10, left: 10, right: 10, top: 10), //ALTERAR
                          child: Text(
                            widget.product.description,
                            textAlign: TextAlign.justify,
                            style: const TextStyle(
                              fontSize: 11,
                              fontFamily: 'Rubik',
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'RS ${widget.product.price.toStringAsFixed(2)}',
                          style: const TextStyle(
                              fontSize: 18,
                              fontFamily: 'Rubik',
                              color: Color(0xffA2A2A4)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            // Implemente a lógica para adicionar o produto ao carrinho ou realizar a ação desejada
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xff2C5DA3),
                            foregroundColor: Colors.white,
                            minimumSize: const Size(0, 30),
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12)),
                            ),
                          ),
                          child: const Text("Comprar"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
