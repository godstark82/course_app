// ignore_for_file: avoid_print

List<int> nums1 = [1, 2, 3, 4, 5, 6];
List<int> nums2 = [7, 8, 9, 10, 11, 12];

void main() {
  nums1.addAll(nums2);
  nums1.sort((a, b) => nums1[a].compareTo(nums2[b]));
  print(nums1);
}
