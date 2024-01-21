## ユーザーテーブル (users)

|       Column       |    Type    |              Options               |
|       ------       |    ----    |              -------               |
|      nickname      |   string   |            null :false             |
|        email       |   string   |     null :false, unique: true      |
| encrypted_password |   string   |            null :false             |
|      last_name     |   string   |            null :false             |
|      first_name    |   string   |            null :false             |
|    last_name_kana  |   string   |            null :false             |
|   first_name_kana  |   string   |            null :false             |
|      birthdate     |    date    |            null :false             |


  
### Association
-has_many :items
-has_many :purchases

## 商品テーブル (items)

|     Column      |    Type    |              Options                |
|     ------      |    ----    |              -------                |
|       user      | references |    null: false, foreign_key: true   |
|      name       |   string   |            null :false              |
|   description   |    text    |            null :false              |
|    category     |   integer  |            null :false              |
|   condition     |   integer  |            null :false              |
|   shipping_fee  |   integer  |            null :false              |
|    prefecture   |   integer  |            null :false              |
|shipping_duration|   integer  |            null :false              |
|      price      |   integer  |            null :false              |

### Association
-belongs_to :user (foreign_key: 'seller_id')
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
-belongs_to :buyer, class_name: 'User', foreign_key: 'user_id'
-belongs_to :item
-belongs_to :shipping_address

## 発送先情報テーブル (shipping_addresses)

|     Column      |    Type    |              Options               |
|     user_id     |   integer  |                                    |
|     purchase    |   integer  |   null: false, foreign_key: true   |
|   postal_code   |   string   |             null: false            |
|    prefecture   |   integer  |             null: false            | 
|      city       |   string   |             null: false            | 
| street_address  |   string   |             null: false            | 
|  building_name  |   string   |                                    | 
|  phone_number   |   string   |             null: false            | 


### Association
-belongs_to :user, class_name: 'User', foreign_key: 'user_id'
-belongs_to :purchase
