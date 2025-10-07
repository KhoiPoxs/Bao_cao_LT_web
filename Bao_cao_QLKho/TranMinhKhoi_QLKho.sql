Create database QLkho
go

use QLkho
go

Create table Sanpham
(
	masp Varchar(10) not null unique,
	tensp Nvarchar(50) not null,
	phanloai Nvarchar(50) not null,
	mota Nvarchar(1000),
	soluong Int not null check(soluong>=0),
	gia Money not null check(gia>=0),
	Ngaynhap Datetime not null,
	Ngayxuat Datetime,
		Constraint pk_sanpham primary key (masp),
)
go

Create table Nguoidung
(
	manv Varchar(10)not null unique,
	hoten Nvarchar(50)not null,
	gioitinh int not null check(gioitinh=0 or gioitinh=1),	--0: Nam, 1: Nu
	ngaysinh date not null,
	email Varchar(50),
	sdt Varchar(50),
	diachi Nvarchar(200),
	taikhoan Varchar(30) not null unique,
	matkhau Varchar(20) not null,
	vitri Nvarchar(20) not null,	--vi tri: Giam doc, quan ly, ke toan,...
		Constraint pk_Nguoidung primary key (manv,taikhoan)
)
go

Alter table Nguoidung
	Add constraint ck_Nguoidung_ngaysinh check(year(getdate()) - year(ngaysinh) >=18)
go

Create table Nhacungcap	--Ben cung cap hang nhap kho
(
	mancc Varchar(10) not null unique,
	tenncc Nvarchar(50) not null,
	diachincc Nvarchar(200),
	thongtinlhncc Nvarchar(200),
	trangthaincc int not null check(trangthaincc=0 or trangthaincc=1), --0: Ngung hop tac, 1: Dang hop tac

	Constraint pk_Nhacungcap primary key(mancc)
)
go

Create table Khachhang	--Ben nhan hang xuat kho
(
	makh Varchar(10) not null unique,
	tenkh Nvarchar(50) not null,
	diachikh Nvarchar(200),
	thongtinlhkh Nvarchar(200),
	trangthaikh int not null check(trangthaikh=0 or trangthaikh=1),	--0: Ngung hop tac, 1: Dang hop tac

	Constraint pk_Khachhang primary key(makh)
)
go

Create table phieunhap
(
	idphieunhap Int identity(1,1) not null unique,
	maphieunhap Varchar(10)not null unique,
	mancc Varchar(10) not null,
	ngaynhap Datetime not null,
	trangthaipn Int check(trangthaipn=0 or trangthaipn=1 or trangthaipn=2)not null,	--0: Chờ duyệt, 1: Đã duyệt, 2: Đã hủy
	manv Varchar(10) not null

	Constraint pk_phieunhap primary key(maphieunhap),

	Constraint fk_phieunhap_mancc foreign key(mancc)
		references Nhacungcap(mancc),

	Constraint fk_phieunhap_manv foreign key(manv)
		references Nguoidung(manv),
)
go


Create table phieuxuat
(
	idphieuxuat Int identity(1,1) not null unique,
	maphieuxuat Varchar(10)not null unique,
	makh Varchar(10) not null,
	ngayxuat Datetime not null,
	trangthaipx Int check(trangthaipx=0 or trangthaipx=1 or trangthaipx=2)not null,	--0: Chờ duyệt, 1: Đã duyệt, 2: Đã hủy
	manv Varchar(10) not null

	Constraint pk_phieuxuat primary key(maphieuxuat),

	Constraint fk_phieuxuat_makh foreign key(makh)
		references Khachhang(makh),

	Constraint fk_phieuxuat_manv foreign key(manv)
		references Nguoidung(manv),
)
go

Create table Chitietphieunhap
(
	idchitietphieunhap Int identity(1,1) not null unique,
	maphieunhap Varchar(10) not null,
	masp Varchar(10) not null,
	soluongnhap Int not null check(soluongnhap>=0), 
	dongianhap Money not null check(dongianhap>=0),
	Tiennhap Money not null,

	--Tiennhap as (soluongnhap * dongianhap),

	Constraint pk_chitietphieunhap primary key(idchitietphieunhap),

	Constraint fk_chitietphieunhap_maphieunhap foreign key(maphieunhap)
		references Phieunhap(maphieunhap),
		
	Constraint fk_chitietphieunhap_masp foreign key (masp)
		references Sanpham(masp) ,
)
go

Create table Chitietphieuxuat
(
	idchitietphieuxuat Int identity(1,1) not null unique,
	maphieuxuat Varchar(10) not null,
	masp Varchar(10) not null,
	soluongxuat Int not null check(soluongxuat >=0), 
	dongiaxuat Money not null check(dongiaxuat >=0),
	Tienxuat Money not null,

	--Tienxuat as (Soluongxuat * Dongiaxuat),

	Constraint pk_chitietphieuxuat primary key(idchitietphieuxuat),

	Constraint fk_chitietphieuxuat_maphieuxuat foreign key(maphieuxuat)
		references Phieuxuat(maphieuxuat),
		
	Constraint fk_chitietphieuxuat_masp foreign key (masp)
		references Sanpham(masp),
)
go

Create table Baocao
(
	mabaocao Varchar(10) not null unique,
	thang int check(thang>=1 or thang <=12),
	nam int check(nam<=(year(getdate()))),
	tongtiennhap Money,
	tongtienxuat Money,
	doanhthu Money,		--Doanhthu = tongtienxuat - tongtiennhap.
	idnguoilap Varchar(10) not null

	Constraint pk_baocao primary key (mabaocao)

	Constraint fk_baocao_idnguoilap foreign key(idnguoilap)
		references Nguoidung(manv),
)
go





