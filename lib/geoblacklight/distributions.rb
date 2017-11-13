module Geoblacklight
  class Distributions
    attr_reader :distributions, :distribution_field
    def initialize(document, distribution_field = Settings.FIELDS.DISTRIBUTIONS)
      @document = document
      @distribution_field = distribution_field
    end

    def download_distributions
      distribution_hash.select { |dist| dist.key?("downloadURL")}.map { |dist| DownloadDistribution.new(dist)}
    end

    def service_distributions
      distribution_hash.select { |dist| dist.key?("accessURL")}.map { |dist| ServiceDistribution.new(dist)}
    end

    private

    def distribution_hash
      @distribution_hash ||= @document[distribution_field].map { |dist| JSON.parse(dist) }
    end

    def distributions(dist_type)
      service_distributions.find { |distribution| distribution.type == dist_type }
    end

    ##
    # Adds a call to references for defined URI keys
    def method_missing(m, *args, &b)
      if Geoblacklight::Constants::URI.key?(m)
        distributions m
      else
        super
      end
    end

  end
end