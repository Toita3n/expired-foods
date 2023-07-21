# サービス名
　expired_foods

# サービス概要
 冷蔵庫内の食材をメモして、その食材の賞味期限/消費期限が来るまでの時間を表示する冷蔵庫管理サービスです。

 # 想定されるユーザー層
 　家庭で料理を作る人が主なターゲット層です。年代は若者（一人暮らしを始めたばかりで自炊をし始めた人）をターゲットにしています。自分が冷蔵庫の中に存在するものを把握することにより、最近自炊で食べている食べ物の傾向などがわかります。また、料理をしてまもない頃だと同じ料理を作りがちなので冷蔵庫の中身を把握することで自照することもできます。

 #　サービスコンセプト
 　夏のある日、当時の私は自炊をあまりしていなかったのですが、１週間ほど母親が地方の祖母の家に行くことになっていました。私が母に冷蔵庫の中に何が入っているのかを尋ねていなかったため冷蔵庫にある食材にカビが生えていたり、傷んでいたりしていたことがありました。冷蔵庫の奥に眠っているもう食べれない食べ物などがあったりなど多くの食べ物を無駄にしてきました。このような食材を無駄にする行為を減らすために冷蔵庫内の食品を管理するサービスを考えました。
 　他のアプリとの差別化ですが、基本的に他のアプリでは自分で商品名を入れたりしていますが、このアプリケーションでは画像判別のAPIで自ら自分で入力しなくても画像から文字を抽出することでわざわざ文字入力する手間を省けると思っています。もちろん画像判別機能で文字を取得できない場合もありますので、手入力も可能にしておきます。

 #　実装を予定している機能

 会員登録
 ログイン
 ユーザー詳細
 商品一覧（冷蔵庫内の商品棚、indexとして使用）
 商品詳細(賞味期限・消費期限、買った場所など)
 買い物リスト
 画像判別機能（API: Cloud Vision APIの使用）商品名を読み取る
 reminder(材料がない場合や賞味期限が来た場合に通知)LinepushのAPI

# その後の機能（作れたら）

冷蔵庫内で作れるメニュー



# 画面移行図(Figma)
https://www.figma.com/file/bAEJaoqbJOAX6yf0uEZz75/expired_foods?type=design&node-id=0%3A1&mode=design&t=zGEZgn14ElDN3Vfg-1

# ER図
![Alt text](https://i.gyazo.com/cdae65f284ee46a4d88448418b0a9454.png)