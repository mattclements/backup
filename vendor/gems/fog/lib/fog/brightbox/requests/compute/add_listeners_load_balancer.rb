module Fog
  module Compute
    class Brightbox
      class Real
        # Adds a number of listeners to the load balancer to enable balancing across nodes for those settings.
        #
        # @param [String] identifier Unique reference to identify the resource
        # @param [Hash] options
        # @option options [Array] :listeners Array of Listener parameters. Timeout is optional and specified in milliseconds.
        #
        # @return [Hash, nil] The JSON response parsed to a Hash or nil if no options passed
        #
        # @see https://api.gb1.brightbox.com/1.0/#load_balancer_add_listeners_load_balancer
        #
        def add_listeners_load_balancer(identifier, options)
          return nil if identifier.nil? || identifier == ""
          request("post", "/1.0/load_balancers/#{identifier}/add_listeners", [202], options)
        end

      end
    end
  end
end