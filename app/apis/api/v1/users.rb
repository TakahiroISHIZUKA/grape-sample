module API
  module V1
    class Users < Grape::API
      helpers do
        # Strong Parametersの設定
        def user_params
          ActionController::Parameters.new(params).permit(:name)
        end

        def set_user
          @user = User.find(params[:id])
        end

        # パラメータのチェック
        params :attributes do
          requires :name, type: String, desc: "User name."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "User id."
        end
      end

      resource :users do
        desc 'GET /api/v1/users', entity: Entity::V1::UsersEntity
        get '/' do
          @users = User.all
          # 定義したエンティティはAPI側で指定する。
          present @users, with: Entity::V1::UsersEntity
        end

        desc 'POST /api/v1/users'
        params do
          use :attributes
        end
        post '/' do
          user = User.new(user_params)
          user.save
        end

        desc 'GET /api/v1/users/:id', entity: Entity::V1::UsersEntity
        params do
          use :id
        end
        get '/:id' do
          set_user
          present @user, with: Entity::V1::UsersEntity
        end

        desc 'PUT /api/v1/users/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_user
          @user.update(user_params)
        end

        desc 'DELETE /api/v1/users/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_user
          @user.destroy
        end
      end
    end
  end
end