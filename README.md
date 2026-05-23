# Wonder World Coach

康軒 Wonder World 4 英文練習原型。現在先用 2026 年 5 月下旬推估進度：Unit 4 主練，Unit 3 複習。

## 在家裡 Ubuntu 安裝

家裡電腦是 Ubuntu 時，直接從 GitHub 下載並安裝：

```bash
git clone https://github.com/Peter-Chien/wonder-world-coach.git
cd wonder-world-coach
./install-ubuntu-user-service.sh
```

安裝腳本會：

- 複製 AP 到 `~/apps/wonder-world-coach`
- 建立使用者層 systemd service
- 啟動 `wonder-world-coach.service`
- 顯示平板可連的區網網址

若要讓服務在尚未登入桌面時也啟動，可再執行：

```bash
sudo loginctl enable-linger $(whoami)
```

## 家裡平板使用

安裝完成後，腳本會顯示類似下面的網址：

```text
http://家裡電腦IP:4173/
http://家裡電腦主機名.local:4173/
```

平板和家裡 Ubuntu 電腦要連在同一個 Wi-Fi / 區網。若 `.local` 網址打不開，改用 IP 網址。

## 發音與官方資源

目前不需要另外準備音檔。單字練習使用瀏覽器內建英文語音合成 `speechSynthesis` 發音，所以 Chrome、Edge、Safari 通常可以直接唸。

首頁也已接上 Peter 提供的官方資源：

- 康軒 Wonder World 4 音檔頁，可在 AP 內播放 Unit 3 / Unit 4 Track。
- YouTube 播放清單，可在 AP 內嵌播放，也可另開 YouTube。

## 更新版本

之後如果 GitHub repo 有更新，家裡 Ubuntu 可以重新拉最新版再安裝：

```bash
cd wonder-world-coach
git pull
./install-ubuntu-user-service.sh
```

## 離線搬移安裝

如果家裡 Ubuntu 沒有網路或不能連 GitHub，才需要使用 `wonder-world-coach-ubuntu.tar.gz` 離線包：

```bash
tar -xzf wonder-world-coach-ubuntu.tar.gz
cd wonder-world-coach
./install-ubuntu-user-service.sh
```

## 管理服務

檢查服務：

```bash
systemctl --user status wonder-world-coach.service
```

重新啟動：

```bash
systemctl --user restart wonder-world-coach.service
```

停止服務：

```bash
systemctl --user stop wonder-world-coach.service
```

手動啟動也可以使用：

```bash
./start-lan.sh 0.0.0.0 4173
```

## 目前狀態

- 這是可在家裡區網使用的第一版原型。
- Unit 4 已依 Peter 提供的課本照片補入正式單字、句型與課文速讀；Unit 1-3 仍是示範/推估資料。
- 官方資源已接入：
  - https://945cloud.knsh.com.tw/CD/E/Study/kWW4/
  - https://www.youtube.com/playlist?list=PL1ALWv3zeh16vpENGgnoNfdFaxHfD6PKr
- 後續若 Peter 提供 Unit 1-3 課本或習作照片，可再補成正式內容。

## 後續可選

- Unit 1-3 正式單字、句型與課文：需要 Peter 提供課本/習作照片或合法文字來源後再替換。
- 更短網址如 `wonder.local`：需要額外設定 mDNS alias 或家中路由器 DNS。
- 完整 PWA 安裝與離線能力：建議之後補 HTTPS 內網站台。
