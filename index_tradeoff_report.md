# Báo cáo tối ưu hóa Index cho hệ thống SmartFactory

## 1. Phân tích vấn đề

Index cũ `idx_fat_covering` gồm 5 cột: `sensor_id`, `recorded_at`, `temperature`, `humidity` và `status`. Index này giúp truy vấn Dashboard nhanh vì các dữ liệu cần SELECT đều nằm trong Index. MySQL có thể sử dụng Covering Index mà không cần đọc thêm bảng gốc.

Tuy nhiên, SmartFactory là hệ thống có lưu lượng ghi rất lớn. Các cảm biến liên tục gửi dữ liệu mới nên mỗi lần INSERT, MySQL phải cập nhật thêm Index. Index càng nhiều cột thì kích thước càng lớn và chi phí cập nhật càng cao. Điều này làm tăng Write Penalty và sử dụng nhiều RAM cũng như ổ đĩa.

## 2. Giải pháp

Thay Index cũ bằng Index tinh gọn:

`idx_lean_search(sensor_id, recorded_at)`

Hai cột này là các cột được sử dụng để lọc dữ liệu trong mệnh đề WHERE. Các cột `temperature`, `humidity` và `status` không cần đưa vào Index vì chúng chỉ được lấy ra sau khi tìm được các bản ghi phù hợp.

## 3. Đánh đổi

Sau khi bỏ Covering Index, truy vấn SELECT có thể chậm hơn một phần nhỏ vì MySQL phải tìm bản ghi bằng Index rồi đọc dữ liệu từ bảng gốc. Trong EXPLAIN, truy vấn vẫn sử dụng `idx_lean_search`, nhưng Extra sẽ không còn `Using index`.

Đổi lại, Index mới nhỏ hơn đáng kể, giảm lượng dữ liệu phải lưu trữ và giảm chi phí cập nhật khi INSERT. Đây là lựa chọn phù hợp hơn với hệ thống IoT có tốc độ ghi rất cao.

## 4. Kết luận

Giải pháp không cố gắng tối ưu SELECT bằng mọi giá mà cân bằng giữa tốc độ đọc, tốc độ ghi và dung lượng lưu trữ. Với SmartFactory, việc sử dụng Lean Index gồm `sensor_id` và `recorded_at` giúp hệ thống giảm Write Penalty và sử dụng tài nguyên hiệu quả hơn.
