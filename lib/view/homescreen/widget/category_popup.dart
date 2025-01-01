import 'package:flutter/material.dart';

class CategoryPopup extends StatelessWidget {
  const CategoryPopup({super.key});

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get screen width and height
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Determine screen type based on width
    bool isMobile = screenWidth < 600;
    bool isTablet = screenWidth >= 600 && screenWidth < 1024;
    bool isDesktop = screenWidth >= 1024;
    List<Map> categories = [
      {
        "name": "Curry Powders",
        "image":
            "https://res.cloudinary.com/hz3gmuqw6/image/upload/c_fill,q_auto,w_750/f_auto/curry-powder-substitute-phpDKXwxs"
      },
      {
        "name": "Fruits",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQMkBbQ_DxYAZu4rfOP4BgYo9NPektkMPob7Q&s"
      },
      {
        "name": "Fruit & Vegetables",
        "image":
            "https://www.utphysicians.com/wp-content/uploads/2022/02/fruits-and-vegetables-rainbow.jpg"
      },
      {
        "name": "Fish & Meats",
        "image": "https://static.toiimg.com/photo/101288661.cms"
      },
      {
        "name": "Dairy Products",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRUovqC7FkLgtVoa9JAZ7BNoTwClclPn2YAJw&s"
      },
      {
        "name": "Rice, Atta & Flours",
        "image":
            "https://2.wlimg.com/product_images/bc-full/2023/3/664688/white-rice-flour-1678870310-6803650.jpeg"
      },
      {
        "name": "Lentils & Pulses",
        "image":
            "https://www.healthifyme.com/blog/wp-content/uploads/2022/05/shutterstock_465983162-1-1024x682.jpg"
      },
      {
        "name": "Oil & Ghee",
        "image": "https://static.toiimg.com/photo/84068085.cms"
      },
      {
        "name": "Frozen Foods",
        "image":
            "https://static.toiimg.com/thumb/resizemode-4,width-1280,height-720,msid-77315077/77315077.jpg"
      },
      {
        "name": "Ready to Eat",
        "image":
            "https://5.imimg.com/data5/SELLER/Default/2023/12/368589178/UI/QM/XC/26500564/img-6053.jpeg"
      },
      {
        "name": "Beverages",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTmrVyLmaUXJyc4aDTSFlqzdIUlgSNB92_HbQ&s"
      },
      {
        "name": "Home & Kitchen",
        "image":
            "https://www.helpguide.org/wp-content/uploads/2023/02/Cooking-at-Home-1200x800.jpeg"
      },
      {
        "name": "Deli",
        "image":
            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoJBBOqoVKwwhSEMDkuOWGFU1wiCAStZZBzA&s"
      },
    ];
    return PopupMenuButton<int>(
      child: Row(
        children: [
          Text(
            "Browse Category",
            style: TextStyle(
                fontSize: isDesktop ? 16 : 18,
                color: Colors.green,
                fontWeight: FontWeight.bold),
          ),
          Icon(
            Icons.keyboard_arrow_down,
            color: Colors.green,
          ),
        ],
      ),
      onSelected: (value) {
        // Navigate to the corresponding category page
        final selectedCategory = categories[value];
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => ShopbycategoryScreen(),
        //   ),
        // );
      },
      itemBuilder: (context) {
        return List.generate(
          categories.length,
          (index) => PopupMenuItem(
            value: index, // Pass the index as the value
            child: Row(
              children: [
                CircleAvatar(
                  radius: 15,
                  backgroundImage: NetworkImage(categories[index]["image"]),
                ),
                SizedBox(width: 10),
                Text(
                  categories[index]["name"],
                  style: TextStyle(
                      color: Colors.grey, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        );
      },
      offset: Offset(0, 50), // Adjusts the popup position
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}
