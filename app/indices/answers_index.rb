ThinkingSphinx::Index.define :answer, with: :active_record do
  indexes body
  indexes author.email, as: :author_email
  indexes question.title, as: :question_title

  has question_id, author_id, best, created_at, updated_at
  
  set_property delta: true
end

