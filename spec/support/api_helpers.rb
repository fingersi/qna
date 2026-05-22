module ApiHelpers
  def json
    @json ||= JSON.parse(response.body)
  end

  def sent_request(method, path, option = {})
    send(method, path, option) 
  end

  def check_attrs(json_object, entity, attributes)
    attributes.each do |attr|
      expect(json_object[attr.to_s]).to eq entity.send(attr).as_json
    end
  end
end