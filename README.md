## ユーザーテーブル (users)

|      Column       |    Type    |              Options               |
|      ------       |    ----    |              -------               |
|        id         |   integer  |      primary key, auto_increment   |
|     username      |   string   |          not null, unique          |
|       email       |   string   |          not null, unique          |
|  password_digest  |   string   |             not null               |


  
### Association
-has_many :items
-has_many :purchases
-has_one :shipping_address

## 商品テーブル (items)

|   Column    |    Type    |              Options               |
|   ------    |    ----    |              -------               |
|     id      |   integer  |      primary key, auto_increment   |
|  seller_id  |   integer  |  foreign key, references: users(id)|
|    name     |   string   |             not null               |
| description |    text    |                                    |
|    price    |   integer  |             not null               |
|    state    |   string   |                                    |
|   category  |   string   |                                    |
|    image    |   string   |                                    |

### Association
-belongs_to :user (foreign_key: 'seller_id')
-has_many :purchases
-has_and_belongs_to_many :categories

## 購入記録テーブル (purchases)

|     Column      |    Type    |              Options               |
|       id        |   integer  |    primary key, auto_increment     |
|    buyer_id     |   integer  |  foreign key, references: users(id)|
|     item_id     |   integer  |  foreign key, references: items(id)|
|  purchase_date  |  datetime  |                                    |
| purchase_price  |   integer  |                                    |

### Association
-belongs_to :user (foreign_key: 'buyer_id')
-belongs_to :item

## 発送先情報テーブル (shipping_addresses)

|     Column      |    Type    |              Options               |
|       id        |   integer  |      primary key, auto_increment   |
|     user_id     |   integer  |  foreign key, references: users(id)|
|   postal_code   |   string   |                                    |
|    address      |   string   |                                    |

### Association
-belongs_to :user

