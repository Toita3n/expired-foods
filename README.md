# サービス名
　expired_foods

# サービスのURL
https://www.stop-expired-foods.com

# サービス概要
 冷蔵庫内の食材をメモして、その食材の賞味期限/消費期限が来るまでの時間を表示する冷蔵庫管理サービスです。

 #　サービスへの想い
 私は自炊をすることが多いのですが、冷蔵庫の中身に眠らせたままにしている食材があったり、そのままダメになってしまった食べ物などがあったりしたのでしたので冷蔵庫の中身を可視化するために作成しました。現在は、商品の記録のみですが、段階的に新機能を実装して利便性を向上させようと思っています。また、LINEと連携してexpired-foodsの公式アカウントを友だち登録するとトーク画面から冷蔵庫の中身が検索できます。

# 今後実装予定の機能
  冷蔵庫内で作れるメニュー

  Youtubeなどの外部サイトでのレシピ検索

  画像から商品を特定してフォームに入力して登録する

# 主なページと機能
 | topページ | ログインページ |
 | --- | --- |
 | ![Alt text](https://i.gyazo.com/2e1a65f89b2d78e8aa9519d0319823b6.png) | ![Alt text](https://i.gyazo.com/fd517836b905953862922e4881031545.png) |
 | topページにこのapplicationの概要を表示しました。 | ログインページでLINEログインを実装して使いやすいように心がけました。 |

 | ユーザー登録ページ | 食材・商品ページ|
 | --- | --- |
 | ![Alt text](https://i.gyazo.com/ad41c321e3ce8343509aa05c8a414681.png) | ![Alt text](https://i.gyazo.com/13ac69a9bbc21ca9ea74887c0d4a12d3.png) |
 | 見やすいようにシンプルな表示にしました。 | 商品を一覧で表示し、検索欄からも検索できるようにしました。、また商品・食材名を検索欄から検索できるようにしています。 |

 | 食材・商品登録ページ | 買い物リストのページ |
 | --- | --- |
 | ![Alt text](https://i.gyazo.com/017d1d8c8b8d403c46df889516e16e51.png) | ![Alt text](https://i.gyazo.com/97f852fe4dea0d00e5ba15fd35375bd9.png) |
 | テンプレートボタンを押すとよく使われるものは簡単に入力できるようにしています。 | 複数の買い物リストを一度に削除できるようにチェックボタンをしています。また、商品名をクリックするとその商品だけ内容を変更できるようにしています。 |

 | 買い物リスト登録ページ | アカウント情報ページ |
 | --- | --- |
 | ![Alt text](https://i.gyazo.com/bad03b3a9bf69a361d525bac91f88dee.png) | ![Alt text](https://i.gyazo.com/067c4ae5212f65a1f6f8925706e8ec3a.png) |
 | 最大10までの商品を同時に登録できるようにしています。| アカウント詳細ページからLINE連携やアカウントの削除をできるようにしています。 |
# 使用技術一覧
<img src="https://img.shields.io/badge/-Ruby-CC342D.svg?logo=ruby&style=plastic"><img src="https://img.shields.io/badge/-Rails-CC0000.svg?logo=rails&style=plastic"><img src="https://img.shields.io/badge/-Javascript-F7DF1E.svg?logo=javascript&style=plastic"><img src="https://img.shields.io/badge/-Node.js-339933.svg?logo=node.js&style=plastic"><img src="https://img.shields.io/badge/-Mysql-4479A1.svg?logo=mysql&style=plastic"><img src="https://img.shields.io/badge/-Yarn-2C8EBB.svg?logo=yarn&style=plastic"><img src="https://img.shields.io/badge/-Line-00C300.svg?logo=line&style=plastic"><img src="https://img.shields.io/badge/-Nginx-269539.svg?logo=nginx&style=plastic"><img src="https://img.shields.io/badge/-Amazon%20aws-232F3E.svg?logo=amazon-aws&style=plastic"><img src="https://img.shields.io/badge/-Amazon%20aws%20EC2-232F3E.svg?logo=amazon-aws&style=plastic">

## バックエンド
・ Ruby -v 3.0.2

・ Ruby on Rails -v 6.1.4
## フロントエンド
・ HTML

・ SCSS

・Javascript

## データベース
・MySQL -v 8.0.2


# 画面移行図(Figma)
https://www.figma.com/file/bAEJaoqbJOAX6yf0uEZz75/expired_foods?type=design&node-id=0%3A1&mode=design&t=zGEZgn14ElDN3Vfg-1

# ER図
![Alt text](https://i.gyazo.com/5a8b2fe3172f273e10274c05ccc62833.png)