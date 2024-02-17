# require 'csv'


# CSV.foreach('db/category.csv') do |row|
#     # レコードが既に存在しているか確認する必要があるので、idで検索
#     # いきなりcreate!しない
#     category = Category.find_by(id: row[0])
  
#     # レコードがないので新規
#     unless category
#       category = Category.new
#     end
  
#     # id以外の値を設定して
#     category.attributes = {
#        name: row[1], ancestry: row[2]
#     }
#     # 保存
#     category.save!
# end