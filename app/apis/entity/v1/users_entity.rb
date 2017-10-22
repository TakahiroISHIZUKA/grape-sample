module Entity
  module V1
    class UsersEntity < Grape::Entity
      # {"message_boards":[]}
      # {"message_board":{} }
      # というJSON出力になります。
      root 'users', 'user'

      expose :id, :name
      # 値を加工することができる。
      expose :updated_at do |user, options|
        user.updated_at.strftime("%Y-%m-%d %H:%M:%S")
      end
    end
  end
end
