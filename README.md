# Average Price Per Bitcoin

Simple ruby script to find your average price per bitcoin.

## Usage

1. Log into https://coinbase.com/reports
2. Click New Report. Select your wallet, and under Type select **'Buys, sells, and merchant payouts'**. Select your desired date range.
3. Rename the downloaded csv something sane like `cb.csv`
4. In terminal, run 
    `ruby coinbase_transaction_parser.rb`
5. (Optional) When prompted, input how many BTC for which to calculate
6. When prompted, input your csv filename from step 3 (or the path to it if the ruby file and the csv file are in different directories)

## Example
```shell
$ ruby coinbase_transaction_parser.rb
(1/2) For how many BTC would you like to calculate? (0 or Enter to calculate automatically)

(2/2) Input CSV filename (if in current directory) or the path to it
cb.csv

      Transactions read: 16
      Amount bought: 4.315 BTC for $3399.56
      Amount sold: 1.68 BTC for $1181.18
      Subtotal: $2218.38
      Commissions: $48.20

      Total: $2266.58

      Your average price per Bitcoin: $860.18
```

## Extras

You may edit `coinbase_transaction_parser.rb` to add a third parameter to the class instance. This third parameter accepts a "cash bonus" amount, which you may use if you bought BTC on Coinbase, but traded someone BTC for cash. Otherwise, BTC will believe you have paid for that BTC even if it doesn't exist in your wallet, inflating your average price per bitcoin.