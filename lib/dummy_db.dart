import 'package:flutter/material.dart';

class DummyDb {
  static List<Map> items = [
    {
      "offer": "Top Offers",
      "color": Colors.orange,
      "image":
          "https://www.healthyfood.com/wp-content/uploads/2017/03/How-to-choose-fruit-juices-and-drinks.jpg"
    },
    {
      "offer": "Weekly Best Seller",
      "color": Colors.green,
      "image":
          "https://www.farmersstop.com/cdn/shop/products/capsicum-yellow-1-510x510_510x510.jpg?v=1710229575"
    },
    {
      "offer": "Top Offer",
      "color": Colors.red,
      "image":
          "https://driscolls.imgix.net/-/media/images/pages/berries/strawberry/strawberryproductdetailpage_compressedjpeg-item-v-600113491.ashx"
    },
  ];

  static List<Map> products = [
    {
      "name": "Mutton",
      "rate": "\$13.52",
      "image":
          "https://frugivore-bucket.s3.amazonaws.com/media/package/img_one/2023-11-01/mutton_500g__1kg_b4adMcT.jpg"
    },
    {
      "name": "Seabream",
      "rate": "\$12.29",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTlIZPGc2oAuRsxHlasXdDiq-ZTVYJHs0bHAg&s"
    },
    {
      "name": "Seabas",
      "rate": "\$12.29",
      "image": "https://thumbs.dreamstime.com/b/sea-bass-16517021.jpg"
    },
  ];
  static List<Map> bestseller = [
    {
      "name": "Sambar Powder",
      "rate": "\$3.69",
      "image":
          "https://5.imimg.com/data5/SELLER/Default/2023/5/308434509/YI/IH/HR/46063010/kitchen-treasures-sambar-powder.jpeg"
    },
    {
      "name": "Rasam Powder",
      "rate": "\$4.92",
      "image":
          "https://rukminim2.flixcart.com/image/720/864/l1v1uvk0/spice-masala/h/i/4/100-rasam-powder-1-pouch-kitchen-treasures-powder-original-imagdbzfk4yjd9zm.jpeg?q=60&crop=false"
    },
    {
      "name": "Fish Curry Powder",
      "rate": "\$3.08",
      "image":
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcThZoVGhMjNZtn5qNsap7QgDmtFf3k3EA1BkA&s"
    },
  ];
  static List clientsimage = [
    "assets/png/client1.png",
    "assets/png/client-2.png",
    "assets/png/client3.png",
    "assets/png/client4.png",
    "assets/png/client5.png",
  ];

  static List<Map> draweritems = [
    {
      "name": "Curry Powders",
      "image":
          "https://www.mashed.com/img/gallery/what-is-curry-powder-and-what-does-it-taste-like/l-intro-1623339855.jpg"
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
          "https://www.viralspices.com/wp-content/uploads/2018/07/pulses-and-lentils.jpg"
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

  //about us page
  static List<Map> abilityDetails = [
    {
      "url": "assets/png/icon-1_new.png",
      "title": "0k+",
      "subtitle": "Total Products"
    },
    {
      "url": "assets/png/icon-2_new.png",
      "title": "0k+",
      "subtitle": "Total Orders"
    },
    {
      "url": "assets/png/icon-3_new.png",
      "title": "0k+",
      "subtitle": "Total Visitors"
    },
    {
      "url": "assets/png/icon-4_new.png",
      "title": "0k+",
      "subtitle": "Total Delivery"
    },
  ];
  static List<Map> ceolist = [
    {
      "url": "assets/png/team-2_new.jpg",
      "name": "Frances Gilmartin",
      "desig": "CEO & Founder"
    },
    {
      "url": "assets/png/team-1_new.jpg",
      "name": "Frances Gilmartin",
      "desig": "CEO & Founder"
    },
    {
      "url": "assets/png/team-2_new.jpg",
      "name": "Frances Gilmartin",
      "desig": "CEO & Founder"
    },
    {
      "url": "assets/png/team-1_new.jpg",
      "name": "Frances Gilmartin",
      "desig": "CEO & Founder"
    },
  ];

  static List<Map> gridDetails = [
    {
      "title": "Trusted Partner",
      "desc":
          "Compellingly fashion intermandat opportunities e-business fashion intermandated business."
    },
    {
      "title": "Return Policy",
      "desc":
          "Compellingly fashion intermandat opportunities e-business fashion intermandated business."
    },
    {
      "title": "100% Organic Fresh",
      "desc":
          "Compellingly fashion intermandat opportunities e-business fashion intermandated business."
    },
    {
      "title": "Secured Payment",
      "desc":
          "Compellingly fashion intermandat opportunities e-business fashion intermandated business."
    },
  ];
}
