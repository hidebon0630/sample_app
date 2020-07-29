# 概要
[Wanna Know?](https://www.water-mint.work/)

自由にアンケートを作成、回答する事が出来るアプリです。

# インフラ構築図

# 実装機能

- ユーザー機能
  - 新規登録、ログイン、ログアウト機能
  - マイページ、登録情報編集機能
- アンケート機能
  - アンケート一覧表示、アンケート詳細表示、新規アンケート、アンケート削除機能
  - Javascriptを使用した動的なアンケート項目の追加機能
  - 画像付きアップロード機能
  - 画像プレビュー機能
  - bootstrap-tags-inputを使用して、動的にタグを分割
  - ラジオボタン選択による回答機能
  - gon,chart.jsを使用して、回答結果を円グラフで表記
- コメント機能(Ajaxを使用)
- いいね機能(Ajaxを使用)
- フォロー機能(Ajaxを使用)
- ダイレクトメッセージ機能(Ajaxを使用)
- 通知機能
  - アンケート回答、いいね、フォロー、コメント時に通知が飛ぶように実装
- タグ機能
  - タグをクリックする事で検索可能
- PV機能
  - impressionistを使ってページビューをトラッキング
- ランキング機能
  - いいね数、PV数によるランキング表示
- 検索機能
  - 複数の検索条件を指定可能
- 管理機能
  - rails_admin、cancancanを使用
- ページネーション機能
  - jscrollを使用して、無限にスクロール出来る機能を実装
- Material Design for Bootstrap
  - カルーセル、ドゥロワー、パンくずリスト、タブリストを導入
  - レスポンシブデザインに対応

# 使用技術

- Ruby 2.7.1 Rails 5.2.4

- MySQL 5.7

- AWS（ECS, ECR, RDS, Route 53, VPC, ALB, ACM, S3, CloudFront）
  - cloudfront経由でs3のファイルを独自ドメイン(images.water-mint.work...)からCDN配信
  
- Puma(アプリケーションサーバー）
  - Nginxとsockets通信して連携
- Nginx(Webサーバー)
  - ロードバランサーとしての負荷分散
  - ヘルスチェッククリア

- Docker
- docker-compose
  - ローカル環境構築
  - systemスペックにおけるjavascriptのテスト用に、docker-seleniumを導入

- CircleCI
  - CI
    - RSpecのテスト及びRansackによる静的解析をpush時に開始
  - CD
    - masterブランチへのマージによりECR/ECSへデプロイ
    - Orbsを用いたデプロイを実装

- RSpec
  - 単体テスト
  - 統合テスト

- Material Design for Bootstrap

- Ajax

- JQuery
  - jscroll
  - bootstrap-tags-input
  
- Javascript
  - toastr.js
  - chart.js
