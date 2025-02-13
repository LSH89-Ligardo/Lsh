const convertToKilometers = 1.60934; // 1 mile = 1.60934 km 마일을 킬로미터로 변환
const convertToMiles = 0.62137119; // 1 km = 0.62137119 mile 킬로미터를 마일로 변환

class Travel {
  late double distance;

  Travel(this.distance);

  double distanceToMiles() {
    return distance * convertToMiles;
  }

  double distanceToKilometers() {
    return distance * convertToKilometers;
  }
}
