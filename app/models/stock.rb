class Stock < ActiveRecord::Base

  include Yahoo
  include StocksHelper

  #has_many :picks
  has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
  has_many :portfolios_stocks
  has_many :histories
  validates :symbol, uniqueness: true
  serialize :ticks, Array

  default_scope { order('symbol ASC') }
  scope :freshest, -> { order(updated_at: :asc)}
  scope :oldest, -> { order(updated_at: :desc)}
  scope :expired, -> {where(["stocks.updated_at < ?", 10.seconds.ago])}

  def self.apply_update(stock, quote)

    stock.assign_attributes(
      averagedailyvolume: quote["AverageDailyVolume"],
      change: quote["Change"],
      dayslow: quote["DaysLow"],
      dayshigh: quote["DaysHigh"],
      yearlow: quote["YearLow"],
      yearhigh: quote["YearHigh"],
      marketcapitalization: quote["MarketCapitalization"],
      lasttradepriceonly: quote["LastTradePriceOnly"],
      daysrange: quote["DaysRange"],
      name: quote["Name"],
      symbol: quote["Symbol"],
      volume: quote["Volume"],
      lasttradedate: quote["LastTradeDate"],
      lasttradetime: quote["LastTradeTime"],
      stockexchange: quote["StockExchange"]
    )

  end

  def self.quote_update(stocks)

    @stocks = Array.wrap(stocks)
    @symbol_array = @stocks.map(&:symbol)
    @quote = Yahoo::YQLFinance.new.find_quote(@symbol_array).output
    @quotes = Array.wrap(@quote)

    @stocks.each_with_index do |stock, i|
      Stock.apply_update(stock, @quotes[i]) if stock.id.nil? || stock.lasttradedate <= @quotes[i]["LastTradeDate"] && stock.lasttradetime < @quotes[i]["LastTradeTime"]
    end

  end

  def self.add_update_stock stock_params

    Stock.find_or_initialize_by(stock_params) do |new_stock|
      new_stock.class.quote_update(new_stock)
    end
  end

  def self.from_dummy
    @tickers = ["AAL", "AAPL", "ADBE", "ADI", "ADP", "ADSK", "AKAM", "ALXN", "AMAT", "AMGN", "AMZN", "ATVI", "BBBY", "BIDU", "BIIB", "BMRN", "CA", "CELG",
                "CERN", "CHKP", "CHTR", "CMCSA", "COST", "CSCO", "CSX", "CTRP", "CTSH", "CTXS", "DISCA", "DISCK", "DISH", "DLTR", "EA", "EBAY", "ENDP", "ESRX", "EXPE",
                "FAST", "FB", "FISV", "FOX", "FOXA", "GILD", "GOOG", "GOOGL", "HSIC", "INCY", "INTC", "INTU", "ILMN", "ISRG", "JD", "KHC", "LBTYA", "LBTYK", "LLTC",
                "LMCA", "LRCX", "LVNTA", "MAR", "MAT", "MDLZ", "MNST", "MSFT", "MU", "MXIM", "MYL", "NCLH", "NFLX", "NTAP", "NVDA", "NXPI", "ORLY", "PAYX", "PCAR", "PCLN",
                "PYPL", "QCOM", "QVCA", "REGN", "ROST", "SBAC", "SBUX", "SIRI", "SNDK", "SRCL", "STX", "SWKS", "SYMC", "TMUS", "TSCO", "TSLA", "TRIP", "TXN", "ULTA", "VIAB",
                "VOD", "VRSK", "VRTX", "WBA", "WDC", "WFM", "XLNX", "YHOO"]

    dummy_stock = self.add_update_stock(
      :symbol => @tickers.sample
    )
  end

end
