json.text  @comment.text
json.user_nickname  @comment.user.nickname
json.product_id  @comment.product.id
json.date  @comment.created_at.to_s(:comment)
json.id  @comment.id