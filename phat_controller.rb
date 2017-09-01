class PriceStatsController
  CONVERSION_RATES = { '$' => 0.92, '€' => 1 }
  def get_values_and_convert_in_euros_and_calculate_average_price
    CatalogEntryModel.select(:price).map do |row|
      # Price stored as '$15' or '€0.35'
      currency = row['price'][0]
      rate = CONVERSION_RATES[currency]
      price = Float(row['price'][1..-1])
      rate * price
    end.sum / CatalogEntryModel.count
  end
end
