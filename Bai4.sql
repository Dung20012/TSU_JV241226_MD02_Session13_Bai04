-- Thiết kế cơ sở dữ liệu

-- Tạo database
CREATE database library_management;
USE library_management; 

-- Bảng book
create table Books(
	bookId int auto_increment primary key,
    title varchar(100) NOT NULL UNIQUE,
    author varchar(50) NOT NULL,
    publishedYear YEAR NOT NULL,
    category varchar(50) NOT NULL
);
INSERT INTO Book (title, author, publishedYear, category) VALUES
('A Journey Through Time', 'Nguyễn Văn A', 2015, 'Khoa học'),
('Biển Cả Mênh Mông', 'Trần Thị B', 2018, 'Thiên nhiên'),
('Cây Đời Mãi Xanh', 'Lê Văn C', 2020, 'Tiểu thuyết'),
('Dưới Bóng Cây Xưa', 'Phạm Thị D', 2017, 'Lịch sử'),
('Ech Nhảy Qua Bờ Ao', 'Đặng Văn E', 2021, 'Truyện thiếu nhi'),
('Bí Mật Rừng Già', 'Nguyễn Thị F', 2016, 'Phiêu lưu'),
('Ánh Sáng Cuối Đường', 'Trương Văn G', 2019, 'Kỹ năng sống'),
('Hành Trình Vô Tận', 'Hoàng Minh H', 2022, 'Khoa học viễn tưởng'),
('Anh Và Em', 'Phan Thị I', 2014, 'Tình cảm'),
('Bầu Trời Đêm', 'Ngô Văn J', 2023, 'Thiên văn học');

-- Bảng readers
create table Readers(
	readerId int auto_increment primary key,
    name varchar(50) NOT NULL,
    birthDate DATE NOT NULL,
    address varchar(255),
    phoneNumber varchar(11)
);
INSERT INTO Readers (name, birthDate, address, phoneNumber) VALUES
('Nguyễn Văn An', '1992-05-10', 'Hà Nội', '0912345678'),
('Trần Thị Bích', '1998-09-23', 'Hồ Chí Minh', '0987654321'),
('Lê Văn Cường', '1985-11-15', 'Đà Nẵng', '0901234567'),
('Phạm Thị Dung', '1970-03-30', 'Cần Thơ', '0934567890'),
('Hoàng Minh Đức', '1995-07-07', 'Huế', '0977778888'),
('Đặng Thị Hạnh', '1965-12-12', 'Hà Nam', '0922334455'),
('Ngô Văn Hưng', '2000-01-01', 'Nam Định', '0965432109'),
('Bùi Thị Lan', '1990-06-18', 'Bắc Ninh', '0943217890'),
('Phan Văn Long', '2001-08-09', 'Nghệ An', '0956789012'),
('Vũ Thị Mai', '1950-02-14', 'Quảng Nam', '0911223344');
-- Cập nhật name thêm "genZ" cho các độc giả có năm sinh 1990-2000
UPDATE Readers
SET name = CONCAT(name, ' genz')
WHERE readerId = 5;
-- concat(name, ' genZ') nối " genZ" vào cuối tên

-- Truy vấn lấy all thông tin độc giả có năm sinh nhỏ hơn 1975
SELECT * FROM Readers
WHERE YEAR(birthDate) < 1975;

-- Năm sinh nhỏ hơn hiện tại
DELIMITER $$
create trigger check_birth_date_before_insert
before insert on Readers
for each row
begin
	if YEAR(new.birthDate) >= YEAR(CURDATE()) then
		signal sqlstate '45000'
        set message_text = 'Năm sinh phải nhỏ hơn năm hiện tại';
	end if;
end$$

-- Bảng borrows
DROP TABLE IF EXISTS Borrows;
create table Borrows(
	borrowId int auto_increment primary key,
    borrowDate DATE NOT NULL,
    returnDate DATE,
    bookId int,
    readerId int,
    FOREIGN KEY(bookId) REFERENCES book(bookId),
    FOREIGN KEY(readerId) REFERENCES readers(readerId)
);
