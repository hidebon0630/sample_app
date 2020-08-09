# 概要
[Wanna Know?](https://www.water-mint.work/)

気軽にアンケートを集め、ユーザーの疑問を解決する事を目的としたサービスです。

個々ユーザーが、様々な回答結果を参考にする事で、新たな学びを得る事が出来るのが特徴です。

また、サービスを成長させる上で重要なマーケティングという側面も意識をして、PVの取得やGoogleAnalyticsでのアクセス分析を実施している点も特徴として挙げられます。

### 工夫した点
  - Dockerを使い、ECS/ECRで本番環境を運用している。
  
  - CircleCIを使い、CD/CDパイプラインを構築している。
  
  - CloudFront経由でS3のファイルを独自ドメインからCDN配信。
  
  - ユーザーの問題解決を目的としているだけでなく、マーケティング面も考え、アクセス分析を実施している。

# インフラ構築図
![名称未設定ファイル](https://user-images.githubusercontent.com/45557213/89125277-4d3d0f00-d518-11ea-811f-fd61c44baab2.png)
# ER図
![ポートフォリオ (1)](https://user-images.githubusercontent.com/45557213/89738885-0ff7f480-dab7-11ea-9b4c-a874f38d09b6.png)
# 実装機能

- ユーザー機能
  - 新規登録、ログイン、ログアウト機能
  - マイページ、登録情報編集機能
- アンケート機能
  - アンケート一覧表示、アンケート詳細表示、新規アンケート、アンケート削除機能
  - cocoonを使用した動的なアンケート項目の追加機能
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
- Ruby 2.7.1
- Rails 5.2.4
- Mysql 5.7
- AWS(ECS/ECR/RDS/Route53/VPC/ALB/ACM/S3/CloudFront/CloudWatch/IAM)
  - CloudFront経由でS3のファイルを独自ドメイン(images.water-mint.work)からCDN配信
- Puma
  - sockets通信でNginxと連携
- Nginx
  - ロードバランサーとしての負荷分散
  - ヘルスチェッククリア
- Docker
- docker-compose
  - ローカル環境構築
  - docker-selenium
- CircleCI
  - CI
    - RSpecでのテスト及びransackによる静的解析
  - CD
    - masterブランチへのマージへのECS/ECRへデプロイ
    - orbsを用いたデプロイ
- RSpec
  - 単体テスト
  - 統合テスト
- Material Design for Bootstrap
- Ajax
- jQuery
  - jscroll
  - bootstrap-tags-input
- Javascript
  - toastr.js
  - chart.js
