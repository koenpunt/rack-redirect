require "rack"
require "rack/redirect/version"

module Rack
  class Redirect

    def initialize(app, pairs, status = 302)
      @app = app
      @pairs = pairs
      @status = status
    end

    def call(env)
      request = Rack::Request.new(env)
      @pairs.each do |pattern, target|
        next unless request_matches?(request, pattern)
        uri = URI.parse(target)
        target_params = parse_query(uri.query)
        request_params = parse_query(request.query_string)
        query = build_query(merge_params(request_params, target_params))
        uri.query = query if query.present?
        return [status, { 'Location' => uri.to_s }, ['']]
      end
      @app.call(env)
    end

    protected

      def status
        @status
      end

      def parse_query(query)
        Rack::Utils.parse_nested_query(query)
      end

      def build_query(params)
        Rack::Utils.build_nested_query(params)
      end

      def merge_params(request_params, target_params)
        target_params.merge(request_params)
      end

      def request_matches?(request, pattern)
        if pattern.is_a?(Regexp)
          request.path =~ pattern
        elsif pattern.is_a?(String)
          request.path == pattern
        elsif pattern.is_a?(Symbol)
          request.path == pattern.to_s.downcase
        else
          false
        end
      end

  end
end
