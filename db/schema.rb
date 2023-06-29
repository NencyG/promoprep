# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 20_230_629_103_659) do
  create_table 'companies', force: :cascade do |t|
    t.string 'name'
    t.string 'email'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'user_id', null: false
    t.index ['user_id'], name: 'index_companies_on_user_id'
  end

  create_table 'filter_options', force: :cascade do |t|
    t.string 'name'
    t.boolean 'is_active'
    t.integer 'company_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_filter_options_on_company_id'
  end

  create_table 'promo_filter_options', force: :cascade do |t|
    t.integer 'promo_id', null: false
    t.integer 'filter_options_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['filter_options_id'], name: 'index_promo_filter_options_on_filter_options_id'
    t.index ['promo_id'], name: 'index_promo_filter_options_on_promo_id'
  end

  create_table 'promos', force: :cascade do |t|
    t.string 'name'
    t.date 'start_date'
    t.date 'end_date'
    t.text 'description'
    t.integer 'company_id', null: false
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['company_id'], name: 'index_promos_on_company_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.integer 'sign_in_count', default: 0, null: false
    t.datetime 'current_sign_in_at'
    t.datetime 'last_sign_in_at'
    t.string 'current_sign_in_ip'
    t.string 'last_sign_in_ip'
    t.string 'confirmation_token'
    t.datetime 'confirmed_at'
    t.datetime 'confirmation_sent_at'
    t.string 'unconfirmed_email'
    t.integer 'failed_attempts', default: 0, null: false
    t.string 'unlock_token'
    t.datetime 'locked_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'first_name'
    t.string 'last_name'
    t.integer 'age'
    t.date 'dob'
    t.index ['confirmation_token'], name: 'index_users_on_confirmation_token', unique: true
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
    t.index ['unlock_token'], name: 'index_users_on_unlock_token', unique: true
  end

  add_foreign_key 'companies', 'users'
  add_foreign_key 'filter_options', 'companies'
  add_foreign_key 'promo_filter_options', 'filter_options', column: 'filter_options_id'
  add_foreign_key 'promo_filter_options', 'promos'
  add_foreign_key 'promos', 'companies'
end
