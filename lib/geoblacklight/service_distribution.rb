module Geoblacklight

  class ServiceDistribution
    attr_reader :distribution

    def initialize(distribution)
      @distribution = distribution
    end
    ## "{\"accessURL\":\"https://geowebservices.stanford.edu/geoserver/wfs\",\"conformsTo\":\"http://www.opengis.net/def/serviceType/ogc/wfs\",\"format\":[\"Shapefile\",\"GeoJSON\"],\"layerId\":\"druid:cz128vq0535\"}",

    def format
      @distribution.fetch("format", [])
    end

    def title
      @distribution.fetch("title", formats.first)
    end

    def layer_id
      @distribution.fetch("layerId", nil)
    end

    def conforms_to
      @distribution.fetch("conformsTo", nil)
    end

    def endpoint
      @distribution.fetch("accessURL", nil)
    end

    def type ## Rename this possibly?
      Geoblacklight::Constants::URI.key(conforms_to)
    end

    def to_hash
      { type => endpoint }
    end

  end

end