class Application

  @@items = []

  def self.items
    @@items
  end

  def self.find_item_by_name(some_name)
    self.items.find do |item|
      item.name == some_name
    end
  end

  def call(env)
    resp = Rack::Response.new
    req = Rack::Request.new(env)

    if req.path.match(/items/)
      req_item = Application.find_item_by_name(req.path.split("/items/").last)
      if Application.items.include?(req_item)
        resp.write req_item.price
      else
        resp.write "Item not found"
        resp.status = 400
      end
    else
      resp.write "Route not found"
      resp.status = 404
    end
    resp.finish
  end
end
