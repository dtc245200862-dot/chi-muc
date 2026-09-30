# Hướng dẫn thực hành: Tạo chỉ mục (Index) trong MySQL

Bài tập này hướng dẫn cách sử dụng Index trong MySQL để tăng tốc độ truy vấn cơ sở dữ liệu dựa trên nội dung bài học.

---

## Các bước thực hiện

### 1. Tải cơ sở dữ liệu mẫu
- Download cơ sở dữ liệu mẫu `classicmodels` từ trang chủ MySQL Tutorials hoặc sử dụng sẵn có theo yêu cầu của bài.
- Import database này vào hệ quản trị cơ sở dữ liệu MySQL của bạn.

### 2. Khảo sát tốc độ trước khi đánh Index
Sử dụng câu lệnh `EXPLAIN` để kiểm tra cách MySQL thực thi truy vấn:
```sql
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
```
* **Kết quả:** Ở cột `type`, bạn sẽ thấy giá trị là `ALL` (hoặc không có `possible_keys`), nghĩa là MySQL phải duyệt qua toàn bộ số lượng bản ghi (hơn 17.000 dòng) rất chậm.

### 3. Tạo Index cho một trường (Field)
Thêm chỉ mục cho cột `customerName` để tăng tốc độ tìm kiếm:
```sql
ALTER TABLE customers ADD INDEX idx_customerName(customerName);
```
Kiểm tra lại bằng lệnh `EXPLAIN`:
```sql
EXPLAIN SELECT * FROM customers WHERE customerName = 'Land of Toys Inc.';
```
* **Kết quả:** Kiểu truy vấn chuyển thành `ref`, số lượng hàng cần duyệt (`rows`) giảm xuống còn `1`, giúp truy vấn nhanh hơn rất nhiều.

### 4. Tạo Index kết hợp (nhiều cột)
Nếu muốn tạo Index cho các cột có thể chứa nhiều kết quả truy vấn, bạn có thể tạo index theo cặp:
```sql
ALTER TABLE customers ADD INDEX idx_full_name(contactFirstName, contactLastName);
```

### 5. Xóa Index
Khi không cần sử dụng chỉ mục nữa, bạn có thể xóa nó bằng câu lệnh:
```sql
ALTER TABLE customers DROP INDEX idx_full_name;
```

---

## Hướng dẫn nộp bài
1. Tham khảo mã nguồn mẫu tại [GitHub CodeGym](https://github.com/codegym-vn/jwbd-2023-using-index).
2. Đưa bài tập của bạn lên kho lưu trữ GitHub cá nhân.
3. Dán đường link GitHub vào mục nộp bài trên hệ thống CodeGym để hoàn thành.