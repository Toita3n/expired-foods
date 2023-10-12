class LineBotController < ApplicationController
  require 'line/bot'

  protect_from_forgery :except => [:callback]
  
  def callback
    signature = request.env['HTTP_X_LINE_SIGNATURE']
    unless client.validate_signature(body, signature)
      head :bad_request
    end
  end

  def reply_message(event)
    item_name = event.message['text']
    events = client.parse_events_form(body)

    events.each { |event|
      if event.message['text'].include?("#{@item.title}")
        message = {
          type: 'text',
          text: "商品名: #{@item.title}\n総数: #{@item.count}\n賞味期限: #{@item.expired_at}"
        }
      else
        message = {
          type: 'text',
          text: "商品が見つかりませんでした。"
        }
      end
      case event
      when Line::Bot::Event::Message
        case event.type
         when Line::Bot::Event::MessageType::Text
          message = {
            type: 'text',
            text: response
          }
          client.reply_message(event['replyToken'], message)
        end
      end
    }
    head :ok
  end

  def push(user:, message:)
    line_id = user.line_user_id #　LINEのユーザーIDを使用する
    return if line_id.blank?

    client.push_message(line_id, message)
  end

  private

  def client
    @client ||= Line::Bot::Client.new { |config|
      config.channel_secret = ENV["LINE_CHANNEL_SECRET"]
      config.channel_token = ENV["LINE_CHANNEL_TOKEN"]
    }
  end
end