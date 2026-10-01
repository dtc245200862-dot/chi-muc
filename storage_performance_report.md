# Báo cáo tối ưu Index QuickFeed

## 1. Chẩn đoán

Bảng Posts ban đầu có 5 Index gồm idx_user_id, idx_content, idx_post_type, idx_is_visible và idx_created_at. Khi INSERT một bài viết, MySQL không chỉ ghi dữ liệu vào bảng mà còn phải cập nhật các cấu trúc B-Tree của những Index liên quan. Vì vậy càng nhiều Index thì chi phí ghi và cập nhật càng cao.

## 2. Đánh giá Index

- idx_user_id: Giữ lại vì user_id thường được dùng để lấy bài viết của một người dùng.
- idx_content: Xóa vì content là TEXT và Index prefix 255 có thể làm tăng đáng kể dung lượng lưu trữ. Nếu cần tìm kiếm nội dung nên xem xét FULLTEXT.
- idx_post_type: Xóa vì chỉ có khoảng 3 giá trị TEXT, IMAGE và VIDEO nên độ phân biệt thấp.
- idx_is_visible: Xóa vì chỉ có 2 giá trị 0 và 1. Với dữ liệu có độ phân biệt thấp, MySQL có thể chọn Full Table Scan thay vì dùng Index.
- idx_created_at: Giữ lại vì hỗ trợ truy vấn và sắp xếp bài viết theo thời gian.

## 3. Đo lường

Trước và sau khi tối ưu, dùng information_schema.TABLES để xem DATA_LENGTH và INDEX_LENGTH theo MB. Số liệu thực tế phụ thuộc vào lượng dữ liệu đang có trong máy.

## 4. Kết luận

Sau khi bỏ 3 Index không cần thiết, hệ thống giảm số cấu trúc B-Tree phải duy trì khi INSERT. Điều này giảm chi phí Write và giải phóng một phần RAM/Disk dùng cho Index. Đổi lại, một số truy vấn dựa trên các Index đã xóa có thể phải quét nhiều dòng hơn. Đây là sự đánh đổi giữa tốc độ Read và Write cần được cân nhắc theo workload thực tế.
