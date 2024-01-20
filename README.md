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
-has_one :shipping_address

## 商品テーブル (items)

|     Column      |    Type    |              Options                |
|     ------      |    ----    |              -------                |
|       user      | references |  foreign key, references: users(id) |
|      name       |   string   |            null :false              |
|   description   |    text    |            null :false              |
|    category     |   string   |            null :false              |
|   condition     |   string   |            null :false              |
|   shipping_fee  |   string   |            null :false              |
|    prefecture   |   string   |            null :false              |
|shipping_duration|   string   |            null :false              |
|      price      |   integer  |            null :false              |

### Association
-belongs_to :user (foreign_key: 'seller_id')
-has_one :purchase

## 購入記録テーブル (purchases)

|       Column        |    Type    |                     Options                     |
|      user_id       |   integer  |       foreign key, references: users(id)        |
|       item_id       |   integer  |       foreign key, references: items(id)        |

### Association
-belongs_to :buyer, class_name: 'User', foreign_key: 'user_id'
-belongs_to :item
-belongs_to :shipping_address

## 発送先情報テーブル (shipping_addresses)

|     Column      |    Type    |              Options               |
|     user_id     |   integer  |                                    |
|   postal_code   |   string   |                                    |
|    prefecture   |   string   |             null: false            | 
|      city       |   string   |             null: false            | 
| street_address  |   string   |             null: false            | 
|  building_name  |   string   |                                    | 
|  phone_number   |   string   |             null: false            | 


### Association
-belongs_to :user, class_name: 'User', foreign_key: 'user_id'

