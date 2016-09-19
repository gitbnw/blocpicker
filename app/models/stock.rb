class Stock < ActiveRecord::Base

  include Yahoo
  include StocksHelper

  #has_many :picks
  has_and_belongs_to_many :portfolios, -> { uniq } #, through: :picks
  has_many :portfolios_stocks
  has_many :histories
  validates :symbol, uniqueness: true
  validates :lasttradepriceonly, presence: true, allow_blank: false
  serialize :ticks, Array

  default_scope { order('symbol ASC') }
  scope :freshest, -> { order(updated_at: :asc)}
  scope :oldest, -> { order(updated_at: :desc)}
  scope :expired, -> {where(["stocks.updated_at < ?", 30.seconds.ago])}

  def self.apply_update(stock, quote)

    stock.assign_attributes(
      averagedailyvolume: quote["AverageDailyVolume"],
      change: quote["Change"],
      dayslow: quote["Low"],
      dayshigh: quote["High"],
      # yearlow: quote["YearLow"],
      # yearhigh: quote["YearHigh"],
      marketcapitalization: quote["MarketCap"],
      lasttradepriceonly: quote["LastPrice"],
      # daysrange: quote["DaysRange"],
      name: quote["Name"],
      symbol: quote["Symbol"],
      volume: quote["Volume"],
      timestamp: quote["Timestamp"],
      # lasttradetime: quote["LastTradeTime"],
      # stockexchange: quote["StockExchange"]
    )

    return stock
    
  end
  
  def self.quote_update_single(stock)
    @mquote = Markit::MarkitFinance.new.find_quote(stock.symbol).output

    if @mquote.success? && @mquote["Error"].nil?
      puts 'successful response and no error'
      @yquote = Yahoo::YQLFinance.new.find_quote(Array.wrap(stock.symbol)).output
      @mquote["StockQuote"]["AverageDailyVolume"] = @yquote["AverageDailyVolume"]
      @updated_stock = Stock.apply_update(stock, @mquote["StockQuote"])
    end
    
    return @updated_stock
  end


  def self.quote_exists stock


  
  end

  def self.add_update_stock stock_params

    Stock.find_or_initialize_by(stock_params) do |new_stock|
      
      new_stock.class.quote_update_single(new_stock) #if the stock doesn't exist I get a quote for it.  if the quote fails...
      
    end
    
  end

  def self.from_dummy
    @tickers = ["AAL", "AAPL", "ADBE", "ADI", "ADP", "ADSK", "AKAM", "ALXN", "AMAT", "AMGN", "AMZN", "ATVI", "BBBY", "BIDU", "BIIB", "BMRN", "CA", "CELG",
                "CERN", "CHKP", "CHTR", "CMCSA", "COST", "CSCO", "CSX", "CTRP", "CTSH", "CTXS", "DISCA", "DISCK", "DISH", "DLTR", "EA", "EBAY", "ENDP", "ESRX", "EXPE",
                "FAST", "FB", "FISV", "FOX", "FOXA", "GILD", "GOOG", "GOOGL", "HSIC", "INCY", "INTC", "INTU", "ILMN", "ISRG", "JD", "KHC", "LBTYA", "LBTYK", "LLTC",
                "LMCA", "LRCX", "LVNTA", "MAR", "MAT", "MDLZ", "MNST", "MSFT", "MU", "MXIM", "MYL", "NCLH", "NFLX", "NTAP", "NVDA", "NXPI", "ORLY", "PAYX", "PCAR", "PCLN",
                "PYPL", "QCOM", "QVCA", "REGN", "ROST", "SBAC", "SBUX", "SIRI", "SNDK", "SRCL", "STX", "SWKS", "SYMC", "TMUS", "TSCO", "TSLA", "TRIP", "TXN", "ULTA", "VIAB",
                "VRSK", "VRTX", "WBA", "WDC", "WFM", "XLNX", "YHOO"]

    dummy_stock = self.add_update_stock(
      :symbol => @tickers.sample
    )
  end

end
