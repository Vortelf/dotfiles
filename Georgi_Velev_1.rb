require 'csv'

people = Hash.new

tmp = Hash.new

covered = "False"

CSV.foreach(ARGV[0]) do |row|
  covered = "False"
  tmp['income'] = row[1].to_i
  tmp['outcome'] = row[2].to_i
  tmp['date'] = row[3]
  total = row[1].to_i + row[2].to_i
  tmp['total'] = total
  if total == ARGV[1].to_i
    covered = "True"
  end
  tmp['covered'] = covered

  people[row[0]] = tmp;
  tmp = Hash.new

end

CSV.open(ARGV[0].split(/\//).last.split('.').first+"_result.csv","w") do |csv|

    people.sort_by { |person, info| info[:total] }
    people.each do |person , info|
  			csv << [person, info['covered'], info['total']]
    end

end
