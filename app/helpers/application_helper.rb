module ApplicationHelper
    def full_title(page_title = '')     # 引数にpage_titleというものがあればそれを使う、なければ空のまま使う、
        base_title = "Conduit under development with APPRENTICE"
        if page_title.empty?            # もし追加タイトルが空だったら
            base_title                  # base_titleだけを返す
        else
            "#{page_title} | #{base_title}"
        end
    end
end
