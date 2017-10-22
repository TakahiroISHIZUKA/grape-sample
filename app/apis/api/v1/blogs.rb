module API
  module V1
    class Blogs < Grape::API
      version 'v1'
      helpers do
        # Strong Parametersの設定
        def blog_params
          ActionController::Parameters.new(params).permit(:user_id, :title, :body)
        end

        def set_blog
            @blog = Blog.find(params[:id])
        end

        # パラメータのチェック
        params :attributes do
          requires :user_id, type: Integer, desc: "User id."
          requires :title, type: String, desc: "Blog title."
          optional :body, type: String, desc: "Blog body."
        end

        # パラメータのチェック
        params :id do
          requires :id, type: Integer, desc: "Blog id."
        end
      end

      resource :blogs do
        desc 'GET /api/v1/blogs', entity: Entity::V1::BlogsEntity
        get '/' do
          @blogs = Blog.all
          # 定義したエンティティはAPI側で指定する。
          present @blogs, with: Entity::V1::BlogsEntity
        end

        desc 'POST /api/v1/blogs'
        params do
          use :attributes
        end
        post '/' do
          blog = Blog.new(blog_params)
          blog.save
        end

        desc 'GET /api/v1/blogs/:id', entity: Entity::V1::BlogsEntity
        params do
          use :id
        end
        get '/:id' do
          set_blog
          present @blog, with: Entity::V1::BlogsEntity
        end

        desc 'PUT /api/v1/blogs/:id'
        params do
          use :id
          use :attributes
        end
        put '/:id' do
          set_blog
          @blog.update(blog_params)
        end

        desc 'DELETE /api/v1/blogs/:id'
        params do
          use :id
        end
        delete '/:id' do
          set_blog
          @blog.destroy
        end
      end
    end
  end
end