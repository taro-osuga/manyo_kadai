# テーブル設計

userテーブル
| Name | email | password |
|:-----|:-----|:-----|
| string | string | string |

taskテーブル
| title | content | user_id |
|:-----|:-----|:-----|
| string | text | integer |

labelテーブル
| status | task_id | user_id |
|:-----|:-----|:-----|
| string | integer | integer |

# Herokuにデプロイする手順
1. Herokuログイン
```
$ heroku login
```
2. コミット
```
$ git add -A
$ git commit -m "コミットメッセージ"
```
3. Herokuアプリケーション作成
```
$ heroku create
```
4. Herokuにデプロイ
```
$ git push heroku master
```
5. データベースの移行
```
$ heroku run rails db:migrate
```
6. 下記URLにアクセス。  
https://sheltered-badlands-44463.herokuapp.com/
