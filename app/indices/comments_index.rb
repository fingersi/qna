ThinkingSphinx::Index.define :comment, with: :active_record do
  indexes body
  indexes user.email, as: :user_email

  has user_id, commentable_id, commentable_type, created_at, updated_at

  set_property delta: true
end