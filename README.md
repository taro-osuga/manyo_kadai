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