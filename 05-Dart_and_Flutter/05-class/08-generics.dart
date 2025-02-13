class DataStorage<T> {
  // 제네릭 타입의 리스트를 선언
  List<T> _items = [];

  // 리스트에 아이템을 추가하는 메소드
  void addItem(T item) {
    _items.add(item);
  }

  // 리스트의 아이템을 제거
  void removeItem(T item) {
    _items.remove(item);
  }

  // 리스트의 아이템을 출력: null safety를 위해 ?를 사용
  T? getItem(int index) {
    if (index < _items.length) {
      return _items[index];
    }
    return null;
  }

  // 리스트의 모든 아이템을 출력: 리스트를 복사해서 반환
  List<T> getAllItems() => List.from(_items);

  // 리스트의 길이를 반환
  int get length => _items.length;

  // 리스트를 모두 삭제
  void clear() {
    _items.clear();
  }
}

void main() {
  // DataStorage 클래스의 인스턴스를 생성
  var names = DataStorage<String>();
  names.addItem('John');
  names.addItem('Doe');
  names.addItem('Smith');
  names.removeItem('Doe');
  print(names.getAllItems());

  var numbers = DataStorage<int>();
  numbers.addItem(1);
  numbers.addItem(2);
  numbers.addItem(3);
  numbers.removeItem(2);
  print(numbers.getAllItems());

  // dynamic 타입을 사용하면 모든 타입을 저장할 수 있지만, 타입 안정성이 떨어진다.
  var dynamicData = DataStorage<dynamic>();
  dynamicData.addItem('John');
  dynamicData.addItem(1);
  dynamicData.addItem(2.0);
  dynamicData.addItem(true);
  print(dynamicData.getAllItems());
}
