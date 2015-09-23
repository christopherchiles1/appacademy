require 'uri'
require 'byebug'

module Phase5
  class Params
    # use your initialize to merge params from
    # 1. query string
    # 2. post body
    # 3. route params
    #
    # You haven't done routing yet; but assume route params will be
    # passed in as a hash to `Params.new` as below:
    def initialize(req, route_params = {})
      if req.query_string
        query_params = parse_www_encoded_form(req.query_string)
      else
        query_params = {}
      end
      @params = query_params.merge(route_params)
    end

    def [](key)
      @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError; end;

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      query_params = {}
      query_items = URI::decode_www_form(www_encoded_form)

      # key_groups = query_items.map { |item| parse_key(item[0]) }
      # vals = query_items.map { |item| item[1] }
      # # now we have keygroups => vals
      query_params = {}
      query_items.each do |item|
        sub_hash = query_params
        sub_keys = parse_key(item[0])
        sub_keys[0...-1].each_with_index do |sub_key|
          unless sub_hash.include?(sub_key)
            sub_hash[sub_key] = {}
          end
          sub_hash = sub_hash[sub_key]
        end
        sub_hash[sub_keys.last] = item[1]
      end
      query_params
    end

    # this should return an array
    # user[address][street] should return ['user', 'address', 'street']
    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

    def

## Recursive hash merging required (think about deep-merge later)
    # def nestify(keys, val)
    #   if keys.length == 1
    #     return { keys.first => val }
    #   else
    #     { keys.first => nestify(keys.drop(1), val) }
    #   end
    # end

  end
end
