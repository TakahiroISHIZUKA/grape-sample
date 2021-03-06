module API
  class Base < Grape::API
    mount V1::Base
    # swagger doc
    add_swagger_documentation(
      info: {
        title: "APIドキュメント",
        description: "APIリファレンスをswaggerで作ってみました。"
      }
    )
  end
end