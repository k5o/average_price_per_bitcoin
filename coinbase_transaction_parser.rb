require 'csv'

class CoinbaseTransactionParser
  def initialize(btc_amount, csv_name, cash_bonuses = 0)
    @commissions = 0.00
    @buys = 0.00
    @sells = 0.00
    @count = 0
    @btc_bought = 0.00
    @btc_sold = 0.00
    @currency = ''
    @btc_amount = btc_amount
    @csv = File.read(csv_name)
    @cash_bonuses = cash_bonuses # Optional param, see footnote at bottom
  end

  def run!
    CSV.parse(@csv) do |row|
      next if row.length != 11 # Skip irrelevant csv data from report generation

      timestamp = row[0]
      transaction_type = row[1]
      btc = row[2]
      subtotal = row[3]
      fee = row[4]
      currency = row[6]
      price_per_coin = row[7]

      @count += 1

      if transaction_type == "Buy"
        @buys += subtotal.to_f
        @btc_bought += btc.to_f
      else
        @sells += subtotal.to_f
        @btc_sold += btc.to_f
      end

      @commissions += fee.to_f
    end

    to_s
  end

  def user_total
    '%.2f' % (@buys - @sells)
  end

  def buys
    '%.2f' % @buys
  end

  def sells
    '%.2f' % @sells
  end

  def commissions
    '%.2f' % @commissions
  end

  def total
    '%.2f' % (user_total.to_f + @commissions)
  end

  def total_btc
    # Use coinbase-derived default amount, or use specified amount
    @btc_amount == 0 || @btc_amount.to_s.blank? ? @btc_bought - @btc_sold : @btc_amount
  end

  def ppc
    raw = total.to_f - @cash_bonuses
    btc = total_btc.to_f

    '%.2f' % (raw / btc)
  end

  def to_s
    puts """
      Transactions read: #{@count}
      Amount bought: #{@btc_bought} BTC for $#{buys}
      Amount sold: #{@btc_sold} BTC for $#{sells}
      Subtotal: $#{user_total}
      Commissions: $#{commissions}

      Total: $#{total}

      Your average price per Bitcoin: $#{ppc}
    """
  end
end

puts "(1/2) For how many BTC would you like to calculate? (0 or Enter to calculate automatically)"
gets_btc_amount = gets.chomp.to_f
puts "(2/2) Input CSV filename (if in current directory) or the path to it"
gets_file_name = gets.chomp

ctp = CoinbaseTransactionParser.new(gets_btc_amount, gets_file_name, 0)
ctp.run!

# CoinbaseTransactionParser takes an optional 3rd parameter:
# cash_bonuses = If you bought BTC off coinbase but sent some to another user for cash, input how much cash here (e.g. 481.40)
# Otherwise, Coinbase will think you own this BTC even if you don't reflect it in the gets_btc_amount input, increasing your average PPC
