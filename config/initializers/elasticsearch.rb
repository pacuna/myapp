# Connect to specific Elasticsearch cluster
# ELASTICSEARCH_URL = ENV['MYAPP_ES_PORT_9200_TCP_ADDR'] || ENV['ELASTICSEARCH_PORT_9200_TCP_ADDR']

Elasticsearch::Model.client = Elasticsearch::Client.new host: 'http://elasticsearch:9200'

# Print Curl-formatted traces in development into a file
#
if Rails.env.development?
  tracer = ActiveSupport::Logger.new('log/elasticsearch.log')
  tracer.level =  Logger::DEBUG
end

Elasticsearch::Model.client.transport.tracer = tracer
