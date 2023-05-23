// ignore_for_file: prefer_const_constructors, unused_import, deprecated_member_use, prefer_const_declarations

import 'package:flutter/material.dart';
import 'package:vttr/components/top_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class Product {
  final int numSerie;
  final String description;
  final String garantia;
  final String photoUrl;

  Product({
    required this.numSerie,
    required this.description,
    required this.garantia,
    required this.photoUrl,
  });
}

final Uri _url = Uri.parse('https://pub.dev/packages/url_launcher');
final String _urlDriver =
    'https://www.tuningparts.com.br/arq/manual-tecnico-de-instalacao-fastrev01web105211072019.pdf';

class MyProductsPage extends StatefulWidget {
  const MyProductsPage({Key? key}) : super(key: key);

  @override
  State<MyProductsPage> createState() => _MyProductsPageState();
}

class _MyProductsPageState extends State<MyProductsPage> {
  final List<Product> products = [
    Product(
      numSerie: 08821,
      description: 'Descrição do produto 1',
      garantia: 'Vitalícia',
      photoUrl: 'assets/images/pedalUm.png',
    ),
    Product(
      numSerie: 2034,
      description: 'Descrição do produto 2',
      garantia: '27/12/2024',
      photoUrl: 'assets/images/pedalDois.png',
    ),
    Product(
      numSerie: 0900,
      description: 'Descrição do produto 3',
      garantia: '27/12/2024',
      photoUrl: 'assets/images/pedalTres.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff000915),
      body: SingleChildScrollView(
        child: Column(
          children: [
            TopBar(text: 'Meus Produtos', text2: ''),
            const Divider(
              thickness: 2,
              color: Color(0xffA49930),
            ),
            Padding(padding: EdgeInsets.only(top: 10)),
            if (products.isNotEmpty)
              _buildProductList()
            else
              _buildEmptyProducts(),
          ],
        ),
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: products.length,
      itemBuilder: (context, index) {
        final product = products[index];
        return GestureDetector(
          onTap: () {
            showManualOrDriver(context);
          },
          child: Column(
            children: [
              Container(
                margin: const EdgeInsets.only(top: 10),
                width: 288,
                height: 300,
                color: Color(0xff000915),
                child: ClipRRect(
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(8), topRight: Radius.circular(8)),
                  child: Image.asset(
                    product.photoUrl,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Container(
                alignment: Alignment.center,
                width: 288,
                height: 55,
                decoration: BoxDecoration(
                  color: Color(0xffA49930),
                  borderRadius: const BorderRadius.only(
                    bottomRight: Radius.circular(35),
                  ),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(left: 3),
                      alignment: Alignment.topLeft,
                      child: Text(
                        product.description,
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(left: 3),
                      alignment: Alignment.centerLeft,
                      child: Text(
                        'N ${product.numSerie}',
                        style: TextStyle(
                          color: Colors.black,
                          fontFamily: 'Rubik',
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        showConfirmationDialog(context);
                      },
                      child: Container(
                        margin: const EdgeInsets.only(left: 3),
                        alignment: Alignment.bottomLeft,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 20),
                          margin: EdgeInsets.only(right: 150),
                          decoration: BoxDecoration(
                            color: Colors.black,
                            borderRadius: const BorderRadius.only(
                              bottomRight: Radius.circular(35),
                            ),
                          ),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              product.garantia,
                              style: TextStyle(
                                color: Color(0xffA49930),
                                fontFamily: 'Rubik',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyProducts() {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 100, left: 100, right: 100),
          alignment: Alignment.center,
          child: Image.asset(
            'assets/images/empityProducts.png',
            height: 200,
            width: 200,
          ),
        ),
        Text(
          'Nenhum produto encontrado',
          style: TextStyle(
            color: Color(0xffA49930),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  //Função para mostrar o texto de garantia ao usuário
  void showConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Termo de Garantia'),
          content: Text(
              'Aqui estão algumas informações importantes para ajudá-lo a entender melhor como a Garantia Shopee protege sua compra e como você pode solicitar o reembolso, caso haja algum contratempo com seu pedido. A Garantia Shopee assegura o recebimento e qualidade dos produtos que comprou, tornando mais fácil para você solicitar um reembolso em caso de inconvenientes. Esse processo certifica que o valor pago por você, em qualquer compra feita na nossa plataforma, seja creditado ao vendedor após 7 dias do recebimento do produto. É importante lembrar que para pedidos que ainda não foram encaminhados, os vendedores devem enviá-los dentro do período de Garantia Shopee. Caso contrário, o pagamento será automaticamente reembolsado a você após o término do prazo. Além disso, você pode usar uma extensão única de 3 dias da Garantia Shopee para um pedido que ainda não foi enviado. Para fazer isso, selecione Estender Garantia Shopee na página Detalhes do pedido.'),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 111, 223, 20),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(true); // Fecha a caixa de diálogo e retorna true
                },
                child: Text('Confirmar',
                style: TextStyle(color: Colors.white)
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 236, 52, 5),
                borderRadius: BorderRadius.circular(4),
              ),
              child:TextButton(
                onPressed: () {
                  Navigator.of(context)
                      .pop(false); // Fecha a caixa de diálogo e retorna false
                },
                child: Text('Negar',
                style: TextStyle(color: Colors.white)
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  void showManualOrDriver(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Selecione abaixo o recurso desejado :)'),
          actions: [
            Container(
              decoration: BoxDecoration(
                color: Color(0xffA49930),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextButton(
                onPressed: () {
                  _launchManual();
                },
                child: Text(
                  'Manual',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                color: Color(0xffA49930),
                borderRadius: BorderRadius.circular(4),
              ),
              child: TextButton(
                onPressed: () {
                  _launchDriver();
                },
                child: Text(
                  'Atualização dos Drivers',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchManual() async {
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  Future<void> _launchDriver() async {
    if (await canLaunch(_urlDriver)) {
      await launch(_urlDriver);
    } else {
      throw 'Não foi possível abrir o arquivo PDF';
    }
  }
}
