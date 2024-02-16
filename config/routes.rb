Rails.application.routes.draw do
    root "articles#index"
    # resources :articles

    # GET    /articles             # 記事一覧を表示するためのページ
    # GET    /articles/new         # 新しい記事を作成するためのフォームを表示するページ
    # POST   /articles             # 新しい記事を作成するためのアクション
    # GET    /articles/:id         # 特定の記事を表示するためのページ
    # GET    /articles/:id/edit    # 特定の記事を編集するためのフォームを表示するページ
    # PATCH  /articles/:id         # 特定の記事を更新するためのアクション
    # DELETE /articles/:id         # 特定の記事を削除するためのアクション

    get    "/new",           to: "articles#new",      as: "new_article"
    post   "/create",        to: "articles#create",   as: "create_article"

    get    "/:id",           to: "articles#show",     as: "show_article"
    get    "/:id/edit",      to: "articles#edit",     as: "edit_article"
    patch  "/update/:id",    to: "articles#update",   as: "update_article"

    delete "delete/:id",     to: "articles#destroy",  as: "delete_article"
    
end
