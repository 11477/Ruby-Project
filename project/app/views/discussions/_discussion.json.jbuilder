json.extract! discussion, :id, :program_id, :content, :text, :created_at, :updated_at
json.url discussion_url(discussion, format: :json)
