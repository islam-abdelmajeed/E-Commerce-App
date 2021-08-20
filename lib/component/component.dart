import 'package:e_commerce_app/component/constant.dart';
import 'package:e_commerce_app/models/product_model.dart';
import 'package:e_commerce_app/modules/product_info/product_info_screen.dart';
import 'package:flutter/material.dart';

Widget customTextField({
  @required String hint,
   IconData icon,
   Function validate,
  Function onClick,
  bool isPassword = false,
  double radius = 20.0,
}) =>
    Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: TextFormField(
        validator: validate,
        obscureText: isPassword,
        onSaved:onClick ,
        cursorColor: kMainColor,
        cursorWidth: 3,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: kMainColor,
          ),
          hintText: hint,
          filled: true,
          fillColor: kSecondaryColor,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.white,
            ),
            borderRadius: BorderRadius.circular(radius),
          ),
        ),
      ),
    );

Widget customButton({
  @required String text,
  @required Function function,
  Color color = Colors.black,
  Color textColor = Colors.white,
  double radius = 20.0,
}) =>
    MaterialButton(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(radius),
      ),
      onPressed: function,
      child: Text(
        text.toUpperCase(),
        style: TextStyle(
          color: textColor,
          fontWeight: FontWeight.bold
        ),
      ),
    );

void navigateTo({
  @required context,
  @required widget,
}) =>
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

void navigateAndRemove({@required context, @required widget}) =>
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => widget), (route) => false);

Widget productView(String category, List allProduct) {
  List<ProductModel> products = [];
  products = getProductCategory(category ,allProduct);
  return GridView.builder(
    physics: BouncingScrollPhysics(),
    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
    ),
    itemBuilder: (context, index) => Center(
      child: Padding(
        padding: const EdgeInsets.all(5.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProductInfoScreen.id,
                arguments: products[index]);
          },
          onTapUp: (details) {
            double dx = details.globalPosition.dx;
            double dy = details.globalPosition.dy;
            double dx2 = MediaQuery.of(context).size.width - dx;
            double dy2 = MediaQuery.of(context).size.height - dy;
            showMenu(
              context: context,
              position: RelativeRect.fromLTRB(dx, dy, dx2, dy2),
              items: [],
            );
          },
          child: Stack(
            children: [
              Positioned.fill(
                child: Image(
                  image: NetworkImage(
                    products[index].pLocation,
                  ),
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.1,
                  color: Colors.white.withOpacity(0.7),
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10.0, vertical: 5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${products[index].pName}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          '\$ ${products[index].pPrice}',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    itemCount: products.length,
  );
}

List<ProductModel> getProductCategory(String category,List<ProductModel> allProducts) {
  List<ProductModel> products = [];
  try{
  for (var product in allProducts) {
    if (product.pCategory == category) {
      products.add(product);
    }
  }}on Error catch(ex){
  print(ex);
  }
  return products;
}
