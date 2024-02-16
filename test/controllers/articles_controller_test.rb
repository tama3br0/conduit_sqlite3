require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest

    def setup
        @article = Article.create(title: "Test Article", subtitle: "Test Subtitle", body: "This is a test article.")
    end

    test "indexページが表示されるはずだ" do
        get root_path
        assert_response :success
    end

    test "newページが表示されるはずだ" do
        get new_article_path
        assert_response :success
    end

    test "記事が投稿されるはずだ" do
        assert_difference "Article.count", 1 do
            post create_article_path, params: {article: {title: "New Article", subtitle: "New Subtitle", body: "This is a new article." }}
        end
        follow_redirect!
        assert_template "articles/index" # 遷移先のviewテンプレートのパス
    end

    test "showページが表示されるはずだ" do
        get show_article_path(@article)
        assert_response :success
    end

    test "editページが表示されるはずだ" do
        get edit_article_path(@article)
        assert_response :success
    end

    test "記事が更新されるはずだ" do
        patch update_article_path(@article.id), params: { article: { title: "Updated Article" } }
        assert_redirected_to root_path
        @article.reload
        assert_equal "Updated Article", @article.title
    end

    # test "記事が更新されるはずだ" do　～こんな風にも書けます～
    #     patch update_article_path(@article.id), params: { article: { title: "Updated Article" } }
    #     assert_redirected_to show_article_path(@article.reload)
    #     @article.reload
    #     assert_equal "Updated Article", @article.title
    # end

    test "記事が削除されるはずだ" do
        assert_difference "Article.count", -1 do
            delete delete_article_path(@article.id)
        end
        follow_redirect!
        assert_template "articles/index"
    end

    # test "記事が削除されるはずだ" do ～こんな風にも書けます～
    #     assert_difference 'Article.count', -1 do
    #       delete delete_article_path(@article.id)
    #     end
    #     assert_redirected_to root_path
    # end
end
