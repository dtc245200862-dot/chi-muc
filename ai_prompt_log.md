# AI Prompt Log - QuickFeed Index Optimization

## Prompt 1 - Cardinality
Trong MySQL, Cardinality là gì và tại sao cột chỉ có 2 hoặc 3 giá trị thường không phù hợp để tạo B-Tree Index?

## Kết quả tìm hiểu
Cardinality thể hiện mức độ đa dạng của giá trị trong một cột. Nếu một cột chỉ có rất ít giá trị, ví dụ is_visible chỉ có 0 và 1, Index có thể không giúp giảm đủ số dòng cần đọc. Khi đó MySQL có thể chọn Full Table Scan vì cách này có chi phí thấp hơn.

## Prompt 2 - TEXT Index
Nếu tạo B-Tree Index trên cột TEXT bằng prefix 255 thì có vấn đề gì?

## Kết quả tìm hiểu
Index trên TEXT có thể chiếm thêm Disk và RAM, đồng thời phải được cập nhật khi dữ liệu thay đổi. Nếu mục tiêu là tìm kiếm từ khóa trong nội dung, FULLTEXT thường phù hợp hơn B-Tree Index thông thường.

## Prompt 3 - Read và Write
Tại sao nhiều Index làm INSERT chậm?

## Kết quả tìm hiểu
Khi INSERT, MySQL phải ghi dữ liệu và cập nhật các Index liên quan. Vì vậy thêm Index có thể cải thiện một số truy vấn đọc nhưng làm tăng chi phí ghi và bảo trì.

## Prompt 4 - Storage
Làm thế nào kiểm tra dung lượng Data và Index của bảng Posts?

## Kết quả tìm hiểu
Có thể truy vấn information_schema.TABLES và chuyển DATA_LENGTH, INDEX_LENGTH từ byte sang MB bằng cách chia cho 1024 * 1024.
