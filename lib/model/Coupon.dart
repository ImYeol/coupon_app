class Coupon {
  String image;
  String name;
  String description;
  int type;
  int count;

  static final int RELEASEABLE_COUPON = 0;
  static final int MY_COUPON = 1;

  Coupon(
      {this.image,
      this.name,
      this.description = " ",
      this.type = 0,
      this.count = 0});

  @override
  String toString() {
    // TODO: implement toString
    return this.image +
        " " +
        this.name +
        " " +
        this.description +
        " " +
        this.count.toString();
  }
}
