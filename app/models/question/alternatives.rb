class Question::Alternatives
  include AttrJson::Model

  attr_json :type, :string
  attr_json :identifier, :string
  attr_json :text, :string
  attr_json :image_url, :string, default: ''
  attr_json :bg_color, :string, default: '#808080'
  attr_json :text_color, :string, default: '#000000'
end