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
      quote_params = {}
      if req.query_string
        quote_params = parse_www_encoded_form(req.query_string)
      end
      post_params = {}
      if req.body
        post_params = parse_www_encoded_form(req.body)
      end
      @params = quote_params
                  .merge(post_params)
                  .merge(route_params)
    end

    def [](key)
      @params[key.to_s]
    end

    # this will be useful if we want to `puts params` in the server log
    def to_s
      @params.to_s
    end

    class AttributeNotFoundError < ArgumentError
    end

    private
    # this should return deeply nested hash
    # argument format
    # user[address][street]=main&user[address][zip]=89436
    # should return
    # { "user" => { "address" => { "street" => "main", "zip" => "89436" } } }
    def parse_www_encoded_form(www_encoded_form)
      hash_pairs = parse_hash_pairs(www_encoded_form)
      create_hash_from_hash_pairs(hash_pairs)
    end

    def parse_hash_pairs(www_encoded_form)
      URI::decode_www_form(www_encoded_form)
    end

    def parse_key(key)
      key.split(/\]\[|\[|\]/)
    end

    def create_hash_from_hash_pairs(hash_pairs)
      result = {}
      hash_pairs.each do |hash_pair|
        denestify_hash_pair_into_hash!(hash_pair, result)
      end
      result
    end

    def denestify_hash_pair_into_hash!(hash_pair, hash)
      key, val = hash_pair
      key_list = parse_key(key)
      sub_hash = hash # start at top of hash
      last_key = key_list.pop
      key_list.each do |key|
        sub_hash[key] = {} unless sub_hash.include?(key)
        sub_hash = sub_hash[key] # go deeper into hash
      end
      sub_hash[last_key] = val # set value at the bottom of hash
      hash
    end

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
