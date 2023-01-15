import 'dart:math';

List<String> profileUrls = [
  'https://th.bing.com/th/id/R.85a302fcf420a45bad04ec2b0c8f0a2c?rik=dBQavr45KUVVTQ&pid=ImgRaw&r=0&sres=1&sresct=1',
  'https://th.bing.com/th/id/R.f67c93a733e0a6fc41b36bd8098c72b6?rik=1JDhNuCoHGSjFA&pid=ImgRaw&r=0',
  'https://th.bing.com/th/id/R.fe9143350d8d892b41d2344dbf086cbd?rik=Kfrw1%2f3eTkFg8Q&pid=ImgRaw&r=0',
  'https://th.bing.com/th/id/OIP.T1RPs1gh9Ii-XrEFJ0nX4AHaEt?pid=ImgDet&rs=1',
  'https://images.unsplash.com/photo-1529665253569-6d01c0eaf7b6?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80',
];
String getRandomImageUrl() {
  var random = Random().nextInt(4);
  return profileUrls[random];
}
