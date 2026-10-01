# AI Prompt Log

## Prompt 1: Covering Index

Covering Index trong MySQL là gì? Tại sao Covering Index có thể làm truy vấn SELECT nhanh hơn?

### Nội dung tra cứu

Covering Index là Index chứa tất cả các cột mà một truy vấn cần sử dụng. Khi đó MySQL có thể lấy dữ liệu trực tiếp từ Index mà không cần truy cập thêm vào bảng dữ liệu gốc.

Ưu điểm là giảm thao tác đọc bảng và có thể làm SELECT nhanh hơn.

Nhược điểm là Index phải chứa nhiều dữ liệu hơn, làm tăng dung lượng lưu trữ và chi phí cập nhật khi INSERT, UPDATE hoặc DELETE.

## Prompt 2: Clustered Index và Secondary Index

Trong MySQL InnoDB, Clustered Index và Secondary Index hoạt động như thế nào?

### Nội dung tra cứu

Trong InnoDB, Primary Key được sử dụng làm Clustered Index. Dữ liệu của bảng được lưu cùng với cấu trúc của Primary Key.

Secondary Index là các Index khác Primary Key. Các Secondary Index lưu giá trị của những cột được lập Index và chứa giá trị Primary Key để MySQL có thể tìm đến bản ghi tương ứng trong Clustered Index.

Vì vậy, khi Secondary Index có nhiều cột, kích thước Index sẽ tăng và các thao tác ghi cũng phải cập nhật nhiều dữ liệu hơn.

## Prompt 3: Write Penalty

Write Penalty của Index là gì? Tại sao thêm nhiều cột vào Index có thể làm INSERT chậm?

### Nội dung tra cứu

Khi thêm dữ liệu mới vào bảng, MySQL không chỉ ghi dữ liệu vào bảng mà còn phải cập nhật những Index liên quan.

Index càng lớn hoặc càng có nhiều cột thì lượng dữ liệu cần cập nhật càng nhiều. Với hệ thống có hàng chục nghìn bản ghi mới mỗi giây, chi phí này có thể trở thành nút thắt cổ chai.

Do đó, Index nên được thiết kế vừa đủ cho các truy vấn quan trọng thay vì đưa quá nhiều cột vào Index.

## Prompt 4: Đánh đổi trong bài SmartFactory

Tại sao bài toán SmartFactory nên sử dụng `idx_lean_search(sensor_id, recorded_at)` thay vì Covering Index chứa tất cả các cột?

### Nội dung tra cứu

SmartFactory có lượng INSERT rất lớn do dữ liệu được gửi liên tục từ các cảm biến. Vì vậy cần ưu tiên giảm kích thước Index và giảm chi phí cập nhật Index.

`idx_lean_search(sensor_id, recorded_at)` vẫn hỗ trợ MySQL tìm nhanh các bản ghi theo cảm biến và thời gian. Sau đó MySQL có thể đọc `temperature`, `humidity` và `status` từ bảng gốc.

Giải pháp này chấp nhận một phần chi phí đọc thêm để đổi lấy Index nhỏ hơn, INSERT nhẹ hơn và tiết kiệm không gian lưu trữ.

## Prompt 5: Covering Index có phải lúc nào cũng xấu?

Nếu bảng dữ liệu ít thay đổi như bảng Countries thì Covering Index có còn phù hợp không?

### Nội dung tra cứu

Không phải lúc nào Covering Index cũng là lựa chọn xấu. Với bảng ít thay đổi nhưng có nhiều truy vấn SELECT, chi phí cập nhật Index thấp.

Trong trường hợp đó, việc sử dụng Covering Index có thể giúp giảm thao tác đọc bảng và cải thiện hiệu năng SELECT.

Điểm quan trọng là phải dựa vào đặc điểm thực tế của hệ thống: tần suất đọc, tần suất ghi, kích thước dữ liệu và dung lượng lưu trữ.
