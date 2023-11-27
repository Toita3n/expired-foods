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
      item = user.items.find_by(title: text)
      # 商品情報を返信
      if item
        message = {
          type: 'text',
          text: "商品名: #{item.title}\n数量: #{item.count}\n賞味期限: #{item.expired_at.strftime('%Y-%m-%d')}\n概要: #{item.detail}"
        }
        client.reply_message(event['replyToken'], message)
      else
        message = {
          type: 'text',
          text: '該当する商品がありません'
        }
      end

      response = client.reply_message(event['replyToken'], message)
    else
      if response[:status] != 200
        puts 'failed to reply to the messages'
      end
    end
  end
end