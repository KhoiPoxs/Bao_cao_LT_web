function toggleMenu() {
    const menu = document.getElementById("mainMenu");
    if (menu.style.display === "block") {
        menu.style.display = "none";
    } else {
        menu.style.display = "block";
    }
}

// Form QLHH: Ấn button thêm sản phẩm sẽ mở form thêm sản phẩm
// Lấy phần tử từ HTML
const btnThemSP = document.getElementById("btn_themsp");
const formThemSP = document.getElementById("form_themsp");
const btnHuy = document.getElementById("btn_huy");
const btnLuu = document.getElementById("btn_luu");
const dsSanPham = document.getElementById("dsSanPham");

// Khi bấm "Thêm sản phẩm" -> hiện form
btnThemSP.addEventListener("click", function() {
    formThemSP.style.display = "block";
});

// Khi bấm "Hủy" -> ẩn form
btnHuy.addEventListener("click", function() {
    formThemSP.style.display = "none";
});

// Khi bấm "Lưu" -> thêm thẻ sản phẩm mới vào
btnLuu.addEventListener("click", function() {
    const ten = document.getElementById("tenSP").value;
    const gia = document.getElementById("giaSP").value;
    const sl = document.getElementById("soLuongSP").value;
    const anh = document.getElementById("anhSP").value;

    if (!ten || !gia || !sl || !anh) {
        alert("Vui lòng nhập đủ thông tin!");
        return;
    }

    const sp = document.createElement("div");
    sp.className = "san_pham";
    sp.innerHTML = `
    <img src="${anh}" alt="${ten}">
    <h3>${ten}</h3>
    <p>Giá: ${gia}đ</p>
    <p>Số lượng: ${sl}</p>
    <i class="fa-solid fa-pen"></i>
    <i class="fa-solid fa-xmark"></i>
  `;

    dsSanPham.appendChild(sp);

    alert("Thêm sản phẩm thành công!");

    // Ẩn form sau khi lưu
    formThemSP.style.display = "none";
});