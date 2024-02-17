require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest

    def setup
        @article = articles(:one) # => test/fixtures/articles.umlと連動。params[:id]は、
    end

    test "サイトのリンクを確かめる" do
        get root_path
        assert_template "/"
        assert_select "a[href=?]", show_article_path(@article)
        assert_select "a[href=?]", delete_article_path(@article)
        assert_select "a[href=?]", edit_article_path(@article)
    end
end
