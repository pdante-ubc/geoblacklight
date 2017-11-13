module Geoblacklight
  class ItemViewer
    def initialize(distributions)
      @distributions = distributions
    end

    def viewer_protocol
      return 'map' if viewer_preference.nil?
      viewer_preference.keys.first.to_s
    end

    def viewer_endpoint
      return '' if viewer_preference.nil?
      viewer_preference.values.first.to_s
    end

    def wms
      @distributions.wms
    end

    def iiif
      @distributions.iiif
    end

    def tiled_map_layer
      @distributions.tiled_map_layer
    end

    def dynamic_map_layer
      @distributions.dynamic_map_layer
    end

    def feature_layer
      @distributions.feature_layer
    end

    def image_map_layer
      @distributions.image_map_layer
    end

    def viewer_preference
      [wms, iiif, tiled_map_layer, dynamic_map_layer,
       image_map_layer, feature_layer].compact.map(&:to_hash).first
    end
  end
end
