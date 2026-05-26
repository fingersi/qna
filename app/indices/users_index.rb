ThinkingSphinx::Index.define :user, with: :active_record do
  # Индексируемые поля
  indexes email, sortable: true
  
  # Атрибуты
  has admin, type: :boolean
  has created_at, type: :timestamp
end