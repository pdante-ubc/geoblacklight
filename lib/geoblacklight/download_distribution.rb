module Geoblacklight

  class DownloadDistribution
    attr_reader :distribution

    def initialize(distribution)
      @distribution = distribution
    end
    ## {\"downloadURL\":\"http://stacks.stanford.edu/file/druid:cz128vq0535/data.zip\",\"format\":[\"Shapefile\"],\"mediaType\":\"application/zip\",\"title\":\"Shapefile\"}

    def format
      @distribution.fetch("format", [])
    end

    def title
      @distribution.fetch("title", formats.first)
    end

    def media_type
      @distribution.fetch("mediaType", nil)
    end

    def endpoint
      @distribution.fetch("downloadURL", nil)
    end

  end

end