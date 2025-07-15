# Stock Tracker

Stock Tracker 是一個使用 Flutter 開發的股票追蹤應用程式，專為台灣證券交易所（TWSE）的股票資料設計。該應用程式允許用戶追蹤自選股票的即時行情、歷史數據，並提供 K 線圖和成交量圖表以視覺化股票走勢。應用程式使用 Riverpod 進行狀態管理，並透過 `flutter_dotenv` 管理環境變數以提高配置靈活性。

<img width="225" height="487.5" alt="Simulator Screenshot - iPhone 16 - 2025-07-15 at 10 14 06" src="https://github.com/user-attachments/assets/27022ec2-9f33-4baa-bdc0-61fddf2835c7" />
<img width="225" height="487.5" alt="Simulator Screenshot - iPhone 16 - 2025-07-15 at 10 14 17" src="https://github.com/user-attachments/assets/5386ae34-fe09-4959-a780-ef8b1f2ad951" />
<img width="225" height="487.5" alt="Simulator Screenshot - iPhone 16 - 2025-07-15 at 10 14 49" src="https://github.com/user-attachments/assets/c5376992-5739-4ff1-bb0c-6e7fd6b2a53b" />

## 功能

- **即時股票行情**：從台灣證券交易所（TWSE）API 獲取股票的即時價格、開盤價、最高價、最低價等資訊。
- **歷史數據查詢**：支援查看指定股票的月度或半年歷史數據，包括 K 線圖和成交量圖表。
- **自選股清單**：用戶可以添加或移除自選股票，並儲存在本地（透過 `shared_preferences`）。
- **搜尋功能**：透過搜尋下拉選單快速查找股票並查看詳情。
- **圖表視覺化**：使用自訂的 `DailyCandlestickChart` 和 `VolumeBarChart` 展示股票的價格走勢和成交量。
- **動態刷新**：支援手動刷新自選股清單，並每 10 秒自動更新即時行情。

## 專案結構

- **lib/api/**：包含 `StockApi` 類，負責與 TWSE API 和 Finnhub API（若配置）進行資料交互。
- **lib/models/**：定義資料模型（如 `Stock`、`StockHistory`、`TwseStockInfo`）。
- **lib/pages/**：包含主要頁面，如 `StockListPage`（自選股清單）和 `StockDetailPage`（股票詳情）。
- **lib/providers/**：使用 Riverpod 管理狀態，包含股票資料、搜尋功能和自選股清單。
- **lib/widgets/**：自訂 Widget，例如股票搜尋下拉選單 (`StockSearchDropdown`)、K 線圖 (`DailyCandlestickChart`) 和成交量圖 (`VolumeBarChart`)。
- **assets/**：包含 `stocks.json`（股票清單資料）和 `.env`（環境變數檔案）。

## 環境需求

- Flutter SDK: 3.x 或以上
- Dart: 3.x 或以上
- 依賴套件：見 `pubspec.yaml`（例如 `flutter_dotenv`, `hooks_riverpod`, `http`, `shared_preferences` 等）

## 安裝與設置

### 1. 克隆專案
```bash
git clone https://github.com/qpalzm963/stock_tracker.git
cd stock_tracker
```

### 2. 安裝依賴
```bash
flutter pub get
```

### 3. 配置環境變數
在專案根目錄下建立 `.env` 檔案，並添加以下內容（根據需要配置 API 金鑰）：
```env
STOCK_API_KEY=your_finnhub_api_key
```
> **注意**：目前應用程式主要使用 TWSE API，`STOCK_API_KEY` 僅用於 Finnhub API（未完全啟用）。請確保 `.env` 檔案已加入 `.gitignore` 以避免敏感資訊洩露。

在 `pubspec.yaml` 中確保已宣告 `.env` 作為資產：
```yaml
flutter:
  assets:
    - .env
    - assets/stocks.json
```

### 4. 運行應用程式
```bash
flutter run
```

## 使用方式

1. **首頁（StockListPage）**：
   - 顯示自選股清單，包含即時價格、漲跌幅等資訊。
   - 使用搜尋下拉選單（`StockSearchDropdown`）查找並添加股票到自選股清單。
   - 支援下拉刷新以更新所有自選股的即時資料。

2. **股票詳情頁（StockDetailPage）**：
   - 顯示指定股票的 K 線圖和成交量圖表。
   - 提供月份選擇下拉選單，允許用戶切換查詢的歷史數據月份。
   - 顯示最新收盤價。

3. **自選股管理**：
   - 透過 `StockTile` 的移除按鈕從自選股清單中移除股票。
   - 自選股清單使用 `shared_preferences` 持久化儲存。

## 安全注意事項

由於 `flutter_dotenv` 將 `.env` 檔案打包進應用程式，存在反編譯洩露風險。以下是建議的安全措施：

1. **避免儲存敏感資料**：
   - 目前 `STOCK_API_KEY` 用於 Finnhub API（未完全啟用）。建議將敏感 API 金鑰儲存在後端，並透過安全的 HTTPS API 獲取資料。
   - TWSE API 不需要金鑰，適合公開使用，但需注意 API 請求頻率限制。

2. **使用安全儲存**：
   - 若需要在客戶端儲存敏感資料，考慮使用 `flutter_secure_storage` 將資料加密儲存在設備的安全區域（如 iOS Keychain 或 Android Keystore）。

3. **後端代理**：
   - 建議部署一個後端服務，將 API 金鑰儲存在伺服器端，客戶端僅透過後端 API 間接訪問資料。

4. **版本控制**：
   - 確保 `.env` 檔案已加入 `.gitignore`，避免提交到 Git 倉庫。

## 已知問題與改進計劃

- **API 限制**：TWSE API 的請求頻率可能受限，可能導致資料延遲或失敗。未來可考慮快緩存或備用 API。
- **圖表效能**：當歷史資料量較大時，K 線圖和成交量圖表的渲染可能需要優化。
- **Finnhub API 整合**：目前未完全啟用 Finnhub API，未來可根據需求實現更穩定的即時行情更新。

## 貢獻

歡迎提交問題或 Pull Request！請遵循以下步驟：
1. Fork 本倉庫
2. 創建你的功能分支 (`git checkout -b feature/your-feature`)
3. 提交你的更改 (`git commit -m 'Add your feature'`)
4. 推送到分支 (`git push origin feature/your-feature`)
5. 開啟 Pull Request


