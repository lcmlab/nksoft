# encoding: UTF-8
class TimeDefValidator < ActiveModel::Validator

  def validate(record)
    if record.send(options[:val2]) < record.send(options[:val1]) 
       record.errors[:base] << "#{options[:val2]} must be greater than #{options[:val1]}" + "（終了時刻は開始時刻よりも大きくなければいけません。）"
    end
  end
end
