# ====================================
#  Get any solr query into a csv file
#  Whats needed?
#   1. fields you want in your csv (as an array in field names in solr)
#   2. the solr query string.
#       e.g. 'http://solr:8983/solr/users/select?fq=status_s%3A+active&rows=2000&fl=username_s%2C+email_s%2C+created_at_dt%2C+orders_count_i&wt=json&indent=true'
# ===================================

# Input
csv_fields = ['username_s', 'email_s', 'created_at_dt', 'orders_count_i']
solr_query = ARGV[0]


# Gems
require 'csv'
require 'rest-client'
require 'byebug'

# Constants
FILENAME   = 'results.csv'

solr_query = 

# Get response
res = RestClient.get solr_query
results = JSON.parse(res.body)['response']['docs']

count = 0

CSV.open(FILENAME, 'w' ) do |writer|
  # Header
  writer << csv_fields

  # Data
  results.each do |r|
    writer << csv_fields.map { |field| r[field] }
    puts "Processed #{count}" if (count+=1)%100==0
  end
end
