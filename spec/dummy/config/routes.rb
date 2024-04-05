Rails.application.routes.draw do
  mount Transliteration::Engine => "/transliteration"
end
