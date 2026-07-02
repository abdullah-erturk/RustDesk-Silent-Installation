<a href="https://buymeacoffee.com/abdullaherturk" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

# RustDesk Silent Installation AIO Tool

## Download Link:

[![Stable?](https://img.shields.io/badge/Release-v1.svg?style=flat)](https://github.com/abdullah-erturk/RustDesk-Silent-Installation/archive/refs/heads/main.zip)

![Rustdesk](https://github.com/abdullah-erturk/RustDesk-Unattended-Installation/blob/main/rustdesk1.jpg)
![Rustdesk](https://github.com/abdullah-erturk/RustDesk-Unattended-Installation/blob/main/rustdesk2.jpg)


     Türkçe Açıklama

<details>

Bu betik, **RustDesk** yazılımının en güncel sürümünü GitHub üzerinden otomatik olarak bulup, işletim sisteminizin mimarisine en uygun sürümü indirerek **sessiz (katılımsız)** bir şekilde kurmanıza olanak tanır. 

**RustDesk**, uzak masaüstü bağlantısı sağlayan ücretsiz ve açık kaynaklı bir yazılımdır.

## Yeni Eklenen Özellikler (v2.0)

- **Çift Dil Desteği:** Betik, Windows dilinizi otomatik algılar. Sisteminiz Türkçeyse Türkçe menüler, değilse İngilizce menüler gösterilir.
- **İnteraktif Menü:** Betiği açtığınızda ekranda **[1] Public Sunucu** veya **[2] Private Sunucu** kurulum seçenekleri sunulur. 
  - **Public Sunucu** seçerseniz, hiçbir bilgi girmeden genel (ücretsiz) sunuculara bağlı standart bir RustDesk kurulumu yapılır.
  - **Private Sunucu** seçerseniz, betik ekranda size sunucu **IP/Host adresinizi** ve varsa **Key (Şifre)** bilginizi sorar. Girdiğiniz bilgilere göre özel bir kurulum yapar. Artık kodun içine girip `domain=` satırlarını manuel düzenlemenize gerek yoktur!
- **Evrensel Mimari Desteği:** Sisteminizin mimarisini derinlemesine analiz eder. **32-Bit (x86)**, **64-Bit (AMD64)** ve **AArch64 (ARM64)** tabanlı cihazlara tam uyumludur. Doğru olan sürümü nokta atışı bularak indirir.
- **Eski Sistem (Windows 7) Desteği:** İndirme işlemi saf `.NET WebRequest` altyapısı ve zorunlu **TLS 1.2** protokolü ile yapıldığı için, Windows 7 gibi eski sistemlerde (PowerShell 2.0 üzerinde bile) bağlantı/indirme hataları yaşanmaz.
- **Sessiz Kurulum:** Kullanıcıya herhangi bir etkileşimde bulunmadan (kurulum pencereleri göstermeden) yazılımı arka planda kurar.

## Kurulum Adımları

1. Betiği yönetici olarak (veya normal) çalıştırın (Otomatik olarak yönetici izni isteyecektir).
2. Ekranda çıkan menüden klavyedeki `1` veya `2` tuşlarına basarak kurulum türünü seçin.
3. Private (Özel) kurulum seçtiyseniz ekrandaki sorulara sunucu yanıtlarınızı girin.
4. Betik, en son stabil sürümü indirecek, arka planda sessizce kuracak ve kurulum tamamlandığında size haber verecektir.

## Bağlantılar

- **RustDesk Projesi:** [RustDesk GitHub](https://github.com/rustdesk/rustdesk)

## Lisans

Bu betik, **Abdullah ERTÜRK** tarafından hazırlanmış olup **MIT Lisansı** altında lisanslanmıştır.


</details>


     English Explanation
<details>

This script allows you to automatically and silently install the latest version of **RustDesk** software by fetching it directly from GitHub and downloading the most appropriate version for your operating system's architecture.

**RustDesk** is a free and open-source software that provides remote desktop connectivity.

## New Features (v2.0)

- **Dual Language Support:** The script automatically detects your Windows language. If your system is in Turkish, it shows Turkish menus; otherwise, it displays English menus.
- **Interactive Menu:** When you run the script, it presents an interactive menu offering **[1] Public Server** or **[2] Private Server** installation options.
  - If you select **Public Server**, a standard RustDesk installation connected to the public (free) servers is performed without any prompts.
  - If you select **Private Server**, the script will ask you for your server **IP/Host address** and an optional **Key**. It will then perform a custom installation based on your input. You no longer need to edit the code to change `domain=` variables manually!
- **Universal Architecture Support:** The script deeply analyzes your system's architecture. It is fully compatible with **32-Bit (x86)**, **64-Bit (AMD64)**, and **AArch64 (ARM64)** computers, downloading exactly the right version for the host.
- **Legacy System (Windows 7) Support:** The download process is handled by a pure `.NET WebRequest` infrastructure with a forced **TLS 1.2** protocol. This ensures that no download errors occur on older systems like Windows 7 (even on PowerShell 2.0).
- **Silent Installation:** Installs **RustDesk** software without any user interaction or setup wizards in the background.

## Installation Steps

1. Run the script (it will automatically request Administrator privileges if needed).
2. Select your installation type by pressing `1` or `2` on your keyboard from the interactive menu.
3. If you chose Private installation, answer the prompts on the screen with your server details.
4. The script will download the latest stable version, install it silently in the background, and notify you when it's complete.

## Links

- **RustDesk Project:** [RustDesk GitHub](https://github.com/rustdesk/rustdesk)

## License

This script is authored by **Abdullah ERTÜRK** and licensed under the **MIT License**.
</details>
