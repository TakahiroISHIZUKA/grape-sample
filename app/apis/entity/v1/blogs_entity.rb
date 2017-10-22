module Entity
  module V1
    class BlogsEntity < Grape::Entity
      
      root 'blogs', 'blog'

      expose :id, documentation: { desc: 'id', type: 'number' }
      expose :title, documentation: { desc: 'タイトル', type: 'string' }
      expose :body, documentation: { desc: '本文', type: 'string' }
      # 値を加工することができる。
      expose :updated_at , documentation: { desc: '更新日時', type: 'datetime' } do |blog, options|
        blog.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      end
      
      # 他のEntityの定義を使うことができる。
      expose :user, using: 'Entity::V1::UsersEntity', as: :auther
    end
  end
end
