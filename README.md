## ユーザーテーブル (users)

|       Column       |    Type    |              Options               |
|       ------       |    ----    |              -------               |
|      nickname      |   string   |            null: false             |
|        email       |   string   |     null: false, unique: true      |
| encrypted_password |   string   |            null: false             |
|      last_name     |   string   |            null: false             |
|      first_name    |   string   |            null: false             |
|    last_name_kana  |   string   |            null: false             |
|   first_name_kana  |   string   |            null: false             |
|      birthdate     |    date    |            null: false             |


  
### Association
-has_many :items
-has_many :purchases

## 商品テーブル (items)

|        Column        |    Type    |              Options                |
|        ------        |    ----    |              -------                |
|         user         | references |    null: false, foreign_key: true   |
|         name         |   string   |            null: false              |
|      description     |    text    |            null: false              |
|      category_id     |   integer  |            null: false              |
|     condition_id     |   integer  |            null: false              |
|    shipping_fee_id   |   integer  |            null: false              |
|    prefecture_id     |   integer  |            null: false              |
| shipping_duration_id |   integer  |            null: false              |
|         price        |   integer  |            null: false              |

### Association
-belongs_to :user
-has_one :purchase
-belongs_to_active_hash :category
-belongs_to_active_hash :condition
-belongs_to_active_hash :shipping_fee
-belongs_to_active_hash :prefecture
-belongs_to_active_hash :shipping_duration

## 購入記録テーブル (purchases)

|       Column       |     Type     |                  Options                    |
|        user        |  references  |       null: false, foreign_key: true        |
|        item        |  references  |       null: false, foreign_key: true        |

### Association
-belongs_to :user
-belongs_to :item
-has_one :shipping_address

## 発送先情報テーブル (shipping_addresses)

|     Column      |    Type    |              Options               |
|     purchase    | references |   null: false, foreign_key: true   |
|   postal_code   |   string   |             null: false            |
|  prefecture_id  |   integer  |             null: false            | 
|      city       |   string   |             null: false            | 
| street_address  |   string   |             null: false            | 
|  building_name  |   string   |                                    | 
|  phone_number   |   string   |             null: false            | 


### Association
-belongs_to :purchase
