# README

# 新規の場合

1.rails new rails-vue3-ts-app --api

2.cd rails-vue3-ts-app

3.npx @vue/cli create frontend
tsの設定選ぶ。

4.rails generate controller Hello world

5.app/controllers/hello_controller.rb

class HelloController < ApplicationController
  def world
    render json: { message: 'Hello, World!' }
  end
end
と編集する。

6.
ルーティング
Rails.application.routes.draw do
  get '/hello/world', to: 'hello#world'
end

7.cd frontend

8.frontend/src/components/HelloWorld.vue
<!--
<template>
  <div>
    {{ message }}
  </div>
</template>

<script lang="ts">
import axios from 'axios';
import { defineComponent, ref } from 'vue';

export default defineComponent({
  name: 'MyComponent',

  setup() {
    const message = ref<string>('');

    const fetchData = async () => {
      try {
        const response = await axios.get('http://localhost:3000/hello/world');
        message.value = response.data.message;
      } catch (error) {
        console.error("Error fetching data:", error);
      }
    };

    fetchData();

    return {
      message
    };
  }
});
</script>

<style scoped>
</style>
-->

9.frontend/src/App.vue
<!-- <template>
  <div id="app">
    <HelloWorld />
  </div>
</template>

<script>
import HelloWorld from './components/HelloWorld.vue';

export default {
  name: 'App',
  components: {
    HelloWorld,
  },
};
</script> -->

10.cd frontend

11.npm install

12.npm install axios

13.railsの方に戻って
gem 'rack-cors'
bundle install

14.config/application.rb
<!--

require_relative "boot"

require "rails/all"
require 'rack/cors'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
module YourApplication
  class Application < Rails::Application
    # ...

    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'
        resource '*', headers: :any, methods: [:get, :post, :put, :patch, :delete, :options, :head]
      end
    end

  end
end


-->
を追加

15.一通り済んだら
rails s
と
npm run serve
両方する

＊npm install axiosがダメな場合
cd fronend
npm install -g @vue/cli
rm -rf node_modules
npm install

で再度npm install axios

上がダメなら
npmのキャッシュをクリアする。
npm cache clean --force
npm install axios
それもダメなら
npm config set registry https://registry.yarnpkg.com/
npm install axios
その後以下のコマンドをする。
npm config set registry https://registry.npmjs.org/

これもダメならnpm側の問題の可能性があるので時間が経ったのちに
また上の事を試す。

それで接続確認をしたら
App.vueに
<template>
  <router-view/>
</template>

<style>
</style>

を設定

ルーティングは

import { createRouter, createWebHistory, RouteRecordRaw } from 'vue-router'

const routes: Array<RouteRecordRaw> = [
  {
    // urlのパスの名前
    path: '/',
    // このルート自体の名前
    name: 'HomePage',
    component: () =>
          import ('../views/HomePage.vue'),
  }
]

const router = createRouter({
  history: createWebHistory(process.env.BASE_URL),
  routes
})

export default router

基本フロントでルーティングは回してDBなどに
接続する際にはバックエンドに接続する。


<!-- =================== -->

Rails 7とPostgreSQLをローカルで接続するための手順は以下の通りです。

PostgreSQLのインストール: PostgreSQLがまだインストールされていない場合は、まずインストールします。macOSの場合はHomebrewを使ってインストールすることができます。

brew install postgresql

PostgreSQLの起動: PostgreSQLを起動します。macOSの場合は以下のコマンドで起動できます。

brew services start postgresql
でスタート

psql -U postgres
で中に入る(rootでユーザー名を作っていた気がしたけど気のせいだった)

\l
でdb一覧を見れる。


gem "pg"をgemに記入してbundle installする必要もあるので、意識すること

Railsプロジェクトの作成: PostgreSQLをデータベースとして使用するRailsプロジェクトを作成します。以下のコマンドで作成できます。

rails new myapp --database=postgresql
ここでmyappは作成するアプリケーションの名前です。適宜変更してください。

データベースの設定: 作成したRailsプロジェクトの中にあるconfig/database.ymlファイルを開き、データベースの設定を行います。

default: &default
  adapter: postgresql
  pool: <%= ENV.fetch("RAILS_MAX_THREADS") { 5 } %>
  timeout: 5000
  username: postgres
  host: localhost

development:
  <<: *default
  database: rails_vue3_database

test:
  <<: *default
  database: rails_vue3_database

production:
  <<: *default
  database: rails_vue3_database
データベースの作成: 以下のコマンドでデータベースを作成します。

rails db:create
できてる場合だと

rails cをした後に

ActiveRecord::Base.connection.current_database
で接続確認

その後マイグレーションファイルで

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :email
      t.string :password_digest
      t.integer :age
      t.string :tel
      t.integer :zip
      t.string :pic
      t.string :addr
      t.boolean :delete_flg, default: false
      t.timestamp :login_time
      t.datetime :create_date, default: -> { 'CURRENT_TIMESTAMP' }
      t.timestamp :update_date, default: -> { 'CURRENT_TIMESTAMP' }

      t.timestamps
    end
  end
end

を用意

seedsファイルに
User.create(
  username: 'Test User',
  email: 'test@example.com',
  password_digest: 'password',
  age: 21,
  tel: '123-456-7890',
  zip: 12345,
  pic: 'test.jpg',
  addr: '123 Test Street',
  delete_flg: false,
  login_time: Time.now,
  create_date: Time.now,
  update_date: Time.now
)

を用意。

rails db:migrate

app/models/user.rbに
class User < ApplicationRecord
end
を用意。

rails db:seed

その後rails c
後にUser.allでテストデータ取得で完了

以上で、Rails 7とPostgreSQLの接続が完了します。


場合によっては・・・
rails db:drop
rails db:create
rails db:migrate

もしくは

既存の"users"テーブルを変更する：もし既存の"users"テーブルに対してカラムの追加や削除などの変更を行いたい場合は、create_tableの代わりにchange_tableを使用します。
ruby
Copy code
class ChangeUsers < ActiveRecord::Migration[6.0]
  def change
    change_table :users do |t|
      # ...
    end
  end
end

