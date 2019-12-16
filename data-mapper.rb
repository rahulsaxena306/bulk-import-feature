
require "rubygems"
require "json"
# Array of JSONs
jsonArray = [
  {
  "Column" => "Col1",
  "data-type" => "Integer",
  "data-field" => "patient-reg-number"
},
{
  "Column" => "Col2",
  "data-type" => "Integer",
  "data-field" => "patient-age"
},
{
  "Column" => "Col3",
  "data-type" => "String",
  "data-field" => "patient-name"
} ]


csvData = [ [75, 46, "John Doe"],
            [115, "72", "Greg Smith"],
            [101, 67, "Alice Jones"]]



# Given a jsonArray and a CSV Row, validate the row against the
# data field values present in jsonArray

def wrapper(jsonArray, csvData)

  outputArr = []
  failureArr = []

  for csvRow in csvData
    if dataFieldMapper(failureArr, outputArr, jsonArray, csvRow) == false
      print failureArr

      puts
      # puts "random string."
    else
      puts "Data Mapping for #{csvRow} succeeded."
    end
  end

  print outputArr

end

def dataFieldMapper (failureArr, outputArr, jsonArray, csvRow)


  jsonArray.each_with_index{ |json, index|
    if validator(json, index, csvRow) == false
      # puts "Mapping for row = #{csvRow} and index = #{index} failed"
      failureArr << Time.now.to_s + " Mapping for row = #{csvRow} and Column = " + (index + 1).to_s + " failed "
      return false
    end
    }

    outputArr <<  hashCreator(jsonArray, csvRow)
    return true

  end


def hashCreator (jsonArray, csvRow)

  dataFields = []
  jsonArray.each_with_index { |json, index|
    dataFields.push(json["data-field"])
  }
  arrayMapper(dataFields, csvRow)


end

def arrayMapper (dataFields, csvRow)

  resultHash = {}
  dataFields.each_with_index { |dataField, index|
    # puts " #{dataField} and csv Row Val = #{csvRow[index]} "
      resultHash["#{dataField}"]  = csvRow[index]
    }

    # puts resultHash
    return resultHash

  end


# Input will be a json object (hash) which will be mapped against the
# respective indexed value of each csvData
def validator (json, index, csvRow)

  dataType = json["data-type"]
  return util(index, dataType, csvRow)

end


def util (index, dataType, csvRow)
  if dataType == "Integer"
    return csvRow[index].is_a? Integer
  elsif dataType == "String"
    return csvRow[index].is_a? String
  else
    return false
  end
end



wrapper(jsonArray, csvData)
