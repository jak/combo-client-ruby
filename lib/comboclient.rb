require 'httparty'

class ComboClient
  include HTTParty

  def initialize(host, topic)
    self.class.base_uri "#{host}/topics/#{topic}"
  end

  def facts
    self.class.get("/facts")
  end

  def add(fact)
    self.class.post("/facts", body: fact.to_json, headers: {'Content-Type' => 'application/json'})
  end

  def subscribe
    response = self.class.post("/subscriptions")
    poll_url = response.parsed_response["retrieval_url"]
    manager = ComboClientSubscriptionManager.new
    while manager.is_active? do
      newdata = self.class.get(poll_url)
      if newdata.code == 200
        yield newdata.parsed_response, manager
      end
    end
  end
end

class ComboClientSubscriptionManager
  def initialize
    @active = true
  end
  def cancel
    @active = false
  end

  def is_active?
    @active
  end
end
