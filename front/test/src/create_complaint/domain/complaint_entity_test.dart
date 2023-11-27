import 'package:test/test.dart';
import 'package:mc426_front/create_complaint/domain/entities/complaint.dart';

void main() {
  group("to_map", () {
    test("should return a map json", () async {
      final mockComplaint = Complaint(
        title: 'Test Title',
        description: 'Test Description',
        address: 'Test Address',
        isAnonymous: false,
      );

      final result = mockComplaint.toMap();

      expect(result["title"], "Test Title");
      expect(result["description"], "Test Description");
      expect(result["address"], "Test Address");
      expect(result["isAnonymous"], false);
    });
  });

  group("from_map", () {
    test("should return a Complaint object from a map", () async {
      final map = {
        'title': 'Test Title',
        'description': 'Test Description',
        'address': 'Test Address',
        'isAnonymous': false,
      };

      final result = Complaint.fromMap(map);

      expect(result.title, "Test Title");
      expect(result.description, "Test Description");
      expect(result.address, "Test Address");
      expect(result.isAnonymous, false);
    });
  });
}
