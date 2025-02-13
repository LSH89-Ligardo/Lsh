import 'package:test_example/test_dart_sample.dart';
import 'package:test/test.dart';

void main() {
  // 'Travel Distance' 테스트 케이스 정의
  test('Travel Distance', () {
    // Arrange
    var distance = 10.0;
    var expectedDistance = distance;

    // Act
    var travel = Travel(distance);
    var result = travel.distance;

    // Assert
    expect(result, expectedDistance);
  });

  // 'Travel Distance to Miles' 테스트 케이스 정의
  test('Travel Distance to Miles', () {
    // Arrange
    var distance = 10.0;
    var expectedDistanceInMiles = distance * convertToMiles;

    // Act
    var travel = Travel(distance);
    var result = travel.distanceToMiles();

    // Assert
    expect(result, expectedDistanceInMiles);
  });

  // 'Travel Distance to Kilometers' 테스트 케이스 정의
  test('Travel Distance to Kilometers', () {
    // Arrange
    var distance = 10.0;
    var expectedDistanceInKilometers = distance * convertToKilometers;

    // Act
    var travel = Travel(distance);
    var result = travel.distanceToKilometers();

    // Assert
    expect(result, expectedDistanceInKilometers);
  });
}
