abstract class Shape {
  double getArea();
  double getPerimerter();
  void draw();
}

class Circle implements Shape {
  double radius;

  Circle(this.radius);

  @override
  double getArea() {
    return 3.14 * radius * radius;
  }

  @override
  double getPerimerter() {
    return 2 * 3.14 * radius;
  }

  @override
  void draw() {
    print('Drawing Circle');
  }
}

class Rectangle implements Shape {
  double width;
  double height;

  Rectangle(this.width, this.height);

  @override
  double getArea() {
    return width * height;
  }

  @override
  double getPerimerter() {
    return 2 * (width + height);
  }

  @override
  void draw() {
    print('Drawing Rectangle');
  }
}
