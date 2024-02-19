module ApplicationHelper
  def page_title(page_title = '', admin = false)
    base_title = if admin
                   'EXPIRED_FOODS(管理画面)'
                 else
                   'EXPIRED_FOODS'
                 end
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def active_if(path)
    path == controller_path ? 'active' : ''
  end

  def default_meta_tags
    {
      site: 'expired-foods',
      title: '食材の賞味期限切れを防止するサービス',
      reverse: true,
      separator: '|', # Webサイト名とページタイトルを区切るために使用されるテキスト
      description: '賞味期限切れをなくそう！',
      keywords: '食材,賞味期限', # キーワードを「,」区切りで設定する
      canonical: request.original_url, # 優先するurlを指定する
      noindex: ! Rails.env.production?,

      og: {
        site_name: :site,
        title: :title,
        description: :description, 
        type: 'website',
        url: request.original_url,
        image: image_url('top.jpg'),
        locale: 'ja_JP',
      },

      twitter: {
         card: 'summary_large_image',
         image: image_url('top.jpg'),
      },
    }
  end
end
