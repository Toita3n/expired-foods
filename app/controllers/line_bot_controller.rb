class LineBotController < ApplicationController
  require 'line/bot'  # gem 'line-bot-api'
  skip_before_action :require_login
  protect_from_forgery except: [:callback]

  def callback
    body = request.body.read

    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end

    events = client.parse_events_from(body)

    events.each { |event|
      userId = event['source']['UserId']
      case event
      when Line::Bot::Event::Message
        case event.type
        when Line::Bot::Event::MessageType::Text
          item_text_message(event)
        end
      end
    }
    head :ok
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end

  def item_text_message(event)
    user = User.find_by(uid: event['source']['userId'])

    if user && user.uid.present?
      text = event.message['text']

      if text == '冷蔵庫'
        # Display information about all items
        all_items_message(user, event)
      else
        # Display information about a specific item
        specific_item_message(user, text, event)
      end
    else
      message = {
        type: 'text',
        text: 'ユーザーが見つかりませんでした'
      }
      client.reply_message(event['replyToken'], message)
    end
  end

  def all_items_message(user, event)
    items = user.items
    if items.present?
      message_text = "ユーザーのアイテム一覧:\n"
      items.each do |item|
        message_text += "商品名: #{item.title}\n数量: #{item.count}\n賞味期限: #{item.expired_at.strftime('%Y-%m-%d')}\n\n"
      end
    else
      message_text = 'アイテムが見つかりませんでした'
    end

    message = {
      type: 'text',
      text: message_text
    }
    client.reply_message(event['replyToken'], message)
  end

  def specific_item_message(user, text, event)
    item = user.items.find_by(title: text)

    if item
      message = {
        type: 'text',
        text: "商品名: #{item.title}\n数量: #{item.count}\n賞味期限: #{item.expired_at.strftime('%Y-%m-%d')}"
      }
    else
      message = {
        type: 'text',
        text: '該当する商品がありません'
      }
    end

    client.reply_message(event['replyToken'], message)
  end
end