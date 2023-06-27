class CreateBlogUpdateView < ActiveRecord::Migration[7.0]
  def change
    execute "
    CREATE VIEW blog_updates as
    SELECT p.id as id, p.body as body, p.student_id as student_id
    FROM posts p

    UNION ALL

    SELECT pc.id as id, pc.comment as body, pc.author_id as student_id
    FROM post_comments pc
    "
  end
end
