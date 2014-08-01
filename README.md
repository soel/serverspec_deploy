serverspec_deploy
=================

## これは何?
serverspec の例です。あまり有用な情報はないかもしれませんm(__)m

## 主な特徴
- 定形でサーバをデプロイする場合にテストが楽になります

## インストール
1. git clone
```bash
git clone https://github.com/soel/serverspec_deploy.git
```
  
1. bundle install
```bash
bundle install
```
  
## 使い方
- 一般的な使用例

1. 適当な場所へ work ディレクトリを作成
```bash
cd /tmp
mkdir work
```
  
1. base をコピー
```bash
cp -R serverspec_deploy/<OSバージョン>/default/ /tmp/work
```
  
1. 追加の設定をコピー 
- 物理サーバの場合は physical, 仮想の場合は virtual
```bash
cp <OSバージョン>/physical/physical_spec.rb /tmp/work/default/spec/name_or_ipaddress/
```
  
1. ディレクトリ名の変更
```bash
cd /tmp/work/default/spec/
mv name_or_ipaddress <IP アドレス>
```
  
1. 設定ファイルの編集
```bash
vi <IP アドレス>/physical_spec.rb
```
  サーバ固有情報を設定ファイルに記述する  
  
1. 実行
```bash
cd /tmp/work/default/
ASK_SUDO_PASSWORD=1 ASK_LOGIN_PASSWORD=1 rspec -c spec --format documentation
```
- 上記コマンド実行後、SUDO_PASSWORD、LOGIN_PASSWORD を入力する

## その他情報

## ライセンス
- LICENSE.txt を御覧ください
- MIT ライセンスです
