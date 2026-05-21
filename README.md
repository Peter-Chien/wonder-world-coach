# Wonder World Coach

康軒 Wonder World 4 英文練習原型。現在先用 2026 年 5 月下旬推估進度：Unit 4 主練，Unit 3 複習。

## 家裡平板使用

同一個 Wi-Fi / 區網下可開：

- `http://192.168.52.147:4173/`
- `http://D620MT-D620SF-BM3CF.local:4173/`

如果 IP 變動，優先試 `.local` 網址。

## 搬到家裡 Ubuntu 安裝

把整個 `wonder-world-coach` 目錄或打包檔搬到家裡 Ubuntu 後執行：

```bash
tar -xzf wonder-world-coach-ubuntu.tar.gz
cd wonder-world-coach
./install-ubuntu-user-service.sh
```

安裝後腳本會顯示平板可連的網址，通常是：

```text
http://家裡電腦IP:4173/
http://家裡電腦主機名.local:4173/
```

若要讓服務在尚未登入桌面時也啟動，可再執行：

```bash
sudo loginctl enable-linger $(whoami)
```

檢查服務：

```bash
systemctl --user status wonder-world-coach.service
```

## 啟動方式

已建立使用者層 systemd service：

```bash
systemctl --user status wonder-world-coach.service
systemctl --user restart wonder-world-coach.service
```

服務檔：

```text
/home/peter/.config/systemd/user/wonder-world-coach.service
```

手動啟動腳本：

```bash
/home/peter/git/openclaw/apps/wonder-world-coach/start-lan.sh 0.0.0.0 4173
```

## 尚待補齊

- 用 Peter 提供的課本/習作照片替換正式單字、句型與課文資料。
- 若要更短網址如 `wonder.local`，需要額外設定 mDNS alias 或家中路由器 DNS。
- 若要完整 PWA 安裝與離線能力，建議之後補 HTTPS 內網站台。
