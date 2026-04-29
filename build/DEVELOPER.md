# 🛠 Hướng dẫn build cho nhà phát triển

Tài liệu này dành cho việc phát triển, chỉnh sửa tài nguyên và đóng gói sản phẩm.

### 1. Công cụ
* **Thiết kế:** [Canva](https://canva.com) (Design UI/UX)
* **Xử lý ảnh:** [Removebg](https://www.remove.bg) (Xóa nền), [Convertio](https://convertio.co) (Chuyển định dạng ảnh).
* **Âm thanh/Nhạc:** [Odio](https://odio.ai) & [Suno](https://suno.com) (Tạo nhạc AI), [AudioConverter](https://online-audio-converter.com) (Chuyển định dạng âm thanh).
* **Video:** [Clipchamp](https://clipchamp.com).

### 2. Dây chuyền đóng gói
Để tạo ra file `ParnyEscape.exe` có chữ ký, cần sử dụng:
1. **PowerShell Script:** Chạy `ParnyEscapeBuild.ps1` để tự động hóa quy trình.
    * **[Enigma Virtual Box](https://enigmaprotector.com/assets/files/enigmavb.exe):** Dùng để nén và ảo hóa file ppsx thành thực thi.
    * **[SigThief](https://github.com/secretsquirrel/SigThief):** Sao chép chữ ký số từ Chrome để tăng độ tin cậy cho file exe.

### 3. Lưu ý khi Build
- Kiểm tra file cấu hình `.evb` để đảm bảo đường dẫn `materials/` chính xác.
- Đảm bảo môi trường đã cài đặt `python` để SigThief hoạt động.

```
Project-Potani/
├── build/
│   ├── BUILD.md
│   ├── enigmavb.exe
│   ├── enigmavbconsole.exe
│   ├── ParnyEscape_config_enigma.evb
│   ├── ParnyEscapeBuild.ps1
│   └── sigthief.py
├── materials/
│   ├── images/
│   ├── sounds/
│   └── videos/
└── ParnyEscape.ppsx
```