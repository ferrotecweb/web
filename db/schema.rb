# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100520031644) do

  create_table "agents", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "categories", :force => true do |t|
    t.string   "categoryid",    :null => false
    t.string   "categoryname"
    t.integer  "categoryorder"
    t.integer  "categorytype"
    t.string   "categoryurl"
    t.text     "content"
    t.string   "contentpic"
    t.string   "url"
    t.string   "summary"
    t.string   "summarypic"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id",    :null => false
    t.string   "summarydetail"
    t.string   "productsort"
    t.string   "picturename"
    t.string   "productspec"
  end

  create_table "categorylists", :force => true do |t|
    t.string   "categoryid",          :null => false
    t.string   "title"
    t.integer  "titleorder"
    t.string   "titlestyle"
    t.string   "titleurl"
    t.text     "content"
    t.string   "contentpic"
    t.string   "writer"
    t.string   "keyword"
    t.string   "attribute"
    t.string   "summary"
    t.string   "summarypic"
    t.string   "downloadfile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "istechnologyarticle"
    t.datetime "issuedate"
  end

  create_table "companies", :force => true do |t|
    t.string   "companyname", :null => false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "fullname"
    t.string   "address"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "zipcode"
    t.string   "linkman"
    t.string   "summarypic"
    t.string   "summary"
    t.string   "categoryid"
    t.string   "linian"
    t.string   "url"
    t.text     "content"
    t.string   "www"
    t.string   "bus"
  end

  create_table "contacts", :force => true do |t|
    t.string   "categoryid",     :null => false
    t.string   "country"
    t.string   "area"
    t.string   "city"
    t.string   "company"
    t.string   "person"
    t.string   "addr"
    t.string   "phone"
    t.string   "email"
    t.string   "fax"
    t.string   "zipcode"
    t.text     "content"
    t.datetime "getdate"
    t.boolean  "isused"
    t.string   "asked"
    t.string   "description"
    t.string   "tecsize"
    t.string   "tecthot"
    t.string   "tectcold"
    t.string   "teccoolingload"
    t.string   "tecasked"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "language"
  end

  create_table "en_categories", :force => true do |t|
    t.string   "categoryid",    :null => false
    t.string   "categoryname"
    t.integer  "categoryorder"
    t.integer  "categorytype"
    t.string   "categoryurl"
    t.text     "content"
    t.string   "contentpic"
    t.string   "url"
    t.string   "summary"
    t.string   "summarypic"
    t.integer  "company_id",    :null => false
    t.string   "summarydetail"
    t.string   "productsort"
    t.string   "picturename"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "productspec"
  end

  create_table "en_categorylists", :force => true do |t|
    t.string   "categoryid",          :null => false
    t.string   "title"
    t.integer  "titleorder"
    t.string   "titlestyle"
    t.string   "titleurl"
    t.text     "content"
    t.string   "contentpic"
    t.string   "writer"
    t.string   "keyword"
    t.string   "attribute"
    t.string   "summary"
    t.string   "summarypic"
    t.string   "downloadfile"
    t.boolean  "istechnologyarticle"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "issuedate"
    t.string   "company_id"
  end

  create_table "en_companies", :force => true do |t|
    t.string   "companyname", :null => false
    t.string   "fullname"
    t.string   "address"
    t.string   "telephone"
    t.string   "fax"
    t.string   "email"
    t.string   "zipcode"
    t.string   "linkman"
    t.string   "summarypic"
    t.string   "summary"
    t.string   "categoryid"
    t.string   "linian"
    t.string   "url"
    t.text     "content"
    t.string   "www"
    t.string   "bus"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "en_contacts", :force => true do |t|
    t.string   "categoryid",     :null => false
    t.string   "country"
    t.string   "area"
    t.string   "city"
    t.string   "company"
    t.string   "person"
    t.string   "addr"
    t.string   "phone"
    t.string   "email"
    t.string   "fax"
    t.string   "zipcode"
    t.text     "content"
    t.datetime "getdate"
    t.boolean  "isused"
    t.string   "asked"
    t.string   "description"
    t.string   "tecsize"
    t.string   "tecthot"
    t.string   "tectcold"
    t.string   "teccoolingload"
    t.string   "tecasked"
    t.integer  "quantity"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", :force => true do |t|
    t.string   "depart"
    t.string   "poth"
    t.integer  "num"
    t.text     "info"
    t.string   "workadd"
    t.datetime "overdate"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "recordlists", :force => true do |t|
    t.string   "categoryid",  :null => false
    t.string   "userid",      :null => false
    t.integer  "operatetype"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tabletype"
    t.integer  "company_id"
    t.string   "tablename"
    t.string   "host_ip"
    t.string   "host_name"
  end

  create_table "setparams", :force => true do |t|
    t.string   "modelnumber"
    t.string   "partnumber"
    t.string   "shafttype"
    t.string   "shaftdimension"
    t.string   "shaftdimensioncondition"
    t.string   "mountingtype"
    t.string   "fluid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "upfiles", :force => true do |t|
    t.string   "filename"
    t.string   "upfile"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.datetime "upfile_at",  :default => '2011-01-17 17:07:24'
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "hashed_password"
    t.string   "salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
