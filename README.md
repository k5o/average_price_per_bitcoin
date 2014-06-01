# Average Price Per Bitcoin

Simple ruby script to find your average price per bitcoin.

## Installation
[Download](https://github.com/heyimkko/average_price_per_bitcoin/archive/master.zip) or clone the repository.

## Usage

1. Log into https://coinbase.com/reports
2. Click New Report. Select your wallet, and under Type select **'Buys, sells, and merchant payouts'**. Select your desired date range.
3. (Optional) Rename the downloaded csv something sane like `cb.csv`
4. In terminal, run 
    `ruby coinbase_transaction_parser.rb`
5. When prompted, input your csv filename from step 3 (or the path to it if the ruby file and the csv file are in different directories)

## Example
```shell
$ ruby coinbase_transaction_parser.rb
Input CSV filename (if in current directory) or the path to it
cb.csv

      Transactions read: 16
      Amount bought: 10.00 BTC for $2500.55
      Amount sold: 7.50 BTC for $2250.25
      Bitcoin: 2.50 BTC
      Subtotal: $250.30
      Commissions: $12.25

      Total: $262.55

      Your average price per Bitcoin: $105.02
```

## Extras

You may edit `coinbase_transaction_parser.rb` to add a third parameter to the class instance. This third parameter accepts a "cash bonus" amount, which you may use if you bought BTC on Coinbase, but traded someone BTC for cash. Otherwise, BTC will believe you have paid for that BTC even if it doesn't exist in your wallet, inflating your average price per bitcoin.

If this is edited, you will also be prompted to input the correct BTC amount to calculate for as well.

## Contact

Contact me via http://www.kokev.in for any comments or suggestions

Happily accepting modest BTC tips [here](https://coinbase.com/kko)