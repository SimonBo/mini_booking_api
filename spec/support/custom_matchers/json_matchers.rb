RSpec::Matchers.define :be_json_api_response_for do |model|
  match do |actual|
    parsed_actual = JSON.parse(actual)

    if parsed_actual['data'].is_a?(Array)
      parsed_actual['data'].map { |h| h['type']}.uniq == [model] &&
      parsed_actual['data'].map { |h| h['attributes']}.all?{|a| a.is_a?(Hash)}
    else
      parsed_actual.dig('data', 'type') == model &&
      parsed_actual.dig('data', 'attributes').is_a?(Hash)
    end
  end
end

RSpec::Matchers.define :have_jsonapi_errors_for do |pointer|
  match do |actual|
    parsed_actual = JSON.parse(actual)
    errors = parsed_actual['errors']
    return false if errors.empty?
    errors.any? do |error|
      error.dig('source', 'pointer') == pointer
    end
  end
end
